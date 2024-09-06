resource "kubernetes_manifest" "namespace_gitlab_runner_system" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Namespace"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "controller-manager"
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/name" = "gitlab-runner-operator"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-system"
    }
  }
}

resource "kubernetes_manifest" "customresourcedefinition_runners_apps_gitlab_com" {
  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind" = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.14.0"
      }
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "runners.apps.gitlab.com"
    }
    "spec" = {
      "group" = "apps.gitlab.com"
      "names" = {
        "kind" = "Runner"
        "listKind" = "RunnerList"
        "plural" = "runners"
        "singular" = "runner"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "name" = "v1beta2"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "Runner is the open source project used to run your jobs and send the results back to GitLab"
              "properties" = {
                "apiVersion" = {
                  "description" = <<-EOT
                  APIVersion defines the versioned schema of this representation of an object.
                  Servers should convert recognized schemas to the latest internal value, and
                  may reject unrecognized values.
                  More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
                  EOT
                  "type" = "string"
                }
                "kind" = {
                  "description" = <<-EOT
                  Kind is a string value representing the REST resource this object represents.
                  Servers may infer this from the endpoint the client submits requests to.
                  Cannot be updated.
                  In CamelCase.
                  More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
                  EOT
                  "type" = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "Specification of the desired behavior of a GitLab Runner instance"
                  "properties" = {
                    "azure" = {
                      "description" = <<-EOT
                      options used to setup Azure blob
                      storage as GitLab Runner Cache
                      EOT
                      "properties" = {
                        "container" = {
                          "description" = "Name of the Azure container in which the cache will be stored"
                          "type" = "string"
                        }
                        "credentials" = {
                          "description" = <<-EOT
                          Credentials secret contains 'accountName' and 'privateKey'
                          used to authenticate against Azure blob storage
                          EOT
                          "type" = "string"
                        }
                        "storageDomain" = {
                          "description" = <<-EOT
                          The domain name of the Azure blob storage
                          e.g. blob.core.windows.net
                          EOT
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "buildImage" = {
                      "description" = <<-EOT
                      The name of the default image to use to run
                      build jobs, when none is specified
                      EOT
                      "type" = "string"
                    }
                    "ca" = {
                      "description" = <<-EOT
                      Name of tls secret containing the custom certificate
                      authority (CA) certificates
                      EOT
                      "type" = "string"
                    }
                    "cachePath" = {
                      "description" = "Path defines the Runner Cache path"
                      "type" = "string"
                    }
                    "cacheShared" = {
                      "description" = "Enable sharing of cache between Runners"
                      "type" = "boolean"
                    }
                    "cacheType" = {
                      "description" = <<-EOT
                      Type of cache used for Runner artifacts
                      Options are: gcs, s3, azure
                      EOT
                      "type" = "string"
                    }
                    "cloneURL" = {
                      "description" = "If specified, overrides the default URL used to clone or fetch the Git ref"
                      "type" = "string"
                    }
                    "concurrent" = {
                      "description" = <<-EOT
                      Option to limit the number of jobs globally that can run concurrently.
                      The operator sets this to 10, if not specified
                      EOT
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "config" = {
                      "description" = <<-EOT
                      allow user to provide configmap name
                      containing the user provided config.toml
                      EOT
                      "type" = "string"
                    }
                    "env" = {
                      "description" = <<-EOT
                      Accepts configmap name. Provides user mechanism to inject environment
                      variables in the GitLab Runner pod via the key value pairs in the ConfigMap
                      EOT
                      "type" = "string"
                    }
                    "gcs" = {
                      "description" = <<-EOT
                      options used to setup GCS (Google
                      Container Storage) as GitLab Runner Cache
                      EOT
                      "properties" = {
                        "bucket" = {
                          "description" = "Name of the bucket in which the cache will be stored"
                          "type" = "string"
                        }
                        "credentials" = {
                          "description" = "contains the GCS 'access-id' and 'private-key'"
                          "type" = "string"
                        }
                        "credentialsFile" = {
                          "description" = "Takes GCS credentials file, 'keys.json'"
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "gitlabUrl" = {
                      "description" = <<-EOT
                      The fully qualified domain name for the GitLab instance.
                      For example, https://gitlab.example.com
                      EOT
                      "type" = "string"
                    }
                    "helperImage" = {
                      "description" = "If specified, overrides the default GitLab Runner helper image"
                      "type" = "string"
                    }
                    "imagePullPolicy" = {
                      "description" = <<-EOT
                      ImagePullPolicy sets the Image pull policy.
                      One of Always, Never, IfNotPresent.
                      Defaults to Always if :latest tag is specified, or IfNotPresent otherwise.
                      More info: https://kubernetes.io/docs/concepts/containers/images#updating-images
                      EOT
                      "type" = "string"
                    }
                    "interval" = {
                      "description" = <<-EOT
                      Option to define the number of seconds between checks for new jobs.
                      This is set to a default of 30s by operator if not set
                      EOT
                      "format" = "int32"
                      "type" = "integer"
                    }
                    "locked" = {
                      "description" = "Specify whether the runner should be locked to a specific project. Defaults to false."
                      "type" = "boolean"
                    }
                    "podSpec" = {
                      "items" = {
                        "description" = <<-EOT
                        KubernetesPodSpec represents the structure expected when adding a custom PodSpec to configure
                        the Pod running the GitLab Runner Manager
                        EOT
                        "properties" = {
                          "name" = {
                            "description" = "Name is the name given to the custom Pod Spec"
                            "type" = "string"
                          }
                          "patch" = {
                            "description" = <<-EOT
                            A JSON or YAML format string that describes the changes which must be applied
                            to the final PodSpec object before it is generated.
                            You cannot set the patch_path and patch in the same pod_spec configuration, otherwise an error occurs.
                            EOT
                            "type" = "string"
                          }
                          "patchFile" = {
                            "description" = <<-EOT
                            Path to the file that defines the changes to apply to the final PodSpec object before it is generated.
                            The file must be a JSON or YAML file.
                            You cannot set the patch_path and patch in the same pod_spec configuration, otherwise an error occurs.
                            EOT
                            "type" = "string"
                          }
                          "patchType" = {
                            "description" = <<-EOT
                            The strategy the runner uses to apply the specified changes to the PodSpec object generated by GitLab Runner.
                            The accepted values are merge, json, and strategic (default value).
                            EOT
                            "type" = "string"
                          }
                        }
                        "required" = [
                          "name",
                          "patchType",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "protected" = {
                      "description" = "Specify whether the runner should only run protected branches. Defaults to false."
                      "type" = "boolean"
                    }
                    "runUntagged" = {
                      "description" = <<-EOT
                      Specify if jobs without tags should be run.
                      If not specified, runner will default to true if no tags were specified.
                      In other case it will default to false.
                      EOT
                      "type" = "boolean"
                    }
                    "runnerImage" = {
                      "description" = "If specified, overrides the default GitLab Runner image. Default is the Runner image the operator was bundled with."
                      "type" = "string"
                    }
                    "s3" = {
                      "description" = <<-EOT
                      options used to setup S3
                      object store as GitLab Runner Cache
                      EOT
                      "properties" = {
                        "bucket" = {
                          "description" = "Name of the bucket in which the cache will be stored"
                          "type" = "string"
                        }
                        "credentials" = {
                          "description" = <<-EOT
                          Name of the secret containing the
                          'accesskey' and 'secretkey' used to access the object storage
                          EOT
                          "type" = "string"
                        }
                        "insecure" = {
                          "description" = "Use insecure connections or HTTP"
                          "type" = "boolean"
                        }
                        "location" = {
                          "description" = "Name of the S3 region in use"
                          "type" = "string"
                        }
                        "server" = {
                          "type" = "string"
                        }
                      }
                      "type" = "object"
                    }
                    "serviceaccount" = {
                      "description" = <<-EOT
                      allow user to override service account
                      used by GitLab Runner
                      EOT
                      "type" = "string"
                    }
                    "tags" = {
                      "description" = <<-EOT
                      List of comma separated tags to be applied to the runner
                      More info: https://docs.gitlab.com/ee/ci/runners/#use-tags-to-limit-the-number-of-jobs-using-the-runner
                      EOT
                      "type" = "string"
                    }
                    "token" = {
                      "description" = "Name of secret containing the 'runner-registration-token' key used to register the runner"
                      "type" = "string"
                    }
                  }
                  "required" = [
                    "gitlabUrl",
                    "token",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "description" = <<-EOT
                  Most recently observed status of the GitLab Runner.
                  It is read-only to the user
                  EOT
                  "properties" = {
                    "message" = {
                      "description" = "Additional information of GitLab Runner registration"
                      "type" = "string"
                    }
                    "phase" = {
                      "description" = "Reports status of the GitLab Runner instance"
                      "type" = "string"
                    }
                    "registration" = {
                      "description" = "Reports status of GitLab Runner registration"
                      "type" = "string"
                    }
                  }
                  "type" = "object"
                }
              }
              "type" = "object"
            }
          }
          "served" = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}

resource "kubernetes_manifest" "serviceaccount_gitlab_runner_system_gitlab_runner_sa" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-sa"
      "namespace" = var.namespace
    }
  }
}

resource "kubernetes_manifest" "role_gitlab_runner_system_gitlab_runner_app_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-app-role"
      "namespace" = var.namespace
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
          "pods",
          "services",
          "services/status",
          "services/proxy",
          "services/finalizers",
          "pods/attach",
          "pods/exec",
          "pods/log",
          "persistentvolumeclaims",
          "configmaps",
        ]
        "verbs" = [
          "create",
          "get",
          "list",
          "watch",
          "delete",
          "patch",
          "update",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "role_gitlab_runner_system_gitlab_runner_leader_election_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-leader-election-role"
      "namespace" = var.namespace
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "patch",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps/status",
        ]
        "verbs" = [
          "get",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "coordination.k8s.io",
        ]
        "resources" = [
          "leases",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "patch",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_gitlab_runner_manager_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-manager-role"
    }
    "rules" = [
      {
        "apiGroups" = [
          "apps",
        ]
        "resources" = [
          "deployments",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apps.gitlab.com",
        ]
        "resources" = [
          "runners",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apps.gitlab.com",
        ]
        "resources" = [
          "runners/finalizers",
        ]
        "verbs" = [
          "delete",
          "patch",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "apps.gitlab.com",
        ]
        "resources" = [
          "runners/status",
        ]
        "verbs" = [
          "get",
          "patch",
          "update",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "persistentvolumeclaims",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods/attach",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods/exec",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "pods/log",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "resourcequotas",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "serviceaccounts",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "services",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "services/finalizers",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "services/proxy",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "services/status",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "rbac.authorization.k8s.io",
        ]
        "resources" = [
          "rolebindings",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "rbac.authorization.k8s.io",
        ]
        "resources" = [
          "roles",
        ]
        "verbs" = [
          "create",
          "delete",
          "get",
          "list",
          "patch",
          "update",
          "watch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_gitlab_runner_metrics_reader" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-metrics-reader"
    }
    "rules" = [
      {
        "nonResourceURLs" = [
          "/metrics",
        ]
        "verbs" = [
          "get",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrole_gitlab_runner_proxy_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-proxy-role"
    }
    "rules" = [
      {
        "apiGroups" = [
          "authentication.k8s.io",
        ]
        "resources" = [
          "tokenreviews",
        ]
        "verbs" = [
          "create",
        ]
      },
      {
        "apiGroups" = [
          "authorization.k8s.io",
        ]
        "resources" = [
          "subjectaccessreviews",
        ]
        "verbs" = [
          "create",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_gitlab_runner_system_gitlab_runner_app_rolebinding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-app-rolebinding"
      "namespace" = var.namespace
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "gitlab-runner-app-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "gitlab-runner-sa"
        "namespace" = var.namespace
      },
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_gitlab_runner_system_gitlab_runner_leader_election_rolebinding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-leader-election-rolebinding"
      "namespace" = var.namespace
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
      "name" = "gitlab-runner-leader-election-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "gitlab-runner-sa"
        "namespace" = var.namespace
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_gitlab_runner_manager_rolebinding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-manager-rolebinding"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "gitlab-runner-manager-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "gitlab-runner-sa"
        "namespace" = var.namespace
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_gitlab_runner_proxy_rolebinding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-proxy-rolebinding"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "gitlab-runner-proxy-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "default"
        "namespace" = var.namespace
      },
    ]
  }
}

resource "kubernetes_manifest" "service_gitlab_runner_system_gitlab_runner_controller_manager_metrics_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "controller-manager"
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/name" = "gitlab-runner-operator"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-controller-manager-metrics-service"
      "namespace" = var.namespace
    }
    "spec" = {
      "ports" = [
        {
          "name" = "https"
          "port" = 8443
          "targetPort" = "https"
        },
      ]
      "selector" = {
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/name" = "gitlab-runner-operator"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
    }
  }
}

resource "kubernetes_manifest" "deployment_gitlab_runner_system_gitlab_runner_gitlab_runnercontroller_manager" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/component" = "controller-manager"
        "app.kubernetes.io/created-by" = "gitlab-runner-operator"
        "app.kubernetes.io/managed-by" = "kustomize"
        "app.kubernetes.io/name" = "gitlab-runner-operator"
        "app.kubernetes.io/part-of" = "gitlab-runner-operator"
      }
      "name" = "gitlab-runner-gitlab-runnercontroller-manager"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app.kubernetes.io/created-by" = "gitlab-runner-operator"
          "app.kubernetes.io/managed-by" = "kustomize"
          "app.kubernetes.io/name" = "gitlab-runner-operator"
          "app.kubernetes.io/part-of" = "gitlab-runner-operator"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app.kubernetes.io/component" = "controller-manager"
            "app.kubernetes.io/created-by" = "gitlab-runner-operator"
            "app.kubernetes.io/managed-by" = "kustomize"
            "app.kubernetes.io/name" = "gitlab-runner-operator"
            "app.kubernetes.io/part-of" = "gitlab-runner-operator"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--secure-listen-address=0.0.0.0:8443",
                "--upstream=http://127.0.0.1:8080/",
                "--logtostderr=true",
                "--v=10",
              ]
              "image" = "registry.gitlab.com/gitlab-org/gl-openshift/gitlab-runner-operator/openshift4/ose-kube-rbac-proxy:v4.13.0"
              "name" = "kube-rbac-proxy"
              "ports" = [
                {
                  "containerPort" = 8443
                  "name" = "https"
                },
              ]
            },
            {
              "args" = [
                "--metrics-addr=127.0.0.1:8080",
                "--enable-leader-election",
              ]
              "command" = [
                "/manager",
              ]
              "env" = [
                {
                  "name" = "ENABLE_WEBHOOKS"
                  "value" = "false"
                },
                {
                  "name" = "OPERATOR_NAMESPACE"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
                {
                  "name" = "KUBERNETES_NAMESPACE"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
                {
                  "name" = "WATCH_NAMESPACES"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
              ]
              "image" = "registry.gitlab.com/gitlab-org/gl-openshift/gitlab-runner-operator/gitlab-runner-operator:v1.23.2"
              "name" = "manager"
              "resources" = {
                "limits" = {
                  "cpu" = "150m"
                  "memory" = "300Mi"
                }
                "requests" = {
                  "cpu" = "100m"
                  "memory" = "180Mi"
                }
              }
            },
          ]
          "serviceAccountName" = "gitlab-runner-sa"
          "terminationGracePeriodSeconds" = 10
        }
      }
    }
  }
}
