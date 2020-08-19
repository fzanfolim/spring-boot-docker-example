
#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/springboot-docker-compose.jar /usr/local/lib/springboot-docker-compose.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","/usr/local/lib/springboot-docker-compose.jar"]


# FROM openjdk:8
# VOLUME /tmp
# ADD target/springboot-docker-compose.jar springboot-docker-compose.jar
# # COPY --from=builder /home/gradle/src/build/libs/*.jar .
# # RUN ls -la
# EXPOSE 8081
# ENTRYPOINT ["java","-jar","springboot-docker-compose.jar"]