# SSM Parameter Store — Roboshop Services

All parameters are sourced from `../values/*.yml` → `config_values`.
Terraform creates each entry as `/<appName>/<KEY>` in AWS SSM Parameter Store.

**Total: 42 parameters across 7 services**

---

## roboshop-cart (4)

| Parameter | Type | Value |
|-----------|------|-------|
| `/roboshop-cart/REDIS_HOST` | String | `redis` |
| `/roboshop-cart/CATALOGUE_HOST` | String | `roboshop-catalogue` |
| `/roboshop-cart/CATALOGUE_PORT` | String | `8080` |
| `/roboshop-cart/CART_SERVER_PORT` | String | `8080` |

---

## roboshop-catalogue (3)

| Parameter | Type | Value |
|-----------|------|-------|
| `/roboshop-catalogue/MONGO_URL` | SecureString | `mongodb://mongodb.dev.roboshop.internal:27017/catalogue` |
| `/roboshop-catalogue/CATALOGUE_SERVER_PORT` | String | `8080` |
| `/roboshop-catalogue/GO_SLOW` | String | `0` |

---

## roboshop-user (3)

| Parameter | Type | Value |
|-----------|------|-------|
| `/roboshop-user/MONGO_URL` | SecureString | `mongodb://mongodb:27017/users` |
| `/roboshop-user/REDIS_URL` | SecureString | `redis://redis:6379` |
| `/roboshop-user/USER_SERVER_PORT` | String | `8080` |

---

## roboshop-payment (10)

| Parameter | Type | Value |
|-----------|------|-------|
| `/roboshop-payment/CART_HOST` | String | `roboshop-cart` |
| `/roboshop-payment/CART_PORT` | String | `8080` |
| `/roboshop-payment/USER_HOST` | String | `roboshop-user` |
| `/roboshop-payment/USER_PORT` | String | `8080` |
| `/roboshop-payment/AMQP_HOST` | String | `rabbitmq` |
| `/roboshop-payment/AMQP_USER` | String | `guest` |
| `/roboshop-payment/AMQP_PASS` | SecureString | `guest` |
| `/roboshop-payment/PAYMENT_GATEWAY` | String | `https://google.com/` |
| `/roboshop-payment/PAYMENT_DELAY_MS` | String | `0` |
| `/roboshop-payment/SHOP_PAYMENT_PORT` | String | `8080` |

---

## roboshop-shipping (2)

| Parameter | Type | Value |
|-----------|------|-------|
| `/roboshop-shipping/DB_HOST` | String | `mysql` |
| `/roboshop-shipping/CART_ENDPOINT` | String | `roboshop-cart:8080` |

---

## roboshop-ratings (5)

| Parameter | Type | Value |
|-----------|------|-------|
| `/roboshop-ratings/MYSQL_HOST` | String | `mysql` |
| `/roboshop-ratings/MYSQL_USER` | String | `ratings` |
| `/roboshop-ratings/MYSQL_PASSWORD` | SecureString | `RoboShop@1` |
| `/roboshop-ratings/MYSQL_DATABASE` | String | `ratings` |
| `/roboshop-ratings/PORT` | String | `8080` |

---

## roboshop-frontend (15)

| Parameter | Type | Value |
|-----------|------|-------|
| `/roboshop-frontend/NGINX_PORT` | String | `8080` |
| `/roboshop-frontend/CATALOGUE_HOST` | String | `roboshop-catalogue` |
| `/roboshop-frontend/CATALOGUE_PORT` | String | `8080` |
| `/roboshop-frontend/USER_HOST` | String | `roboshop-user` |
| `/roboshop-frontend/USER_PORT` | String | `8080` |
| `/roboshop-frontend/CART_HOST` | String | `roboshop-cart` |
| `/roboshop-frontend/CART_PORT` | String | `8080` |
| `/roboshop-frontend/SHIPPING_HOST` | String | `roboshop-shipping` |
| `/roboshop-frontend/SHIPPING_PORT` | String | `8080` |
| `/roboshop-frontend/PAYMENT_HOST` | String | `roboshop-payment` |
| `/roboshop-frontend/PAYMENT_PORT` | String | `8080` |
| `/roboshop-frontend/RATINGS_HOST` | String | `roboshop-ratings` |
| `/roboshop-frontend/RATINGS_PORT` | String | `8080` |
| `/roboshop-frontend/ORDERS_HOST` | String | `roboshop-orders` |
| `/roboshop-frontend/ORDERS_PORT` | String | `8080` |

---

## SecureString rules

Parameters are stored as `SecureString` when the key is:
- Exactly `MONGO_URL` or `REDIS_URL`
- Ends with `PASSWORD`, `SECRET`, `TOKEN`, or `PASS`

All other keys use `String`.

---

## Apply

```shell
cd terraform
make init
make plan
make apply
```

When you update a value in `values/<service>.yml`, re-run `terraform apply` to sync Parameter Store.
