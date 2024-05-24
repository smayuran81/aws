AWS terraform: setting up vpc using terraform
Includes terraform to set up vpc with remote storage set up
single vpc with dynamo db and S3 bucket

#### TO DO (Terraform to deploy app):
1. Enhance this to deploy java code as ECS service via code pipe line



#### Spring boot ECS 
2. Sring boot app with docker - Added docker file and created an image for the spring boot app
3. Create an ECR registry in AWS 
4. Add buildspec.yml file to the spring boot app
5. create code build project and link to github using token(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)
6. Role name: codebuild-Springboot-service-role
7. Above role needs permission to push the image to ECR registry - go to i am and search for the role and attach the container policy to it


##### AWS Code deploy
1. Create ECS Cluster - create a cluster with fargate launch type
2. Create Task Definition -  for health check use the above command(curl need to be included in the docker defintion) CMD-SHELL, curl -f http://localHost/8081/health || exit 1 
3. Create service
4. Deploy Task

######
######
Docker commands
docker ps -a - list all the containers that is running




