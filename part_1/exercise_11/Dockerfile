FROM amazoncorretto:8

WORKDIR /app

EXPOSE 8080

COPY /spring-example-project /app

RUN ./mvnw package

CMD ["java", "-jar", "./target/docker-example-1.1.3.jar"]


