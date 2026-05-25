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
| `values/roboshop-frontend.yml` | Web frontend (nginx) | 8080 |

## Install

```shell
make helm-install component=roboshop-cart
helm upgrade -i roboshop-cart . -f values/roboshop-cart.yml --set image_tag=<git-sha>
```

## AWS SSM parameters

Parameter definitions live in `aws-ssm/main.tf`. Apply with:

```shell
cd aws-ssm
make def
```

The `ssm-pull` init container reads parameters listed in each service's `PARAMS` value at deploy time.
