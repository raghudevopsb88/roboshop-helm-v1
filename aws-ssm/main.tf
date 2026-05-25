terraform {
  backend "s3" {
    bucket = "terraform-state-d88"
    key    = "roboshop-awsssm/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_ssm_parameter" "values" {
  count = length(var.inputs)
  name  = lookup(var.inputs[count.index], "name", "")
  type  = lookup(var.inputs[count.index], "type", "")
  value = lookup(var.inputs[count.index], "value", "")
}

variable "inputs" {
  default = [
    {
      name  = "/roboshop-cart/REDIS_HOST"
      type  = "String"
      value = "redis"
    },
    {
      name  = "/roboshop-cart/CATALOGUE_HOST"
      type  = "String"
      value = "roboshop-catalogue"
    },
    {
      name  = "/roboshop-cart/CATALOGUE_PORT"
      type  = "String"
      value = "8080"
    },
    {
      name  = "/roboshop-cart/CART_SERVER_PORT"
      type  = "String"
      value = "8080"
    },
    {
      name  = "/roboshop-catalogue/MONGO_URL"
      type  = "SecureString"
      value = "mongodb://mongodb:27017/catalogue"
    },
    {
      name  = "/roboshop-catalogue/CATALOGUE_SERVER_PORT"
      type  = "String"
      value = "8080"
    },
    {
      name  = "/roboshop-catalogue/GO_SLOW"
      type  = "String"
      value = "0"
    },
    {
      name  = "/roboshop-user/MONGO_URL"
      type  = "SecureString"
      value = "mongodb://mongodb:27017/users"
    },
    {
      name  = "/roboshop-user/REDIS_URL"
      type  = "String"
      value = "redis://redis:6379"
    },
    {
      name  = "/roboshop-user/USER_SERVER_PORT"
      type  = "String"
      value = "8080"
    },
    {
      name  = "/roboshop-payment/CART_HOST"
      type  = "String"
      value = "roboshop-cart"
    },
    {
      name  = "/roboshop-payment/CART_PORT"
      type  = "String"
      value = "8080"
    },
    {
      name  = "/roboshop-payment/USER_HOST"
      type  = "String"
      value = "roboshop-user"
    },
    {
      name  = "/roboshop-payment/USER_PORT"
      type  = "String"
      value = "8080"
    },
    {
      name  = "/roboshop-payment/AMQP_HOST"
      type  = "String"
      value = "rabbitmq"
    },
    {
      name  = "/roboshop-payment/AMQP_USER"
      type  = "String"
      value = "guest"
    },
    {
      name  = "/roboshop-payment/AMQP_PASS"
      type  = "SecureString"
      value = "guest"
    },
    {
      name  = "/roboshop-payment/PAYMENT_GATEWAY"
      type  = "String"
      value = "https://google.com/"
    },
    {
      name  = "/roboshop-payment/PAYMENT_DELAY_MS"
      type  = "String"
      value = "0"
    },
    {
      name  = "/roboshop-payment/SHOP_PAYMENT_PORT"
      type  = "String"
      value = "8080"
    },
    {
      name  = "/roboshop-shipping/DB_HOST"
      type  = "String"
      value = "mysql"
    },
    {
      name  = "/roboshop-shipping/CART_ENDPOINT"
      type  = "String"
      value = "roboshop-cart:8080"
    },
    {
      name  = "/roboshop-ratings/MYSQL_HOST"
      type  = "String"
      value = "mysql"
    },
    {
      name  = "/roboshop-ratings/MYSQL_USER"
      type  = "String"
      value = "ratings"
    },
    {
      name  = "/roboshop-ratings/MYSQL_PASSWORD"
      type  = "SecureString"
      value = "RoboShop@1"
    },
    {
      name  = "/roboshop-ratings/MYSQL_DATABASE"
      type  = "String"
      value = "ratings"
    },
    {
      name  = "/roboshop-ratings/PORT"
      type  = "String"
      value = "8080"
    },
    {
      name  = "/roboshop-frontend/CATALOGUE_HOST"
      type  = "String"
      value = "roboshop-catalogue"
    },
    {
      name  = "/roboshop-frontend/USER_HOST"
      type  = "String"
      value = "roboshop-user"
    },
    {
      name  = "/roboshop-frontend/CART_HOST"
      type  = "String"
      value = "roboshop-cart"
    },
    {
      name  = "/roboshop-frontend/SHIPPING_HOST"
      type  = "String"
      value = "roboshop-shipping"
    },
    {
      name  = "/roboshop-frontend/PAYMENT_HOST"
      type  = "String"
      value = "roboshop-payment"
    },
    {
      name  = "/roboshop-frontend/RATINGS_HOST"
      type  = "String"
      value = "roboshop-ratings"
    }
  ]
}
