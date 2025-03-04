# TerraformGCPAuth
This is a small demo project to showcase how to use Terraform to create Google Cloud project with Firebase Auth enabled

This demo project shows how to fix the following error:

```
google_identity_platform_config.auth: Creating...
╷
│ Error: Error creating Config: googleapi: Error 403: Your application is authenticating by using local Application Default Credentials. The identitytoolkit.googleapis.com API requires a quota project, which is not set by default. To learn how to set your quota project, see https://cloud.google.com/docs/authentication/adc-troubleshooting/user-creds .
│ Details:
│ [
│   {
│     "@type": "type.googleapis.com/google.rpc.ErrorInfo",
│     "domain": "googleapis.com",
│     "metadata": {
│       "consumer": "projects/000000000000",
│       "service": "identitytoolkit.googleapis.com"
│     },
│     "reason": "SERVICE_DISABLED"
│   },
│   {
│     "@type": "type.googleapis.com/google.rpc.LocalizedMessage",
│     "locale": "en-US",
│     "message": "Your application is authenticating by using local Application Default Credentials. The identitytoolkit.googleapis.com API requires a quota project, which is not set by default. To learn how to set your quota project, see https://cloud.google.com/docs/authentication/adc-troubleshooting/user-creds ."
```

1. Install terraform
2. Checkout the repository
3. Open the `infra` folder in the terminal. Make sure to replace the project id and name, the billing account with your own.
4. Run `terraform init` command. Expected output is:

