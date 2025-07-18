# 🌐 Secure Web App with Public Proxy + Private Backend on AWS using Terraform

This project provisions a complete multi-tier infrastructure on **AWS** using **Terraform**, designed for a Flask backend application with secure and scalable access.

<img width="824" height="427" alt="Screenshot (640)" src="https://github.com/user-attachments/assets/3bc95482-4380-46ca-b42a-d3be2e2c2077" />

---

## 🚀 Architecture Overview

The setup includes:

- **VPC with 4 subnets**:
  - 2 public subnets
  - 2 private subnets

- **Public Layer**:
  - **Public ALB (Application Load Balancer)** – receives traffic from users
  - **Proxy EC2 Instance** – Nginx reverse proxy in public subnet

- **Private Layer**:
  - **Private EC2 Backend Instances** – Flask application servers

- **Security Components**:
  - **Bastion Host** – SSH access to private instances
  - **Security Groups** – Granular control over inbound/outbound traffic

- **Routing and NAT**:
  - Internet Gateway for public access
  - NAT Gateway for private instances' outbound internet access

---

## ⚙️ Flow of Traffic

1. **User → Public ALB**
2. **Public ALB → Proxy EC2** (via port 80)
3. **Proxy EC2 → Flask EC2 instances in private subnets** (via port 5000)
4. **Response travels back the same way**

---

## 🧱 Modules Used

The architecture is modular. Each component is defined under `modules/` directory:

- `vpc` – Virtual Private Cloud
- `public_subnets`, `private_subnets`
- `internet_gateway`, `nat_gateway`
- `alb_public`, `alb_internal`
- `security_groups`
- `Ec2_proxy`, `Ec2_backend`
- `bastion_host`

---

## 📂 Project Structure

```bash
terraform-project/
├── backend-app/               # Flask app source code
├── modules/                   # Reusable Terraform modules
│   ├── vpc/
│   ├── public_subnets/
│   ├── private_subnets/
│   ├── internet_gateway/
│   ├── nat_gateway/
│   ├── alb_public/
│   ├── alb_internal/
│   ├── security_groups/
│   ├── Ec2_proxy/
│   ├── Ec2_backend/
│   └── bastion_host/
├── backend.tf                 # Remote backend (if used)
├── provider.tf                # AWS provider config
├── main.tf                    # Root module and resources
├── variables.tf               # Variables declaration
├── terraform.tfvars           # Variable values
├── output.tf                  # Outputs (e.g., ALB DNS)
└── README.md                  # This file
```

---

## ✅ How to Deploy

```bash
terraform init
terraform plan
terraform apply
```

> 💡 Make sure your `terraform.tfvars` includes the right VPC CIDRs, key pair name, AMI ID, etc.

---

## 🔒 Security Notes

- SSH access to backend EC2 is only allowed via the **bastion host**.
- Backend instances are **not exposed** to the internet.
- ALB and Proxy EC2 act as the controlled entry points.

---

## 📬 Output Example

```text
Application is accessible at:
http://<public-alb-dns-name>
```

---

## 🧑‍💻 Author

**Shady Emad Wahib Farhat**  
DevOps Engineer | AWS | Terraform | Linux | Kubernetes  
GitHub: [shadyemad2](https://github.com/shadyemad2)

---

## 🏁 Status

✅ Fully working and tested on AWS using Terraform CLI.  
✅ Ready for production-grade extension (e.g., Auto Scaling, RDS, S3 static hosting, etc.)


