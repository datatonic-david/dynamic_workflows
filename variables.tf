variable "project_id" {
  type        = string
  description = "Numerical Id for project"
}

variable "location" {
  type        = string
  description = "Region where cloud run would execute"
  default     = "us-east1"
}

variable "gs_bucket_name" {
  type        = string
  description = "Name for gs bucket"
  default     = "dynamic_workflows"
}

variable "service_account_roles" {
  type        = set(string)
  description = "service account roles"
  default     = [
    "bigquery.admin",
    "logging.admin"
  ]
}

variable "google_bigquery_dataset_name" {
  type        = string
  description = "Name for bigquery dataset"
}

variable "workflow_yaml" {
  type        = string
  description = "YAML input file for workflow"
  default     = null
}

variable "workflow_template_params" {
  description = "Workflow parameters"
  type        = map(any)
  default     = {}
}

variable "workflows" {
  description = "Map of workflows."
  type = map(object({
    name                     = string
    workflow_yaml            = string
    workflow_template_params = map(string)
  }))
}