```
Initializing the backend...
Initializing provider plugins...
- Finding hashicorp/google-beta versions matching "~> 6.24"...
- Finding latest version of hashicorp/google...
- Installing hashicorp/google-beta v6.24.0...
- Installed hashicorp/google-beta v6.24.0 (signed by HashiCorp)
- Installing hashicorp/google v6.24.0...
- Installed hashicorp/google v6.24.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
5. Run `terraform plan` command. Expected output:
```
PS C:\Work\git\gindemit\apidef\TerraformGCPAuth\infra> terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_firebase_android_app.auth will be created
  + resource "google_firebase_android_app" "auth" {
      + api_key_id      = (known after apply)
      + app_id          = (known after apply)
      + deletion_policy = "DELETE"
      + display_name    = "My Android app"
      + etag            = (known after apply)
      + id              = (known after apply)
      + name            = (known after apply)
      + package_name    = "android.package.name"
      + project         = "test-project-1"
    }

  # google_firebase_apple_app.auth will be created
  + resource "google_firebase_apple_app" "auth" {
      + api_key_id      = (known after apply)
      + app_id          = (known after apply)
      + bundle_id       = "apple.app.12345"
      + deletion_policy = "DELETE"
      + display_name    = "My Apple app"
      + id              = (known after apply)
      + name            = (known after apply)
      + project         = "test-project-1"
    }

  # google_firebase_project.auth will be created
  + resource "google_firebase_project" "auth" {
      + display_name   = (known after apply)
      + id             = (known after apply)
      + project        = "test-project-1"
      + project_number = (known after apply)
    }

  # google_firebase_web_app.auth will be created
  + resource "google_firebase_web_app" "auth" {
      + api_key_id      = (known after apply)
      + app_id          = (known after apply)
      + app_urls        = (known after apply)
      + deletion_policy = "DELETE"
      + display_name    = "My Web app"
      + id              = (known after apply)
      + name            = (known after apply)
      + project         = "test-project-1"
    }

  # google_identity_platform_config.auth will be created
  + resource "google_identity_platform_config" "auth" {
      + authorized_domains         = [
          + "localhost",
          + "test-project-1.firebaseapp.com",
          + "test-project-1.web.app",
        ]
      + autodelete_anonymous_users = true
      + id                         = (known after apply)
      + name                       = (known after apply)
      + project                    = "test-project-1"

      + blocking_functions {
          + forward_inbound_credentials {
              + access_token  = true
              + id_token      = true
              + refresh_token = true
            }
          + triggers {
              + event_type   = "beforeSignIn"
              + function_uri = "https://us-east1-test-project-1.cloudfunctions.net/before-sign-in"
              + update_time  = (known after apply)
            }
        }

      + client (known after apply)

      + mfa (known after apply)

      + monitoring (known after apply)

      + quota {
          + sign_up_quota_config {
              + quota          = 100
              + quota_duration = "7200s"
              + start_time     = (known after apply)
            }
        }

      + sign_in {
          + allow_duplicate_emails = true
          + hash_config            = (known after apply)

          + anonymous {
              + enabled = true
            }

          + email {
              + enabled           = true
              + password_required = false
            }
        }

      + sms_region_config {
          + allowlist_only {
              + allowed_regions = [
                  + "US",
                  + "CA",
                ]
            }
        }
    }

  # google_project.auth will be created
  + resource "google_project" "auth" {
      + auto_create_network = true
      + billing_account     = "016E62-900E43-A15770"
      + deletion_policy     = "PREVENT"
      + effective_labels    = {
          + "firebase"                   = "enabled"
          + "goog-terraform-provisioned" = "true"
        }
      + id                  = (known after apply)
      + labels              = {
          + "firebase" = "enabled"
        }
      + name                = "API Definition Test Project 3"
      + number              = (known after apply)
      + org_id              = "77907885426"
      + project_id          = "test-project-1"
      + terraform_labels    = {
          + "firebase"                   = "enabled"
          + "goog-terraform-provisioned" = "true"
        }
    }

  # google_project_iam_member.tf_service_account_role will be created
  + resource "google_project_iam_member" "tf_service_account_role" {
      + etag    = (known after apply)
      + id      = (known after apply)
      + member  = "serviceAccount:tf-service-account@test-project-1.iam.gserviceaccount.com"
      + project = "test-project-1"
      + role    = "roles/editor"
    }

  # google_project_service.auth["cloudbilling.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "cloudbilling.googleapis.com"
    }

  # google_project_service.auth["cloudresourcemanager.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "cloudresourcemanager.googleapis.com"
    }

  # google_project_service.auth["iam.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "iam.googleapis.com"
    }

  # google_project_service.auth["identitytoolkit.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "identitytoolkit.googleapis.com"
    }

  # google_project_service.auth["serviceusage.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "serviceusage.googleapis.com"
    }

  # google_service_account.tf_service_account will be created
  + resource "google_service_account" "tf_service_account" {
      + account_id   = "tf-service-account"
      + disabled     = false
      + display_name = "Terraform Service Account"
      + email        = "tf-service-account@test-project-1.iam.gserviceaccount.com"
      + id           = (known after apply)
      + member       = "serviceAccount:tf-service-account@test-project-1.iam.gserviceaccount.com"
      + name         = (known after apply)
      + project      = "test-project-1"
      + unique_id    = (known after apply)
    }

Plan: 13 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.

