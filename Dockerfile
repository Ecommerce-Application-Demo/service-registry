FROM gradle:8.5-jdk21-alpine AS DEPS

WORKDIR /app
COPY . /app/

WORKDIR /app
RUN gradle build -x test


FROM openjdk:21-jdk-slim

WORKDIR /app
COPY --from=DEPS /app/build/libs /app/build

EXPOSE 8761

CMD ["java", "-jar", "/app/build/service-registry.jar"]