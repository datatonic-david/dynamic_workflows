# Dynamic workflows

```sh
export GOOGLE_APPLICATION_CREDENTIALS=key.json
terraform init -reconfigure -var-file=env/dev/terraform.tfvars -backend-config=env/dev/backend.conf
```