```

6. Run the `gcloud auth application-default login` command. Make sure you have the necessary permission in Google Cloud platform. If you just created your google account, make sure to create a new Firebase project using Firebase Web Dashboard to accept all neccessary license aggrements and policies (in other case you can get the 403 error)

7. Make sure your accout has the `Service Account Admin` permission in the https://console.cloud.google.com/iam-admin/iam

8. Run `terraform apply` command. Expected output:

```
PS C:\Work\git\gindemit\apidef\TerraformGCPAuth\infra> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_firebase_android_app.auth will be created
  + resource "google_firebase_android_app" "auth" {
      + api_key_id      = (known after apply)
      + app_id          = (known after apply)
      + deletion_policy = "DELETE"
      + display_name    = "My Android app"
      + etag            = (known after apply)
      + id              = (known after apply)
      + name            = (known after apply)
      + package_name    = "android.package.name"
      + project         = "test-project-1"
    }

  # google_firebase_apple_app.auth will be created
  + resource "google_firebase_apple_app" "auth" {
      + api_key_id      = (known after apply)
      + app_id          = (known after apply)
      + bundle_id       = "apple.app.12345"
      + deletion_policy = "DELETE"
      + display_name    = "My Apple app"
      + id              = (known after apply)
      + name            = (known after apply)
      + project         = "test-project-1"
    }

  # google_firebase_project.auth will be created
  + resource "google_firebase_project" "auth" {
      + display_name   = (known after apply)
      + id             = (known after apply)
      + project        = "test-project-1"
      + project_number = (known after apply)
    }

  # google_firebase_web_app.auth will be created
  + resource "google_firebase_web_app" "auth" {
      + api_key_id      = (known after apply)
      + app_id          = (known after apply)
      + app_urls        = (known after apply)
      + deletion_policy = "DELETE"
      + display_name    = "My Web app"
      + id              = (known after apply)
      + name            = (known after apply)
      + project         = "test-project-1"
    }

  # google_identity_platform_config.auth will be created
  + resource "google_identity_platform_config" "auth" {
      + authorized_domains         = [
          + "localhost",
          + "test-project-1.firebaseapp.com",
          + "test-project-1.web.app",
        ]
      + autodelete_anonymous_users = true
      + id                         = (known after apply)
      + name                       = (known after apply)
      + project                    = "test-project-1"

      + blocking_functions {
          + forward_inbound_credentials {
              + access_token  = true
              + id_token      = true
              + refresh_token = true
            }
          + triggers {
              + event_type   = "beforeSignIn"
              + function_uri = "https://us-east1-test-project-1.cloudfunctions.net/before-sign-in"
              + update_time  = (known after apply)
            }
        }

      + client (known after apply)

      + mfa (known after apply)

      + monitoring (known after apply)

      + quota {
          + sign_up_quota_config {
              + quota          = 100
              + quota_duration = "7200s"
              + start_time     = (known after apply)
            }
        }

      + sign_in {
          + allow_duplicate_emails = true
          + hash_config            = (known after apply)

          + anonymous {
              + enabled = true
            }

          + email {
              + enabled           = true
              + password_required = false
            }
        }

      + sms_region_config {
          + allowlist_only {
              + allowed_regions = [
                  + "US",
                  + "CA",
                ]
            }
        }
    }

  # google_project.auth will be created
  + resource "google_project" "auth" {
      + auto_create_network = true
      + billing_account     = "016E62-900E43-A15770"
      + deletion_policy     = "PREVENT"
      + effective_labels    = {
          + "firebase"                   = "enabled"
          + "goog-terraform-provisioned" = "true"
        }
      + id                  = (known after apply)
      + labels              = {
          + "firebase" = "enabled"
        }
      + name                = "API Definition Test Project 3"
      + number              = (known after apply)
      + org_id              = "77907885426"
      + project_id          = "test-project-1"
      + terraform_labels    = {
          + "firebase"                   = "enabled"
          + "goog-terraform-provisioned" = "true"
        }
    }

  # google_project_iam_member.tf_service_account_role will be created
  + resource "google_project_iam_member" "tf_service_account_role" {
      + etag    = (known after apply)
      + id      = (known after apply)
      + member  = "serviceAccount:tf-service-account@test-project-1.iam.gserviceaccount.com"
      + project = "test-project-1"
      + role    = "roles/editor"
    }

  # google_project_service.auth["cloudbilling.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "cloudbilling.googleapis.com"
    }

  # google_project_service.auth["cloudresourcemanager.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "cloudresourcemanager.googleapis.com"
    }

  # google_project_service.auth["iam.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "iam.googleapis.com"
    }

  # google_project_service.auth["identitytoolkit.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "identitytoolkit.googleapis.com"
    }

  # google_project_service.auth["serviceusage.googleapis.com"] will be created
  + resource "google_project_service" "auth" {
      + check_if_service_has_usage_on_destroy = false
      + disable_on_destroy                    = false
      + id                                    = (known after apply)
      + project                               = "test-project-1"
      + service                               = "serviceusage.googleapis.com"
    }

  # google_service_account.tf_service_account will be created
  + resource "google_service_account" "tf_service_account" {
      + account_id   = "tf-service-account"
      + disabled     = false
      + display_name = "Terraform Service Account"
      + email        = "tf-service-account@test-project-1.iam.gserviceaccount.com"
      + id           = (known after apply)
      + member       = "serviceAccount:tf-service-account@test-project-1.iam.gserviceaccount.com"
      + name         = (known after apply)
      + project      = "test-project-1"
      + unique_id    = (known after apply)
    }

