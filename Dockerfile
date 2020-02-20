FROM openjdk:8-alpine
RUN apk update && apk add /bin/sh
RUN mkdir -p /opt/app
ENV PROJECT_HOME /opt/app
COPY target/SpringBootMavenExample-1.0.war $PROJECT_HOME/SpringBootMavenExample.war
WORKDIR $PROJECT_HOME
CMD ["java", "-Dspring.data.mongodb.uri=mongodb://mongo:27017/spring-mongo","-Djava.security.egd=file:/dev/./urandom","-jar","./SpringBootMavenExample.jar"]
