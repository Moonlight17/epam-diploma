terraform {
  backend "s3" {
    bucket = "my-epam-diploma-bucket-serov"
    key    = "tf-states/route53-state.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = var.region
}

data "aws_lb" "ingress" {
    # name = "ingress"
}

resource "aws_route53_record" "prod" {
  zone_id = var.zoneid
  name    = "prod.serov-diploma.tk"
  type    = "A"

  alias {
    name                   = data.aws_lb.ingress.dns_name
    zone_id                = data.aws_lb.ingress.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "staging" {
  zone_id = "Z10148663S9VASAQXPSXS"
  name    = "staging.serov-diploma.tk"
  type    = "A"

  alias {
    name                   = data.aws_lb.ingress.dns_name
    zone_id                = data.aws_lb.ingress.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "sonarqube" {
  zone_id = "Z10148663S9VASAQXPSXS"
  name    = "sonarqube.serov-diploma.tk"
  type    = "A"

  alias {
    name                   = data.aws_lb.ingress.dns_name
    zone_id                = data.aws_lb.ingress.zone_id
    evaluate_target_health = true
  }
}
