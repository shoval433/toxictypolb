
FROM tomcat:9.0.70-jre8-temurin-jammy
WORKDIR /toxi
COPY . .

ENTRYPOINT java -jar target/toxictypoapp-1.0-SNAPSHOT.jar
# ENTRYPOINT bash


