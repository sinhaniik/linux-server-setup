# 🚀 EC2 Nginx Setup — From Zero to Live Server

This project documents the end-to-end setup of an AWS EC2 instance and deploying a basic web server (Nginx) accessible over the internet.

---

# 📌 Objective

- Launch an EC2 instance
- Connect via SSH using a key pair
- Install and run Nginx
- Expose the server via Public IP
- Debug common connection issues

---

# 🏗️ Architecture

```
User (Browser)
↓
Public Internet
↓
Internet Gateway (IGW)
↓
VPC
↓
Public Subnet
↓
EC2 Instance (Amazon Linux 2023)
↓
Nginx (Port 80)
```

---

# ⚙️ Step 1 — Launch EC2

- AMI: Amazon Linux 2023
- Instance Type: t2.micro (Free tier)
- Key Pair: `.pem` file (download and store securely)
- Network:
  - Public Subnet
  - Auto-assign Public IP: Enabled

---

# 🔐 Step 2 — Connect via SSH

### ❌ Common mistake

```bash
ssh -i aws_ssh.pem ec2_user@http://<PUBLIC_IP>/
```

### ✅ Correct command

```bash
chmod 400 aws_ssh.pem
ssh -i aws_ssh.pem ec2-user@<PUBLIC_IP>
```

### 🔍 Notes

* Username depends on AMI:
  * Amazon Linux → `ec2-user`
* `.pem` must have strict permissions (`400`)

---

# 🌐 Step 3 — Initial Issue

### Problem:

```text
ERR_CONNECTION_REFUSED
```

### Root Cause:

* EC2 is running
* But **no application is listening on port 80**

---

# 🧠 Understanding the Issue

EC2 is just a **virtual machine**, not a web server.

```
Request → EC2 → OS → Port 80 → ❌ No service → Connection refused
```

---

# 📦 Step 4 — Install Nginx

```bash
sudo yum update -y
sudo yum install nginx -y
```

---

# ▶️ Step 5 — Start Nginx

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

---

# ✅ Step 6 — Verify

```bash
sudo systemctl status nginx
```

Check listening ports:

```bash
sudo netstat -tulnp | grep 80
```

---

# 🌍 Step 7 — Access Application

Open in browser:

```
http://<PUBLIC_IP>
```

You should see:

```
Welcome to nginx!
```

---

# 💾 Disk Check (Verification)

```bash
df -h
```

Example output:

* Root volume: `/dev/xvda1`
* Size: 8GB
* Used: ~25%

---

# 🔒 Security Configuration

### Security Group Inbound Rules

| Type | Port | Source    |
| ---- | ---- | --------- |
| SSH  | 22   | 0.0.0.0/0 |
| HTTP | 80   | 0.0.0.0/0 |

---

# ⚠️ Common Errors & Fixes

| Issue                         | Cause                 | Fix                            |
| ----------------------------- | --------------------- | ------------------------------ |
| Permission denied (publickey) | Wrong username or key | Use `ec2-user`, correct `.pem` |
| Connection refused            | No app running        | Install/start Nginx            |
| Timeout                       | Port blocked          | Check Security Group           |
| SSH fails                     | Wrong permissions     | `chmod 400 key.pem`            |

---

# 💸 Cost Considerations

* EC2 billed per second (t2.micro is low cost)
* Idle instance = unnecessary cost
* Data transfer out may incur charges
* Stop instance when not in use:

```bash
aws ec2 stop-instances --instance-ids <id>
```

---

# 🔐 Security Best Practices

* Never expose SSH (22) to `0.0.0.0/0` in production
* Use:
  * Bastion host OR
  * AWS SSM Session Manager
* Store `.pem` securely (never commit to GitHub)
* Use IAM roles instead of hardcoded credentials

---

# 🧠 Key Learnings

* EC2 ≠ Web Server
* Public IP only routes traffic — it doesn't serve content
* You must run a process (Nginx / Node.js / etc.)
* SSH issues are usually:
  * Wrong user
  * Wrong key
  * Wrong permissions

---

# 🚀 Next Steps

* Deploy a Node.js app instead of Nginx
* Use Docker on EC2
* Set up an Application Load Balancer (ALB)
* Add HTTPS using ACM + Nginx
* Automate using Terraform

---

!()[]

> Add your screenshots here:

* EC2 Instance running
* SSH terminal
* Nginx installation
* Browser output

---

# 🏁 Conclusion

You successfully:

* Launched a cloud server
* Connected securely via SSH
* Installed and ran a web server
* Exposed it to the internet

This is your **first real production-like system**.

Next step: make it scalable.