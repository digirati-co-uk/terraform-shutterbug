variable "slack_webhook_url" {}
variable "log_group_name" {}
variable "prefix" {}
variable "backup_identifier" {}
variable "region" {}
variable "elasticsearch_url" {}
variable "repository_name" {}
variable "remove_older_than_days" {}
variable "snapshot_timeout_seconds" {}
variable "request_timeout_seconds" {}

variable "shutterbug_docker_image" {
  default = "fractos/shutterbug:latest"
}

variable "s3_bucket_name" {}
variable "s3_key_prefix" {}
variable "account_id" {}
variable "cluster_id" {}
variable "cron_expression" {}
