provider "google-beta" {
  alias                    = "no_user_project_override"
  project = "test-project-1"
  billing_project          = "test-project-1"
  user_project_override    = false
}

# Creates a new Google Cloud project.
resource "google_project" "auth" {
  provider  = google-beta.no_user_project_override
  name            = "Test Project 1" # TODO: replace with your project name
  project_id      = "test-project-1" # TODO: replace with your project ID
  org_id          = "1111222233" # TODO: replace with your organization ID

  # Associates the project with a Cloud Billing account
  # (required for Firebase Authentication with GCIP).
  # https://console.cloud.google.com/billing
  billing_account = "000000-000000-000000" # TODO: replace with your billing account ID

  # Required for the project to display in a list of Firebase projects.
  labels = {
    "firebase" = "enabled"
  }
}

# Enables required APIs.
resource "google_project_service" "auth" {
  provider = google-beta.no_user_project_override
  project  = google_project.auth.project_id
  for_each = toset([
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "identitytoolkit.googleapis.com",
    "iam.googleapis.com",
  ])
  service = each.key

  # Don't disable the service if the resource block is removed by accident.
  disable_on_destroy = false
}

# Create a service account.
resource "google_service_account" "tf_service_account" {
  project = "test-project-1"
  account_id   = "tf-service-account"
  display_name = "Terraform Service Account"
  depends_on = [ google_project_service.auth ]
}

# Grant the service account a role in your project.
resource "google_project_iam_member" "tf_service_account_role" {
  project = google_project.auth.project_id  # or use your specific project ID
  role    = "roles/editor"  # Use a role that provides the necessary permissions
  member  = "serviceAccount:${google_service_account.tf_service_account.email}"
  depends_on = [ google_service_account.tf_service_account ]
}

# Enables Firebase services for the new project created above.
resource "google_firebase_project" "auth" {
  provider = google-beta
  project  = google_project.auth.project_id

  depends_on = [
    google_project_service.auth,
  ]
}

# Creates an Identity Platform config.
# Also enables Firebase Authentication with Identity Platform in the project if not.
resource "google_identity_platform_config" "auth" {
  provider = google-beta
  project  = google_project.auth.project_id

  # Auto-deletes anonymous users
  autodelete_anonymous_users = true

  # Configures local sign-in methods, like anonymous, email/password, and phone authentication.
  sign_in {
    allow_duplicate_emails = true

    anonymous {
      enabled = true
    }

    email {
      enabled = true
      password_required = false
    }
  }

  # Sets an SMS region policy.
  sms_region_config {
    allowlist_only {
      allowed_regions = [
        "US",
        "CA",
      ]
    }
  }

  # Configures blocking functions.
  blocking_functions {
    triggers {
      event_type = "beforeSignIn"
      function_uri = "https://us-east1-${google_project.auth.project_id}.cloudfunctions.net/before-sign-in"
    }
    forward_inbound_credentials {
      refresh_token = true
      access_token = true
      id_token = true
    }
  }

  # Configures a temporary quota for new signups for anonymous, email/password, and phone number.
  quota {
   sign_up_quota_config {
      quota          = 100
      start_time     = timestamp()
      quota_duration = "7200s"
    }
  }

  # Configures authorized domains.
  authorized_domains = [
    "localhost",
    "${google_project.auth.project_id}.firebaseapp.com",
    "${google_project.auth.project_id}.web.app",
  ]

  # Wait for identitytoolkit.googleapis.com to be enabled before initializing Authentication.
  depends_on = [
    google_project_service.auth,
  ]
}

# Creates a Firebase Android App in the new project created above.
resource "google_firebase_android_app" "auth" {
  provider     = google-beta
  project      = google_project.auth.project_id
  display_name = "My Android app"
  package_name = "android.package.name"

  # Wait for Firebase to be enabled in the Google Cloud project before creating this App.
  depends_on = [
    google_firebase_project.auth,
  ]
}

# Creates a Firebase Apple-platforms App in the new project created above.
resource "google_firebase_apple_app" "auth" {
  provider     = google-beta
  project      = google_project.auth.project_id
  display_name = "My Apple app"
  bundle_id    = "apple.app.12345"

  # Wait for Firebase to be enabled in the Google Cloud project before creating this App.
  depends_on = [
    google_firebase_project.auth,
  ]
}

# Creates a Firebase Web App in the new project created above.
resource "google_firebase_web_app" "auth" {
  provider     = google-beta
  project      = google_project.auth.project_id
  display_name = "My Web app"

  # The other App types (Android and Apple) use "DELETE" by default.
  # Web apps don't use "DELETE" by default due to backward-compatibility.
  deletion_policy = "DELETE"

  # Wait for Firebase to be enabled in the Google Cloud project before creating this App.
  depends_on = [
    google_firebase_project.auth,
  ]
}