# 🌀 GCP Anime-Themed Runtime Load Balancer with React, Terraform, Private Compute, and Cloud Storage

<div align="center">

**Production-inspired GCP infrastructure project with React, Nginx, Cloud Storage artifacts, private Compute Engine servers, and HTTP Load Balancer routing**

<br/>

<!-- Add architecture diagram image here after uploading it to the repository -->

<img width="1200" alt="Architecture Diagram" src="./diagrams/architecture-diagram.png" />

<br/>
<br/>

![GCP](https://img.shields.io/badge/GCP-Cloud%20Provider-4285F4?style=for-the-badge\&logo=googlecloud\&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-Infrastructure%20as%20Code-7B42BC?style=for-the-badge\&logo=terraform\&logoColor=white)
![React](https://img.shields.io/badge/React-Frontend-61DAFB?style=for-the-badge\&logo=react\&logoColor=black)
![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-009639?style=for-the-badge\&logo=nginx\&logoColor=white)
![Compute Engine](https://img.shields.io/badge/Compute%20Engine-Private%20VMs-4285F4?style=for-the-badge\&logo=googlecloud\&logoColor=white)
![Cloud Storage](https://img.shields.io/badge/Cloud%20Storage-Artifact%20Bucket-34A853?style=for-the-badge\&logo=googlecloud\&logoColor=white)
![Cloud NAT](https://img.shields.io/badge/Cloud%20NAT-Private%20Egress-FBBC04?style=for-the-badge\&logo=googlecloud\&logoColor=black)
![HTTP Load Balancer](https://img.shields.io/badge/HTTP%20Load%20Balancer-Path%20Routing-8C4FFF?style=for-the-badge)
![VPC](https://img.shields.io/badge/VPC-Networking-0EA5E9?style=for-the-badge)
![Bash](https://img.shields.io/badge/Bash-Automation-121011?style=for-the-badge\&logo=gnubash\&logoColor=white)
![Status](https://img.shields.io/badge/Status-Portfolio%20Ready-success?style=for-the-badge)

</div>

---

## 📌 Overview

This project deploys an anime-inspired React website on Google Cloud Platform using Terraform and startup-script automation.

The frontend is a custom React application with four themed character experiences:

* Gojo Satoru
* Ryomen Sukuna
* Yuta Okkotsu
* Hiromi Higuruma

Each character page is served by a separate private Compute Engine VM. The VMs sit behind a global HTTP Load Balancer, and the load balancer routes traffic to different backend servers. Each server receives its own runtime configuration through a Terraform startup script, which controls the default character page and generates live server metadata.

The site build is stored as a compressed artifact in Google Cloud Storage. When each VM boots, it downloads the artifact, extracts it, configures Nginx, generates runtime JSON files, and serves the React site.

This project demonstrates frontend delivery, artifact-based deployment, private VM hosting, startup automation, load balancer routing, GCP networking, and Terraform-based infrastructure provisioning.

---

## 🧠 Problem Statement

A normal frontend portfolio project only proves that a website can be built. It does not prove much about cloud infrastructure, runtime automation, private networking, or load balancing.

This project turns a visual React website into a cloud infrastructure project by answering several real engineering questions:

* How can a static React build be packaged and deployed as a cloud artifact?
* How can private VMs download a build from Cloud Storage at boot time?
* How can Nginx serve a React app on Compute Engine?
* How can a load balancer route users to different application backends?
* How can each server expose its own live runtime metadata?
* How can Terraform reproduce the full environment consistently?

---

## 🎯 Project Objective

Build a production-inspired GCP deployment where:

* the React site is packaged as a large compressed build artifact
* the artifact is uploaded to Google Cloud Storage
* private Compute Engine VMs download and serve the site with Nginx
* each VM has a different default character configuration
* server metadata is generated dynamically at boot
* a global HTTP Load Balancer routes traffic to backend services
* Terraform provisions the infrastructure repeatably
* Bash scripts handle artifact upload and cleanup

---

## 🏗️ Architecture Diagram

> Save your architecture image as:
>
> `diagrams/architecture-diagram.png`

<img width="1200" alt="Architecture Diagram" src="./diagrams/architecture-diagram.png" />

---

## 🔄 Architecture Flow

```text
User Browser
     ↓
Global HTTP Load Balancer
     ↓
URL Map / Backend Service Routing
     ↓
Character Backend Service
     ↓
Unmanaged Instance Group
     ↓
Private Compute Engine VM
     ↓
Nginx Web Server
     ↓
React Static Site + Runtime JSON
```

Artifact deployment flow:

```text
Local site-build.tar.gz
     ↓
Upload Script
     ↓
Google Cloud Storage Bucket
     ↓
VM Startup Script
     ↓
Download + Extract Artifact
     ↓
Generate site-config.json
     ↓
Generate server-metadata.json
     ↓
Nginx Serves React Site
```

---

## 🎬 Demo

Add one demo video here after uploading it to the repository or GitLab/GitHub release assets:

```text
Demo Video:
<add-demo-video-link-here>
```

---

## 🧰 Technology Stack

| Layer                  | Technology                                  |
| ---------------------- | ------------------------------------------- |
| Cloud Provider         | Google Cloud Platform                       |
| Infrastructure as Code | Terraform                                   |
| Frontend               | React / Vite / CSS                          |
| Web Server             | Nginx                                       |
| Compute                | Google Compute Engine                       |
| Artifact Storage       | Google Cloud Storage                        |
| Networking             | Custom VPC, public subnets, private subnets |
| Private Egress         | Cloud NAT + Cloud Router                    |
| Load Balancing         | Global HTTP Load Balancer                   |
| Runtime Automation     | Startup script template                     |
| Scripting              | Bash                                        |
| Identity               | Google service account + bucket IAM         |

---

## ✨ What This Project Demonstrates

<table>
  <tr>
    <td align="center" width="25%">
      <h3>🌐 GCP Networking</h3>
      Custom VPC design with public and private subnet separation.
    </td>
    <td align="center" width="25%">
      <h3>⚖️ Load Balancing</h3>
      HTTP Load Balancer routing to different backend services.
    </td>
    <td align="center" width="25%">
      <h3>🖥️ Private Compute</h3>
      Compute Engine VMs run without direct public exposure.
    </td>
    <td align="center" width="25%">
      <h3>📦 Artifact Deployment</h3>
      Site build is packaged, uploaded, and pulled at boot time.
    </td>
  </tr>
  <tr>
    <td align="center" width="25%">
      <h3>🚀 Startup Automation</h3>
      VM bootstrap installs Nginx, downloads files, and creates runtime config.
    </td>
    <td align="center" width="25%">
      <h3>🔐 Least Privilege IAM</h3>
      VM service account receives read-only access to the artifact bucket.
    </td>
    <td align="center" width="25%">
      <h3>🧾 Runtime Metadata</h3>
      Each VM exposes live instance details through JSON.
    </td>
    <td align="center" width="25%">
      <h3>🎨 Frontend + Cloud</h3>
      A custom React interface becomes a real cloud-hosted deployment.
    </td>
  </tr>
</table>

---

## ✅ What This Builds

* Custom GCP VPC
* Two public subnets
* Two private subnets
* Cloud Router
* Cloud NAT for private VM outbound access
* Google Cloud Storage artifact bucket
* Service account for Compute Engine web servers
* Bucket IAM permission for artifact download
* Four private Compute Engine web servers
* One unmanaged instance group per server
* One backend service per character server
* Global HTTP Load Balancer
* URL map for routing traffic to character backends
* Nginx configuration for serving the React site
* Runtime `site-config.json`
* Runtime `server-metadata.json`
* Bash script to upload the compressed site artifact
* Bash script to destroy the artifact bucket

---

## 🧱 Core GCP Resources

| GCP Resource           | Role in Architecture                                                                     |
| ---------------------- | ---------------------------------------------------------------------------------------- |
| VPC Network            | Provides the isolated network boundary for the deployment.                               |
| Subnets                | Separate network ranges for public and private architecture tiers.                       |
| Cloud Router           | Required control-plane resource for Cloud NAT.                                           |
| Cloud NAT              | Allows private VMs to reach the internet and Google APIs for package/artifact downloads. |
| Cloud Storage          | Stores the compressed React build artifact.                                              |
| Service Account        | Provides identity to the Compute Engine VMs.                                             |
| IAM Binding            | Allows the VM service account to read the artifact bucket.                               |
| Compute Engine         | Runs the Nginx web servers.                                                              |
| Instance Groups        | Logical backend targets for the load balancer.                                           |
| Backend Services       | Connect load balancer routes to instance groups.                                         |
| URL Map                | Defines load balancer routing behavior.                                                  |
| Target HTTP Proxy      | HTTP frontend component for the global load balancer.                                    |
| Global Forwarding Rule | Public entry point for HTTP traffic on port 80.                                          |
| Health Check           | Verifies that backend servers are reachable and healthy.                                 |

---

## 📂 Project Structure

```text
WEEK 1 TO ME/
├── README.md
├── site-build.tar.gz                  # Large React build artifact
├── startup-script.sh.tpl              # VM bootstrap template
├── 1-network.tf                       # VPC, subnets, NAT, firewall, IAM
├── 2-instances.tf                     # Compute Engine instances
├── 3-load_balancer.tf                 # Instance groups, backends, URL map, LB
├── 4-variable.tf                      # Terraform variables
├── 5-output.tf                        # Terraform outputs
├── scripts/
│   ├── build-upload-site.sh           # Uploads site-build.tar.gz to GCS
│   └── destroy-artifact-bucket.sh     # Deletes artifact bucket and contents
├── jjk-domain-sites/
│   ├── package.json
│   ├── public/
│   │   ├── images/
│   │   └── videos/
│   └── src/
│       ├── App.jsx
│       ├── index.css
│       └── main.jsx
└── diagrams/
    └── architecture-diagram.png
```

---

## 📦 Required Download to Run the Project

This project requires an additional large file that is not included directly in the repository because the full website asset bundle is large.

The required file is:

```text
site-build.tar.gz
```

After downloading or cloning the repository, download the large project asset from the repository release page.

### Steps

1. Download or clone the repository:

```bash
git clone <your-repository-url>
cd <your-project-folder>
```

2. Go to the project release page.

3. Download the required large file:

```text
site-build.tar.gz
```

4. Move the file into the main project folder:

```text
WEEK 1 TO ME/
├── site-build.tar.gz
├── scripts/
├── jjk-domain-sites/
├── 1-network.tf
├── 2-instances.tf
├── 3-load_balancer.tf
├── 4-variable.tf
├── 5-output.tf
└── startup-script.sh.tpl
```

5. Confirm the file exists:

```bash
ls -lh site-build.tar.gz
```

If the site does not load after deployment, confirm that `site-build.tar.gz` exists in the project root and that the upload script successfully copied it to Google Cloud Storage.

---

## 🚀 Quick Start

### 1. Authenticate to GCP

```bash
gcloud auth login
gcloud auth application-default login
gcloud config set project gcp-mastery-495919
```

### 2. Upload the site artifact

Run this from the `scripts` folder:

```bash
cd scripts
chmod +x build-upload-site.sh
./build-upload-site.sh
```

This script:

```text
1. Sets the GCP project
2. Checks for ../site-build.tar.gz
3. Creates the artifact bucket if missing
4. Uploads the artifact to Cloud Storage
```

### 3. Deploy the infrastructure

Move back to the Terraform root:

```bash
cd ..
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

### 4. Open the site

After deployment, get the load balancer URL:

```bash
terraform output site_url
```

Then open the URL in a browser.

---

## 🧪 Validation & Testing

### Check Terraform outputs

```bash
terraform output
```

### Validate that instances were created

```bash
gcloud compute instances list
```

### Validate backend health

```bash
gcloud compute backend-services get-health <backend-service-name> --global
```

### Test runtime metadata

```bash
curl http://<LOAD_BALANCER_IP>/server-metadata.json
```

Expected fields include:

```text
ProjectId
InstanceName
MachineType
Region
Zone
InternalIP
DefaultCharacter
DeployedAt
```

### Test the site in a browser

Open:

```text
http://<LOAD_BALANCER_IP>
```

If path-based routing is enabled, also test:

```text
http://<LOAD_BALANCER_IP>/gojo
http://<LOAD_BALANCER_IP>/sukuna
http://<LOAD_BALANCER_IP>/yuta
http://<LOAD_BALANCER_IP>/higuruma
```

---

## 🔐 Security Architecture

| Layer          | Security Control                                                                     |
| -------------- | ------------------------------------------------------------------------------------ |
| Network        | Private Compute Engine VMs are not directly exposed to the internet.                 |
| Egress         | Cloud NAT allows controlled outbound access for private VMs.                         |
| Identity       | Compute Engine uses a dedicated service account.                                     |
| Storage        | Cloud Storage bucket uses uniform bucket-level access.                               |
| Access Control | VM service account receives only object viewer access to the artifact bucket.        |
| Load Balancing | Public access enters through the HTTP Load Balancer instead of directly hitting VMs. |
| Runtime Config | Server metadata is generated dynamically instead of hardcoded into the frontend.     |

---

## 📊 Observability

This project keeps observability simple.

Useful commands:

```bash
sudo systemctl status nginx
sudo nginx -t
sudo tail -100 /var/log/syslog
ls -lah /var/www/jjk-domain-sites
curl http://localhost/server-metadata.json
```

The main runtime visibility feature is:

```text
/server-metadata.json
```

This file shows which VM served the application and what character configuration was applied at boot time.

---

## 🔁 CI/CD Pipeline Simulation

This project does not use a full CI/CD pipeline yet, but the workflow simulates a basic deployment pipeline:

```text
Local Build Artifact
     ↓
Upload Script
     ↓
Cloud Storage Artifact Bucket
     ↓
Terraform Apply
     ↓
VM Startup Script
     ↓
Nginx Serves React Site
```

A future CI/CD version could use GitLab CI or GitHub Actions to:

* build the React site
* package `site-build.tar.gz`
* upload the artifact to Cloud Storage
* run Terraform plan/apply
* validate the load balancer endpoint

---

## ⚖️ Scaling Considerations

This project uses individual private VMs and instance groups for clarity.

Production improvements could include:

* managed instance groups instead of standalone VMs
* autoscaling policies
* HTTPS with managed certificates
* Cloud CDN in front of the load balancer
* structured logging and monitoring dashboards
* multi-region deployment
* Cloud Armor for edge protection
* automated artifact versioning

---

## 🧩 Multi-Service Expansion

This project could be expanded into a broader GCP platform demo by adding:

* Cloud CDN for static asset acceleration
* Cloud Armor for WAF-style protection
* Cloud Logging dashboards
* Managed instance groups with autoscaling
* separate environments for dev, test, and prod
* GitLab CI/CD deployment workflow
* DNS and HTTPS with a custom domain
* service-specific routing for APIs, frontend, and admin pages

---

## 🧹 Teardown

Destroy Terraform-managed infrastructure:

```bash
terraform destroy
```

Destroy the artifact bucket:

```bash
cd scripts
chmod +x destroy-artifact-bucket.sh
./destroy-artifact-bucket.sh
```

The destroy script deletes:

```text
1. Objects inside the Cloud Storage artifact bucket
2. The bucket itself
```

---

## 🧠 Lessons Learned

This project helped reinforce several important cloud engineering concepts:

* GCP routing is different from AWS route tables.
* Cloud Router is required for Cloud NAT configuration.
* Cloud NAT enables private VMs to download packages and artifacts without public IPs.
* GCP load balancers are built from multiple resources: forwarding rule, proxy, URL map, backend service, and instance group.
* Backend services attach to instance groups, not raw VM instances.
* Startup scripts can turn a generic VM into a fully configured web server.
* Runtime JSON files are a clean way to expose server-specific configuration to a static React frontend.
* Large frontend assets should be stored as release artifacts or cloud storage objects instead of committed directly to the repository.

---

## 🧪 Troubleshooting

| Issue                        | Likely Cause                                                  | Fix                                                                       |
| ---------------------------- | ------------------------------------------------------------- | ------------------------------------------------------------------------- |
| Site does not load           | Nginx failed or files missing                                 | SSH into VM and check `/var/www/jjk-domain-sites`.                        |
| Backend unhealthy            | Health check cannot reach port 80                             | Confirm Nginx is running and firewall allows LB health check ranges.      |
| Artifact download fails      | Service account lacks bucket access                           | Check `roles/storage.objectViewer` on the bucket.                         |
| `site-build.tar.gz` missing  | Release asset was not downloaded                              | Move `site-build.tar.gz` into the project root.                           |
| Browser shows blank page     | React assets missing or wrong paths                           | Confirm `assets/`, `images/`, and `videos/` exist in web root.            |
| Metadata JSON does not load  | Nginx route issue                                             | Test `curl http://localhost/server-metadata.json` on the VM.              |
| Terraform cannot find bucket | Bucket created outside Terraform but no data block configured | Use a `data "google_storage_bucket"` block or create bucket before apply. |

---

## 📚 References

* Google Cloud Compute Engine documentation
* Google Cloud VPC documentation
* Google Cloud Load Balancing documentation
* Google Cloud Storage documentation
* Terraform Google Provider documentation
* Nginx documentation
* React / Vite documentation

---

## 🚀 Why This Project Matters

This project turns a custom frontend into a real cloud infrastructure deployment.

Instead of only showing a local React application, it demonstrates how application files move through a cloud delivery pipeline and become a running service behind a load balancer.

<br>

<table>
  <tr>
    <td align="center" width="33%">
      <h3>📦 Artifact-Based Deployment</h3>
      The React build is packaged and uploaded to Cloud Storage instead of manually copied to servers.
    </td>
    <td align="center" width="33%">
      <h3>🔐 Private Server Design</h3>
      Web servers run privately and are reached through the load balancer path.
    </td>
    <td align="center" width="33%">
      <h3>⚙️ Runtime Automation</h3>
      Startup scripts configure Nginx, download the app, and generate live metadata automatically.
    </td>
  </tr>
  <tr>
    <td align="center" width="33%">
      <h3>🌐 Load Balancer Routing</h3>
      Traffic can be routed across character-specific backend services.
    </td>
    <td align="center" width="33%">
      <h3>🧾 Dynamic Metadata</h3>
      Each server exposes real runtime details through JSON.
    </td>
    <td align="center" width="33%">
      <h3>🏗️ Terraform IaC</h3>
      The infrastructure is repeatable, reviewable, and easy to tear down.</h3>
    </td>
  </tr>
</table>

---

## ✨ What This Project Proves

| Area                   | Value Shown                                               |
| ---------------------- | --------------------------------------------------------- |
| Frontend Delivery      | React build packaged and served through Nginx             |
| Infrastructure as Code | GCP resources provisioned with Terraform                  |
| Cloud Networking       | VPC, subnets, NAT, firewall, and load balancer design     |
| Runtime Automation     | VM startup script handles server configuration            |
| IAM Design             | Dedicated service account reads from Cloud Storage        |
| Load Balancing         | Backend services and instance groups route traffic to VMs |
| Operational Thinking   | Validation, troubleshooting, and teardown are documented  |

---

## 👨‍💻 About the Author

<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Inter&weight=600&size=22&pause=1000&color=58A6FF&center=true&vCenter=true&width=760&lines=Cloud+Engineer+focused+on+AWS%2C+Terraform%2C+and+automation;Building+production-inspired+infrastructure+projects;Turning+cloud+concepts+into+real-world+implementations" alt="Typing SVG" />
</p>

<p align="center">
  I build hands-on cloud projects designed to reflect practical engineering work rather than simple demos.
  My focus is on <b>AWS infrastructure</b>, <b>Infrastructure as Code</b>, <b>automation</b>, <b>security-minded design</b>, and <b>real implementation patterns</b> that translate into production environments.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/AWS-Architecting-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white" />
  <img src="https://img.shields.io/badge/Terraform-Infrastructure-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" />
  <img src="https://img.shields.io/badge/Cloud-Engineering-1F6FEB?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Automation-Building-success?style=for-the-badge" />
</p>

<p align="center">
  <a href="https://www.linkedin.com/in/gavin-fogwe/">
    <img src="https://img.shields.io/badge/LinkedIn-Let's%20Connect-blue?style=for-the-badge&logo=linkedin" />
  </a>
  <a href="https://github.com/gavinxenon0-arch">
    <img src="https://img.shields.io/badge/GitHub-See%20More%20Projects-black?style=for-the-badge&logo=github" />
  </a>
  <a href="https://gavinfogwe.win/">
    <img src="https://img.shields.io/badge/Portfolio-Explore-orange?style=for-the-badge&logo=googlechrome&logoColor=white" />
  </a>
</p>