Plan: 13 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_project.auth: Creating...
google_project.auth: Still creating... [10s elapsed]
google_project.auth: Still creating... [20s elapsed]
google_project.auth: Still creating... [30s elapsed]
google_project.auth: Creation complete after 32s [id=projects/test-project-1]
google_project_service.auth["iam.googleapis.com"]: Creating...
google_project_service.auth["cloudresourcemanager.googleapis.com"]: Creating...
google_project_service.auth["identitytoolkit.googleapis.com"]: Creating...
google_project_service.auth["serviceusage.googleapis.com"]: Creating...
google_project_service.auth["cloudbilling.googleapis.com"]: Creating...
google_project_service.auth["iam.googleapis.com"]: Still creating... [10s elapsed]
google_project_service.auth["cloudresourcemanager.googleapis.com"]: Still creating... [10s elapsed]
google_project_service.auth["serviceusage.googleapis.com"]: Still creating... [10s elapsed]
google_project_service.auth["cloudbilling.googleapis.com"]: Still creating... [10s elapsed]
google_project_service.auth["identitytoolkit.googleapis.com"]: Still creating... [10s elapsed]
google_project_service.auth["iam.googleapis.com"]: Still creating... [20s elapsed]
google_project_service.auth["cloudbilling.googleapis.com"]: Still creating... [20s elapsed]
google_project_service.auth["cloudresourcemanager.googleapis.com"]: Still creating... [20s elapsed]
google_project_service.auth["serviceusage.googleapis.com"]: Still creating... [20s elapsed]
google_project_service.auth["identitytoolkit.googleapis.com"]: Still creating... [20s elapsed]
google_project_service.auth["iam.googleapis.com"]: Creation complete after 24s [id=test-project-1/iam.googleapis.com]
google_project_service.auth["cloudbilling.googleapis.com"]: Creation complete after 24s [id=test-project-1/cloudbilling.googleapis.com]
google_project_service.auth["identitytoolkit.googleapis.com"]: Creation complete after 24s [id=test-project-1/identitytoolkit.googleapis.com]
google_project_service.auth["serviceusage.googleapis.com"]: Creation complete after 24s [id=test-project-1/serviceusage.googleapis.com]
google_project_service.auth["cloudresourcemanager.googleapis.com"]: Creation complete after 24s [id=test-project-1/cloudresourcemanager.googleapis.com]
google_firebase_project.auth: Creating...
google_service_account.tf_service_account: Creating...
google_identity_platform_config.auth: Creating...
google_firebase_project.auth: Still creating... [10s elapsed]
google_service_account.tf_service_account: Still creating... [10s elapsed]
google_firebase_project.auth: Creation complete after 17s [id=projects/test-project-1]
google_firebase_apple_app.auth: Creating...
google_firebase_android_app.auth: Creating...
google_firebase_web_app.auth: Creating...
google_service_account.tf_service_account: Still creating... [20s elapsed]
google_firebase_android_app.auth: Still creating... [10s elapsed]
google_firebase_apple_app.auth: Still creating... [10s elapsed]
google_firebase_web_app.auth: Still creating... [10s elapsed]
google_service_account.tf_service_account: Creation complete after 29s [id=projects/test-project-1/serviceAccounts/tf-service-account@test-project-1.iam.gserviceaccount.com]
google_project_iam_member.tf_service_account_role: Creating...
google_firebase_apple_app.auth: Creation complete after 13s [id=projects/test-project-1/iosApps/1:729478511552:ios:3ca480cc199e83e46b6625]
google_firebase_web_app.auth: Creation complete after 13s [id=projects/test-project-1/webApps/1:729478511552:web:98be67b0b843ca1a6b6625]
google_firebase_android_app.auth: Still creating... [20s elapsed]
google_project_iam_member.tf_service_account_role: Creation complete after 9s [id=test-project-1/roles/editor/serviceAccount:tf-service-account@test-project-1.iam.gserviceaccount.com]
google_firebase_android_app.auth: Still creating... [30s elapsed]
google_firebase_android_app.auth: Still creating... [40s elapsed]
google_firebase_android_app.auth: Still creating... [50s elapsed]
google_firebase_android_app.auth: Still creating... [1m0s elapsed]
google_firebase_android_app.auth: Still creating... [1m10s elapsed]
google_firebase_android_app.auth: Still creating... [1m20s elapsed]
google_firebase_android_app.auth: Creation complete after 1m26s [id=projects/test-project-1/androidApps/1:729478511552:android:fc2efe657c909b296b6625]
╷
│ Error: Error creating Config: googleapi: Error 403: Your application is authenticating by using local Application Default Credentials. The identitytoolkit.googleapis.com API requires a quota project, which is not set by default. To learn how to set your quota project, see https://cloud.google.com/docs/authentication/adc-troubleshooting/user-creds .    
│ Details:
│ [
│   {
│     "@type": "type.googleapis.com/google.rpc.ErrorInfo",
│     "domain": "googleapis.com",
│     "metadata": {
│       "consumer": "projects/000000000000",
│       "service": "identitytoolkit.googleapis.com"
│     },
│     "reason": "SERVICE_DISABLED"
│   },
│   {
│     "@type": "type.googleapis.com/google.rpc.LocalizedMessage",
│     "locale": "en-US",
│     "message": "Your application is authenticating by using local Application Default Credentials. The identitytoolkit.googleapis.com API requires a quota project, which is not set by default. To learn how to set your quota project, see https://cloud.google.com/docs/authentication/adc-troubleshooting/user-creds ."
│   }
│ ]
│
│   with google_identity_platform_config.auth,
│   on main.tf line 70, in resource "google_identity_platform_config" "auth":
│   70: resource "google_identity_platform_config" "auth" {
│
╵

```

9. Check in the [IAM Admin](https://console.cloud.google.com/iam-admin/iam) that the `tf-service-account` service account for the new created project is there. Copy the email.

10. Make sure that the identity you're using (your user account) is granted the role roles/iam.serviceAccountTokenCreator on the service account. You can do this with the following command:
`gcloud iam service-accounts add-iam-policy-binding tf-service-account@test-project-1.iam.gserviceaccount.com  --project=test-project-1 --member="user:user@email.com" --role="roles/iam.serviceAccountTokenCreator"` command. This role will allow your account to call the iam.serviceAccounts.getAccessToken method on the service account. Make sure to replace the emails and the project id.
Expected output:
```
PS C:\Work\git\gindemit\apidef\TerraformGCPAuth\infra> gcloud iam service-accounts add-iam-policy-binding tf-service-account@test-project-1.iam.gserviceaccount.com  --project=test-project-1 --member="user:user@email.com" --role="roles/iam.serviceAccountTokenCreator"
Updated IAM policy for serviceAccount [tf-service-account@test-project-1.iam.gserviceaccount.com].
bindings:
- members:
  - user:user@email.com
  role: roles/iam.serviceAccountTokenCreator
etag: BwYvgqZ5aMI=
version: 1
```

11. Run the `gcloud auth application-default login --impersonate-service-account tf-service-account@test-project-1.iam.gserviceaccount.com` command.

12. Run again `terraform apply` command. It can fail for the first time, if so: wait a minute and rerun it. The expected output is:
```
PS C:\Work\git\gindemit\apidef\TerraformGCPAuth\infra> terraform apply
google_project.auth: Refreshing state... [id=projects/test-project-1]
google_project_service.auth["identitytoolkit.googleapis.com"]: Refreshing state... [id=test-project-1/identitytoolkit.googleapis.com]
google_project_service.auth["iam.googleapis.com"]: Refreshing state... [id=test-project-1/iam.googleapis.com]
google_project_service.auth["cloudresourcemanager.googleapis.com"]: Refreshing state... [id=test-project-1/cloudresourcemanager.googleapis.com]
google_project_service.auth["serviceusage.googleapis.com"]: Refreshing state... [id=test-project-1/serviceusage.googleapis.com]
google_project_service.auth["cloudbilling.googleapis.com"]: Refreshing state... [id=test-project-1/cloudbilling.googleapis.com]
google_firebase_project.auth: Refreshing state... [id=projects/test-project-1]
google_service_account.tf_service_account: Refreshing state... [id=projects/test-project-1/serviceAccounts/tf-service-account@test-project-1.iam.gserviceaccount.com]
google_project_iam_member.tf_service_account_role: Refreshing state... [id=test-project-1/roles/editor/serviceAccount:tf-service-account@test-project-1.iam.gserviceaccount.com]
google_firebase_web_app.auth: Refreshing state... [id=projects/test-project-1/webApps/1:729478511552:web:98be67b0b843ca1a6b6625]
google_firebase_android_app.auth: Refreshing state... [id=projects/test-project-1/androidApps/1:729478511552:android:fc2efe657c909b296b6625]
google_firebase_apple_app.auth: Refreshing state... [id=projects/test-project-1/iosApps/1:729478511552:ios:3ca480cc199e83e46b6625]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_identity_platform_config.auth will be created
  + resource "google_identity_platform_config" "auth" {
      + authorized_domains         = [
          + "localhost",
          + "test-project-1.firebaseapp.com",
          + "test-project-1.web.app",
        ]
      + autodelete_anonymous_users = true
      + id                         = (known after apply)
      + name                       = (known after apply)
      + project                    = "test-project-1"

      + blocking_functions {
          + forward_inbound_credentials {
              + access_token  = true
              + id_token      = true
              + refresh_token = true
            }
          + triggers {
              + event_type   = "beforeSignIn"
              + function_uri = "https://us-east1-test-project-1.cloudfunctions.net/before-sign-in"
              + update_time  = (known after apply)
            }
        }

      + client (known after apply)

      + mfa (known after apply)

      + monitoring (known after apply)

      + quota {
          + sign_up_quota_config {
              + quota          = 100
              + quota_duration = "7200s"
              + start_time     = (known after apply)
            }
        }

      + sign_in {
          + allow_duplicate_emails = true
          + hash_config            = (known after apply)

          + anonymous {
              + enabled = true
            }

          + email {
              + enabled           = true
              + password_required = false
            }
        }

      + sms_region_config {
          + allowlist_only {
              + allowed_regions = [
                  + "US",
                  + "CA",
                ]
            }
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_identity_platform_config.auth: Creating...
google_identity_platform_config.auth: Creation complete after 2s [id=projects/test-project-1/config]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

13. Check the Google Cloud Dashboard and the Firebase Console: all requested services should be properly configured.

14. If the steps above helped you to resolve the 
```
Error: Error creating Config: googleapi: Error 403: Your application is authenticating by using local Application Default Credentials. The identitytoolkit.googleapis.com API requires a quota project, which is not set by default. To learn how to set your quota project, see https://cloud.google.com/docs/authentication/adc-troubleshooting/user-creds .
```
error, please consider to give a star for this repository.