#
# Build stage
#
FROM openjdk:18-slim AS build
COPY ./ /home/app/
WORKDIR /home/app/
RUN chmod +x ./mvnw && ./mvnw -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:18-slim
COPY --from=build /home/app/target/*.jar /usr/local/lib/configserver.jar
EXPOSE 8888
ENTRYPOINT ["java","-jar","/usr/local/lib/configserver.jar"]