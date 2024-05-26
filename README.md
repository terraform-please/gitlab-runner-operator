# GitLab Runner Operator Terraform Module

This repository contains one-to-one converted versions of
the [GitLab Runner Operator](https://gitlab.com/gitlab-org/gl-openshift/gitlab-runner-operator) kubectl manifests into
native HCL Terraform format.

## Context

Terraform is a powerful tool for managing infrastructure as code. However, many Kubernetes applications provide their
configurations as kubectl manifests, which cannot be used directly with Terraform. This project converts those
Kubernetes manifests into Terraform configurations, allowing you to manage your Kubernetes resources alongside the rest
of your infrastructure using Terraform.

## Features

* Direct conversions from YAML to HCL
* Organized by version tags
* Easy integration into your Terraform workflows

## Using with Terraform

```hcl
module "gitlab_runner_operator" {
  source = "git::https://github.com/terraform-please/gitlab-runner-operator.git//v1.25.0"
}
```

## Using with CDKTF

Update cdktf.json to include the module:

```json
{
  "terraformModules": [
    {
      "name": "gitlab-runner-operator",
      "source": "git::https://github.com/terraform-please/gitlab-runner-operator.git//v1.25.0"
    }
  ]
}
```

Then run `cdktf get` to download the module.

Use the module in your Typescript code:

```typescript
import {GitlabRunnerOperator} from "@gen/modules/gitlab-runner-operator";

new GitlabRunnerOperator(this, "gitlab_runner_operator", {
    namespace: "default",
})
```

## Contributing

Feel free to open issues or pull requests for improvements or fixes.
