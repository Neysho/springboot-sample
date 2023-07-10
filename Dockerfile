FROM openjdk:8
EXPOSE 8080
ADD target/springboot-sample.jar springboot-sample.jar
ENTRYPOINT ["java","-jar","/springboot-sample.jar"]