# Freds-SaaS-company
---
### **Terraform AWS Project: Modular Deployment of a SaaS Infrastructure**

This project demonstrates how to provision a scalable, secure, and modular SaaS infrastructure on AWS using Terraform. The setup includes key AWS components such as Application Load Balancer, Cognito for authentication, DynamoDB for NoSQL storage, RDS for relational databases, API Gateway with Lambda functions, and SNS/SQS for messaging.

## **Project Structure**

The project is organized into modules to ensure reusability and clarity. Below is an overview of each module:

```plaintext
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── alb/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── cognito/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── dynamodb/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── rds/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── api_gateway/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   ├── sns_sqs/
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
```

### **1. Virtual Private Cloud (VPC)**
Provides network isolation for your resources.
- **Features:**
  - Public and private subnets across multiple availability zones.
  - Internet Gateway for public access.
  - NAT Gateway for private subnet internet access.
- **Outputs:**
  - VPC ID
  - Public and private subnet IDs

### **2. Application Load Balancer (ALB)**
Distributes traffic across multiple EC2 instances or services for high availability.
- **Features:**
  - Configured with target groups and listeners.
  - Multi-AZ deployment for fault tolerance.
- **Outputs:**
  - ALB DNS name

### **3. Cognito (Authentication)**
Handles user authentication and authorization.
- **Features:**
  - User Pool with password policies.
  - App Client for secure API interaction.
- **Outputs:**
  - Cognito User Pool ID
  - App Client ID

### **4. DynamoDB (NoSQL Storage)**
Manages unstructured data with low latency.
- **Features:**
  - Pay-per-request billing mode.
  - Streams enabled for real-time updates.
- **Outputs:**
  - Table name

### **5. RDS (Relational Database Service)**
Provides a scalable and reliable relational database.
- **Features:**
  - MySQL database with multi-AZ support.
  - Secure connections via a DB subnet group.
- **Outputs:**
  - RDS endpoint

### **6. API Gateway and Lambda (FaaS)**
Provides an API interface to serverless functions.
- **Features:**
  - REST API integrated with Lambda functions.
  - Environment variables for dynamic configurations.
- **Outputs:**
  - API Gateway ID
  - Lambda ARN

### **7. SNS & SQS (Messaging)**
Facilitates message delivery between components.
- **Features:**
  - SNS topic for notifications.
  - SQS queue for asynchronous processing.
  - Subscription connecting SNS to SQS.
- **Outputs:**
  - SNS Topic ARN
  - SQS Queue ARN

---

### **Logical Diagram**

- **Suggested Flow:**
1. The user accesses the application via ALB.
2. Cognito authenticates the user and generates a JWT token.
3. API Gateway handles authenticated API requests.
4. Lambda functions process business logic, interacting with DynamoDB or Aurora.
5. SNS distributes critical events to SQS queues, Lambda, or EventBridge for additional processing.

### **Additional Considerations**  
- **High Availability:** Use Multi-AZ and Multi-Region for critical services if it’s a global SaaS solution.  
- **Monitoring:** Set up key metrics in CloudWatch and enable AWS X-Ray for traceability.  
- **Security:** Apply the principle of least privilege in IAM, use WAF with custom rules, and perform regular audits with AWS Security Hub.
---

## **Getting Started**

### **Prerequisites**
1. **Terraform**: Ensure you have Terraform installed. You can download it from [Terraform's official website](https://www.terraform.io/downloads).
2. **AWS CLI**: Install and configure the AWS CLI with appropriate credentials.
3. **IAM Role**: Ensure your IAM role has permissions to manage the required AWS resources.

### **Setup Instructions**

1. **Clone the Repository:**
   ```bash
   git clone <repository-url>
   cd terraform_aws_project
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Review Variables:**
   Edit the `variables.tf` files in each module or the root `terraform.tfvars` file to customize the environment (e.g., `environment`, `region`, etc.).

4. **Plan the Deployment:**
   ```bash
   terraform plan
   ```

5. **Apply the Changes:**
   ```bash
   terraform apply
   ```

6. **Verify Outputs:**
   Upon successful deployment, Terraform will display the key outputs such as ALB DNS, RDS Endpoint, Cognito User Pool ID, etc.

---

## **Code Documentation**
Each module contains the following files:
- **`main.tf`**: Defines the AWS resources.
- **`variables.tf`**: Lists input variables for customization.
- **`outputs.tf`**: Specifies the output values.

Comments in the code explain the purpose and configuration of each resource.

---

## **Testing**
After deployment, you can:
- Access the application via the ALB DNS.
- Test user authentication using Cognito.
- Verify data storage in DynamoDB and RDS.
- Trigger API endpoints via API Gateway and monitor Lambda executions.
- Send messages to SNS and observe delivery to SQS.

---

## **Cleanup**
To remove all deployed resources, run:
```bash
terraform destroy
```

