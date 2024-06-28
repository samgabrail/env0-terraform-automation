# Overview
How to use env0 in a mature Terraform organization

Our demo shows how a mature organization would use env0 for the following:
- Custom flows in env0's pipeline for Terraform
- env0's workflows for building one environment that depends on another
- Incorporating policy as code with OPA
- Using cost control
- Auto drift detection and remediation


- For custom flow I only use checkov demo.
- The workflow I have is in workflows folder. It's all fake tf resources..
- For policies. I have a new repo and policy I'm building in github.com/env0/acme-fitness/policy
- Auto drift remediation. I have a blog post on that: https://www.env0.com/blog/tutorial-achieving-auto-remediation-with-env0 

