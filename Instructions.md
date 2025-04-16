1) Create an EC2 instance with a key pair in one of the availability zones (AZ). Use a basic configuration.

2) Login to the EC2 instance.

3) Update and install Docker:
    ```
    sudo yum update -y
    sudo yum install -y docker
    sudo service docker start
    sudo usermod -aG docker ec2-user
    ```
    Restart your system:
    ```
    sudo reboot
    ```
    After reboot, start Docker again:
    ```
    sudo service docker start
    docker info
    ```

4) Create your application (your choice).

5) Create a role for EC2 to access S3.

6) Configure AWS CLI with your credentials:
    ```
    aws configure
    ```

7) Set up a simple project:
    ```
    sudo mkdir ecs-project
    cd ecs-project
    sudo aws s3 cp s3://drt-ecs-project-data/app.zip .
    sudo unzip app.zip
    sudo chmod 777 app/*
    cd app
    docker build -t myapp1:1.0 .
    docker images
    ```

8) Run the Docker container:
    ```
    docker run -d --name myapp1 -p 80:80 myapp1:1.0
    docker ps
    ```
    To stop the container:
    ```
    docker stop <container_id>
    ```

9) ECR instructions (update as needed):
    Retrieve an authentication token and authenticate your Docker client to your registry:
    ```
    aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/e3g4z7p1
    ```
    Note: Ensure you have the latest version of AWS CLI and Docker installed.

    Build your Docker image:
    ```
    docker build -t test32 .
    ```

    Tag your image:
    ```
    docker tag test32:latest public.ecr.aws/e3g4z7p1/test32:latest
    ```

    Push the image to the AWS repository:
    ```
    docker push public.ecr.aws/e3g4z7p1/test32:latest
    ```