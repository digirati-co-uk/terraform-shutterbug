# Shutterbug

Terraform module for backing up Elasticsearch with snapshots that are held in S3, with notifications sent to a Slack webhook.

| Variable                 | Description                                                                                                          | Default                   |
|--------------------------|----------------------------------------------------------------------------------------------------------------------|---------------------------|
| prefix                   | Prefix to give to AWS resources                                                                                      |                           |
| slack_webhook_url        | Slack Webhook URL for notifications                                                                                  |                           |
| log_group_name           | CloudWatch log group name that the container will emit logs to                                                       |                           |
| backup_identifier        | Identifier that is used to name the CloudWatch and ECS resources                                                     |                           |
| repository_name          | What to call the Elasticsearch snapshot repository                                                                   |                           |
| remove_older_than_days   | Remove snapshots that are older than this many days                                                                  |                           |
| request_timeout_seconds  | Number of seconds before a request to Elasticsearch can be said to have timed out                                    |                           |
| snapshot_timeout_seconds | Number of seconds before a snapshot request to Elasticsearch can be said to have timed out (0 to run asynchronously) |                           |
| elasticsearch_url        | The fully qualified URL of the Elasticsearch instance                                                                |                           |
| shutterbug_docker_image  | The Docker image to use for the ECS Task                                                                             | fractos/shutterbug:latest |
| region                   | AWS Region for resources                                                                                             |                           |
| s3_key_prefix            | The prefix for the S3 key to be used for backups                                                                     |                           |
| s3_bucket_name           | The name of the S3 bucket that will hold backups                                                                     |                           |
| account_id               | AWS account ID                                                                                                       |                           |
| cluster_id               | The cluster on which to run the scheduled ECS task                                                                   |                           |
| cron_expression          | Cron scheduling expression in form `cron(x x x x x x)`                                                               |                           |

## Example

```
module "backup_elasticsearch" {
  source                   = "git::https://github.com/digirati-co-uk/terraform-shutterbug.git//"
  slack_webhook_url        = "${var.slack_webhook_status}"
  log_group_name           = "${var.log_group_name}"
  prefix                   = "${var.prefix}"
  backup_identifier        = "elasticsearch"
  repository_name          = "s3_backup"
  remove_older_than_days   = "30"
  request_timeout_seconds  = "300"
  snapshot_timeout_seconds = "0"
  elasticsearch_url        = "http://elasticsearch.${var.prefix}.${var.region}.dlcs:9200"
  region                   = "${var.region}"
  s3_key_prefix            = "backups/elasticsearch"
  s3_bucket_name           = "${module.s3.bootstrap_objects_bucket}"
  account_id               = "${var.account_id}"
  cluster_id               = "${module.metropolis_cluster.cluster_id}"
  cron_expression          = "cron(0 0 * * ? *)"
}

```
