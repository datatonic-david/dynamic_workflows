provider "google" {
  project = var.project_id
}

resource "google_service_account" "workflow_service_account" {
  account_id   = "workflows-sa"
  display_name = "Workflow Serice Account"
}

resource "google_bigquery_dataset" "dataset" {
  project       = var.project_id
  dataset_id    = var.google_bigquery_dataset_name
  friendly_name = var.google_bigquery_dataset_name
  description   = ""
  location      = "US"
}

resource "google_project_iam_member" "project" {
  for_each = var.service_account_roles

  project = var.project_id
  role    = "roles/${each.value}"
  member  = "serviceAccount:${google_service_account.workflow_service_account.email}"
}

resource "google_project_service" "workflows" {
  service            = "workflows.googleapis.com"
  disable_on_destroy = false
}

resource "google_workflows_workflow" "workflow" {
  for_each        = var.workflows
  name            = each.value.name
  region          = var.location
  description     = ""
  service_account = google_service_account.workflow_service_account.id
  project         = var.project_id
  source_contents = templatefile(each.value.workflow_yaml, each.value.workflow_template_params)
  depends_on = [
    google_project_service.workflows,
    google_bigquery_dataset.dataset
  ]
}
