# Hercules 3.x "Spinhawk" Docker builder
This repository is a builder for a Docker container that provides an emulated
S/370 mainframe, Hercules release 3.x "Spinhawk", running under Ubuntu Linux.

# Releases
The Docker images are at
https://hub.docker.com/repository/docker/rosspatterson/spinhawk.


# History
See [`changelog.txt`](changelog.txt) for the full version history.

# To use this repo
1. Prepare Docker:
   1. If you don't already have a Docker account, create one at
      https://www.docker.com.
   1. Create a `spinhawk` Docker repository.
   1. Create a Personal Access Token at
      https://app.docker.com/settings/personal-access-tokens with
	  `Read & Write` permission.
	  **NOTE:** Docker will only show you the token when you generate it.
	  You can never see its value again, so copy it immediately and save it.
1. Fork this repository on GitHub.
1. Create the following action secrets in your fork (go to your_repo ->
   `Settings` -> `Secrets and variables` -> `Actions` -> `Repository secrets`
   -> `New repository secret`):
   1. `DOCKER_USERNAME` - your Docker userid.
   1. `DOCKER_PASSWORD` - your Docker personal access token from above.
1. Go to the `Actions` tab on your GitHub fork and enable workflows.
1. Make a change, commit it, and push it to your fork.
   The `test_build.yml/Test-build image` GitHub workflow job will test the
   container build.
1. Tag the revision as `vn.n.n` (_e.g._, "v1.5.4") and push the tag to GitHub.
   The `test_build.yml/Test-build image` GitHub workflow job will test the
   container build again.
   The `publish.yml/Publish to Docker` GitHub workflow job will push the
   container image to Docker.

# To update the Docker image

1. Clone this repository to your disk.
1. Make your changes.
1. Review the following files and make any necessary changes:
   1. `.github/workflows/*.yml` - GitHub workflow files.
   1. `Dockerfile` - the main Docker control file.
1. Commit the changes and push to GitHub.
1. Wait for the `test_build.yml/Test-build image` GitHub workflow job to run
   and verify its success.
1. Tag the revision as `vn.n.n` (_e.g._, "v1.5.4") and push the tag to GitHub.
   **NOTE:** The leading "v" is necessary - it triggers the push to Docker.
1. Wait for the `publish.yml/Publish to Docker` GitHub workflow job to run.
1. Verify that your Docker userid has the new version of the container image.
1. When you're happy with the container image, consider updating the `latest` 
   tag to point to it:
   1. Start your Docker engine (_e.g._, Docker desktop).
   1. `docker pull userid/spinhawk:x.y.z`
   1. `docker tag  userid/spinhawk:x.y.z userid/spinhawk:latest`
   1. `docker push userid/spinhawk:latest`
   1. Stop your Docker engine.
