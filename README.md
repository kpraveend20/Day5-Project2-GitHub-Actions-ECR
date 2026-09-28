# Day 5 Project 2 — GitHub Actions + Docker + AWS ECR

## Project Overview

This project demonstrates how to use **GitHub Actions** to automate a Docker-based CI pipeline.

The project creates a simple Bash application, packages it into a Docker image, and uses GitHub Actions to automatically build and test the Docker image.

The planned next stage is to authenticate GitHub Actions with AWS using **OIDC** and push the Docker image to **Amazon ECR**.

---

## Objective

The objectives of this project are:

* Create a simple application using Bash
* Create a Dockerfile
* Build a Docker image
* Run and test the Docker container
* Create a GitHub Actions workflow
* Automate Docker image building using GitHub Actions
* Understand GitHub Actions and Docker integration
* Understand the flow from GitHub Actions to AWS ECR
* Practice AWS OIDC authentication for GitHub Actions

---

## Technologies Used

* Git
* GitHub
* GitHub Actions
* Docker
* Bash
* AWS
* Amazon ECR
* AWS IAM
* AWS OIDC
* VS Code

---

## Project Structure

```text
Day5-Project2-GitHub-Actions-ECR/
│
├── .github/
│   └── workflows/
│       └── docker-ecr.yml
│
├── app.sh
├── Dockerfile
└── README.md
```

---

## Application

The application is a simple Bash script.

### app.sh

```bash
#!/bin/bash

echo "===================================="
echo "Day 5 Project 2"
echo "GitHub Actions to AWS ECR"
echo "===================================="

echo "Application is running successfully!"
echo "Docker image build project"
```

The script was tested locally using:

```bash
bash app.sh
```

Expected output:

```text
====================================
Day 5 Project 2
GitHub Actions to AWS ECR
====================================
Application is running successfully!
Docker image build project
```

---

## Dockerfile

The application is packaged using Ubuntu as the base Docker image.

```dockerfile
FROM ubuntu:24.04

WORKDIR /app

COPY app.sh .

RUN chmod +x app.sh

CMD ["./app.sh"]
```

### Dockerfile Explanation

| Instruction           | Purpose                                        |
| --------------------- | ---------------------------------------------- |
| `FROM ubuntu:24.04`   | Uses Ubuntu 24.04 as the base image            |
| `WORKDIR /app`        | Sets `/app` as the working directory           |
| `COPY app.sh .`       | Copies the application script into the image   |
| `RUN chmod +x app.sh` | Gives execute permission to the script         |
| `CMD ["./app.sh"]`    | Runs the application when the container starts |

---

## Local Docker Testing

The Docker image was built locally using:

```bash
docker build -t day5-project2-ecr:latest .
```

The image was verified using:

```bash
docker images
```

The Docker container was tested using:

```bash
docker run --rm day5-project2-ecr:latest
```

Expected output:

```text
====================================
Day 5 Project 2
GitHub Actions to AWS ECR
====================================
Application is running successfully!
Docker image build project
```

---

## GitHub Actions

The GitHub Actions workflow is located at:

```text
.github/workflows/docker-ecr.yml
```

The current CI workflow performs:

1. Checkout source code
2. Build Docker image
3. Run the Docker container for testing

### Current GitHub Actions Flow

```text
GitHub Push
     ↓
GitHub Actions
     ↓
Checkout Code
     ↓
Build Docker Image
     ↓
Test Docker Image
     ↓
SUCCESS
```

---

## GitHub Actions Workflow

The workflow uses:

```yaml
name: Docker Build and Push to ECR

on:
  push:
    branches:
      - main

  workflow_dispatch:

jobs:
  docker-ecr:

    runs-on: ubuntu-latest

    steps:

      - name: Checkout code
        uses: actions/checkout@v5

      - name: Build Docker image
        run: |
          docker build -t day5-project2-ecr:latest .

      - name: Test Docker image
        run: |
          docker run --rm day5-project2-ecr:latest
```

---

## GitHub Actions Result

The workflow was successfully executed in GitHub Actions.

Successful stages included:

```text
✓ Set up job
✓ Checkout code
✓ Build Docker Image
✓ Test Docker Image
✓ Post Checkout Code
✓ Complete Job
```

The workflow completed successfully.

---

## AWS ECR

An Amazon ECR private repository was created for this project:

```text
Repository:
day5-project2-ecr

Region:
ap-south-1
```

The intended deployment flow is:

```text
GitHub
   ↓
GitHub Actions
   ↓
Docker Build
   ↓
AWS OIDC Authentication
   ↓
IAM Role
   ↓
Amazon ECR Login
   ↓
Docker Tag
   ↓
Docker Push
   ↓
Amazon ECR
```

---

## AWS OIDC Authentication

The project is designed to use **GitHub OIDC** for AWS authentication instead of storing long-term AWS access keys in GitHub.

The intended authentication flow is:

```text
GitHub Actions
      ↓
GitHub OIDC Token
      ↓
AWS IAM
      ↓
IAM Role
      ↓
Amazon ECR
```

This approach allows GitHub Actions to obtain temporary AWS credentials through an IAM role.

---

## Security

The project follows these security practices:

* Avoid storing long-term AWS access keys in GitHub
* Use GitHub OIDC for AWS authentication
* Use an IAM role for GitHub Actions
* Restrict the IAM role to the required GitHub repository
* Give the role only the ECR permissions required for the project
* Keep AWS credentials out of source code

---

## Project Status

### Completed

* [x] Create project using VS Code
* [x] Create `app.sh`
* [x] Test Bash application locally
* [x] Create Dockerfile
* [x] Build Docker image locally
* [x] Run Docker container locally
* [x] Create GitHub Actions workflow
* [x] Push project to GitHub
* [x] Run GitHub Actions successfully
* [x] Create Amazon ECR repository
* [x] Configure AWS OIDC/IAM setup

### Next

* [ ] Configure GitHub Actions AWS authentication
* [ ] Login to Amazon ECR from GitHub Actions
* [ ] Tag Docker image with ECR repository URI
* [ ] Push Docker image to Amazon ECR
* [ ] Verify the image in ECR

---

## Learning Outcome

Through this project, I learned:

* How Docker packages an application
* How to create a Dockerfile
* How to build Docker images
* How to run Docker containers
* How GitHub Actions automates CI
* How GitHub Actions can work with Docker
* How Amazon ECR stores Docker images
* How AWS IAM roles can be used with GitHub Actions
* The purpose of GitHub OIDC authentication
* The basic GitHub → Docker → AWS ECR CI/CD architecture

---

## Overall Architecture

```text
                 Developer
                    │
                    ↓
                VS Code
                    │
                    ↓
                  Git
                    │
                    ↓
                 GitHub
                    │
                    ↓
             GitHub Actions
                    │
            ┌───────┴────────┐
            ↓                ↓
       Checkout Code     AWS OIDC
            │                │
            ↓                ↓
      Docker Build       IAM Role
            │                │
            ↓                ↓
       Docker Image      Amazon ECR
            │
            └───────────────→
```

---

## Repository

GitHub Repository:

```text
https://github.com/kpraveend20/Day5-Project2-GitHub-Actions-ECR
```

## Conclusion

This project demonstrates the fundamentals of integrating **GitHub Actions with Docker** and prepares the CI pipeline for deployment to **Amazon ECR**.

The current GitHub Actions pipeline successfully checks out the source code, builds the Docker image, and runs the container as a test.
