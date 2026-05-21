# Design Document

## GCP Support

The current implementation is designed around AWS-compatible infrastructure using LocalStack and Terraform.

Future GCP support can be added by:

- Adding Terraform Google provider
- Creating separate Terraform modules for GCP resources
- Supporting GCP services such as:
  - VPC networks
  - Cloud Storage buckets
  - Compute Engine instances
- Extending the Python janitor tool to scan GCP orphan resources

Possible future structure:

```text
terraform/
├── modules/
│   ├── aws/
│   └── gcp/
```

---

## IAM Permissions

For real AWS environments, the following IAM permissions would be required:

### Terraform

- ec2:*
- s3:*
- iam:PassRole

### Janitor Tool

Read-only permissions:
- ec2:Describe*
- s3:List*
- cloudwatch:GetMetricData

Optional delete permissions:
- ec2:DeleteVolume
- s3:DeleteBucket

Principle followed:
- Least privilege access

---

## Safety

The project includes several safety considerations:

- Uses LocalStack instead of real AWS
- No production credentials required
- Auto-delete is disabled by default
- Janitor marks resources as:
  - safe_to_auto_delete = false

Additional future safety improvements:
- Approval workflows
- Resource tagging validation
- Protected resource lists
- Dry-run mode

---

## Metrics

Potential operational metrics include:

### Infrastructure Metrics
- Number of orphan resources
- Monthly estimated waste
- Terraform apply duration

### Janitor Metrics
- Scan duration
- Resources scanned
- Resources flagged
- Cleanup recommendations generated

### CI/CD Metrics
- Workflow success/failure rate
- Deployment duration

---

## Limitations

Current limitations of the project:

- Local-only environment
- No real AWS account integration
- Static janitor findings
- No database backend
- Limited resource coverage
- Minimal monitoring/logging
- Simplified Terraform architecture

The project is intended as a DevOps learning and demonstration environment rather than a production-ready platform.