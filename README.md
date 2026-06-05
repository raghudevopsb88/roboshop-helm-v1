# roboshop-helm-v1

Helm charts for Roboshop microservices, based on [wmp-helm-v2](https://github.com/raghudevopsb88/wmp-helm-v2).

## Services

| Values file | Service | Port |
|-------------|---------|------|
| `values/roboshop-cart.yml` | Cart API | 8080 |
| `values/roboshop-catalogue.yml` | Catalogue API | 8080 |
| `values/roboshop-user.yml` | User API | 8080 |
| `values/roboshop-payment.yml` | Payment API | 8080 |
| `values/roboshop-shipping.yml` | Shipping API | 8080 |
| `values/roboshop-ratings.yml` | Ratings API | 8080 |
| `values/roboshop-orders.yml` | Orders API | 8080 |
| `values/roboshop-frontend.yml` | Web frontend (nginx) | 8080 |

## Install

```shell
make helm-install component=roboshop-cart image_tag=<git-sha>
# or
helm upgrade --install roboshop-cart . -f values.yaml -f values/roboshop-cart.yml --set image_tag=<git-sha>
```

All services use **startup**, **readiness**, and **liveness** HTTP probes (defaults in `values.yaml`; frontend overrides path to `/nginx-health`).

Rollouts are **slow and one pod at a time** (`values.yaml`): `maxSurge: 1`, `maxUnavailable: 0`, `minReadySeconds: 15` — a new pod must pass probes and stay Ready for 15s before the next old pod is removed. Tune `minReadySeconds` for slower/faster rollouts.

## AWS SSM parameters

All 42 parameters are hardcoded in `terraform/main.tf`. Edit values there, then apply:

```shell
cd terraform
make init
make apply
```

The `ssm-pull` init container reads parameters listed in each service's `PARAMS` value at deploy time.

## Database setup Jobs

Services with schema/master-data scripts run a Helm pre-install/pre-upgrade Job using a separate `-db` image:

| Service | DB type | Scripts |
|---------|---------|---------|
| roboshop-catalogue | MongoDB | `master-data.js` |
| roboshop-shipping | MySQL | `schema.sql`, `app-user.sql`, `master-data.sql` |
| roboshop-ratings | MySQL | `schema.sql`, `app-user.sql` |

Enable in values with:

```yaml
dbJob:
  enabled: true
  PARAMS: "MYSQL_HOST MYSQL_ROOT_PASSWORD"
```

Image: `739561048503.dkr.ecr.us-east-1.amazonaws.com/<service>-db:latest` (always pulled with `imagePullPolicy: Always`)
