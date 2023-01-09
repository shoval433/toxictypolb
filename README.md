toxictypolb
===

#### Welcome to the ToxicTypoLB project!

This project is based on the ToxicTypoApp and includes an additional API at http://<server:port>/api/name. This API allows users to POST a form parameter called "name" to set the name, and GET the API to retrieve the last set name.

The goal of this project is to exercise our use of AWS EC2, specifically the Load Balancer (ELB or ALB). We will use this app to create and configure two EC2 instances that are served by an ALB.

To complete this project, follow this work plan:

    Push the source code to GitLab.
    Dockerize the app and test it locally to ensure that the ToxicTypo app is working and that the /api/name API is functional.
    Create a Jenkins pipeline on the master branch that builds the application, builds the Docker image, and pushes the image to the AWS Elastic Container Registry (ECR).
    In AWS, create two EC2 instances and configure an ALB as their gateway. Each instance should serve a single ToxicTypoLB app on port 80. Test that the new API can be accessed from outside of AWS.
    Demonstrate that both servers are being accessed by setting and getting different names.
    Improve the Jenkins pipeline by adding steps to remove an instance from the ALB, update the instance with the new Docker image and restart it, and re-register the instance with the ALB. Repeat these steps for the second instance.

We hope that this guide will help you to successfully complete the ToxicTypoLB project. Good luck!
