# 🚀 Linux Server Setup — EC2 + Security + Automation

## 📌 Project Overview

This project demonstrates how to set up and manage a production-like Linux server on AWS EC2 with a focus on:

* Secure access configuration
* Reproducible server setup
* Basic system monitoring
* Automation using shell scripts

The goal is not just to “run a server”, but to build a setup that is **secure, repeatable, and observable**.

---

## 🧱 What This Project Covers

* Launching and configuring an EC2 instance (Free Tier)
* Creating a non-root user with sudo privileges
* Securing SSH access (key-based authentication, disabling root login)
* Installing and configuring essential tools:

  * Nginx (web server)
  * Git
  * Docker
* Writing automation scripts for server setup
* Writing a health-check script to monitor:

  * Disk usage
  * Memory usage
  * Service status

---

## ⚙️ EC2 Instance Setup

### Key Decisions

* **AMI:** Ubuntu / Amazon Linux (based on compatibility and familiarity)
* **Instance Type:** t2.micro (Free Tier eligible)
* **Region:** Chosen based on latency and availability
* **Access:** SSH via key pair (no password-based login)

### Security Group Configuration

| Port | Purpose      |
| ---- | ------------ |
| 22   | SSH access   |
| 80   | HTTP (Nginx) |

Only required ports are exposed to minimize attack surface.

---

## 🔐 Security Configuration

* Created a dedicated non-root user for daily operations
* Granted controlled sudo access
* Disabled root login via SSH
* Enforced key-based authentication (no password login)

This reduces the risk of unauthorized access and follows basic server hardening practices.

---

## 📦 Installed Packages

* **Nginx** → Used as a web server to verify deployment
* **Git** → For version control and repository management
* **Docker** → For containerization (future extensibility)

---

## 🧠 Automation Approach

Manual setup steps were converted into reusable shell scripts to ensure:

* Faster server provisioning
* Reduced human error
* Consistent environments

Scripts are organized based on responsibility (setup, security, monitoring).

---

## 📊 Health Check Script

A custom shell script is included to monitor system health.

### It checks:

* Disk usage (to detect storage issues)
* Memory usage (to detect resource pressure)
* Running services (e.g., Nginx, Docker)

### Purpose:

To quickly assess server health without manually running multiple commands.

---

## 📁 Project Structure

```
linux-server-setup/
│
├── README.md
├── EC2_Nginx_Setup.md            # End-to-end EC2 and Nginx setup guide
├── images/                       # Screenshots used in the project documentation
│   ├── ec2-instance-launch-success.png
│   ├── ec2-ssh-login-terminal.png
│   ├── nginx-installation-terminal.png
│   ├── nginx-service-start-enable-terminal.png
│   ├── nginx-welcome-page-browser.png
│   ├── git-docker-install-and-disk-check-terminal.png
│   └── disk-usage-df-h-terminal.png
└── scripts/
    ├── memory_usage.sh           # Reports current memory usage
    └── running_services.sh       # Checks status of running services
```

---

## 🧪 How to Reproduce

1. Launch an EC2 instance (Free Tier)
2. Configure security group (allow SSH + HTTP)
3. Connect via SSH using key pair
4. Run setup scripts (once created)
5. Verify:

   * Nginx is running
   * Health-check script outputs system status

---

## 📸 Proof of Work

Screenshots for this project are stored in the `images/` folder and referenced in `EC2_Nginx_Setup.md`.

Included proof of work:

* EC2 instance launch success
* SSH login to the EC2 instance
* Nginx installation in the terminal
* Nginx service start and enable commands
* Nginx welcome page in the browser
* Git and Docker verification
* Disk usage check using `df -h`

---

## 🎯 Key Learnings

* Importance of securing servers beyond default settings
* Value of automation in reducing repetitive work
* How to structure a project for clarity and reproducibility
* Thinking in terms of systems, not just commands

---

## 🚧 Future Improvements

* Add cron job for automated health checks
* Introduce logging for monitoring script
* Convert setup into Infrastructure as Code (IaC)
* Add CI/CD pipeline for deployment

---

## 💡 Final Thought

This project is not just about setting up a server—
it’s about building the mindset of making systems **secure, repeatable, and maintainable**.
