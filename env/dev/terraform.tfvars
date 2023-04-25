project_id                   = "dt-gsk-finops-dev"
location                     = "us-east1"
google_bigquery_dataset_name = "dynamic_workflows"

workflows = {
  basic = {
    name          = "basic"
    workflow_yaml = "workflows/basic.tpl"
    workflow_template_params = {
      PROJECT_ID = "dt-gsk-finops-dev"
      QUERY      = <<-EOT
SELECT
  table_name
FROM
  `bigquery-samples.wikipedia_pageviews.INFORMATION_SCHEMA.TABLES`;
EOT
    }
  }
  concurrent_parameterized = {
    name          = "concurrent_parameterized"
    workflow_yaml = "workflows/concurrent_parameterized.tpl"
    workflow_template_params = {
      PROJECT_ID        = "dt-gsk-finops-dev"
      CONCURRENCY_LIMIT = 3
    }
  }
  dynamic = {
    name          = "dynamic"
    workflow_yaml = "workflows/dynamic.tpl"
    workflow_template_params = {
      PROJECT_ID = "dt-gsk-finops-dev"
      QUERY      = <<-EOT
SELECT
  table_name
FROM
  `bigquery-samples.wikipedia_pageviews.INFORMATION_SCHEMA.TABLES`
WHERE table_name like '%2008%';
EOT
    }
  }
}
