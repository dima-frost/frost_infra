# frost_infra
integration whith travic-ci



### Advanced task
#### Multiple SSH keys to a Google Cloud Platform

To add multiple SSH keys to a Google Cloud Platform (GCP) instance using Terraform, you can use the `metadata` block in the `google_compute_instance` resource.

Here's an example of how to add multiple SSH keys to a GCP instance using Terraform:

```
resource "google_compute_instance" "example_instance" {
  name         = "example-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  metadata = {
    ssh-keys = "user1:${file("~/.ssh/user1.pub")}\nuser2:${file("~/.ssh/user2.pub")}"
  }

  // ...
}
```

In this example, the `metadata` block specifies the `ssh-keys` key, which is set to a string containing the usernames and public keys for each user separated by a newline character.

You can use the `${file()}` interpolation function to read the contents of each public key file. In this example, we're using the `~/.ssh/user1.pub` and `~/.ssh/user2.pub` files.

Note that you can specify multiple SSH keys for a single user by separating them with commas. For example:

```
ssh-keys = "user1:${file("~/.ssh/user1.pub")},${file("~/.ssh/user1-other.pub")}"
```

This would add two SSH keys for the `user1` user.

Once you've defined the `metadata` block, you can apply the Terraform configuration to create the instance with the specified SSH keys.