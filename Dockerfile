FROM openjdk:17
RUN apk add curl
VOLUME /tmp
EXPOSE 8080
ADD target/springboot-aws-deploy-service.jar springboot-aws-deploy-service.jar
ENTRYPOINT ["java", "-jar", "springboot-aws-deploy-service.jar"]