# Build stage
FROM openjdk:16.0.2 AS base
WORKDIR /opt/hello-final
COPY ./ ./
RUN ./gradlew assemble

# Runtime stage
FROM amazoncorretto:16.0.2
WORKDIR /opt/hello-final
COPY ./ ./ 
COPY --from=base /opt/hello-final/build/libs/hello-final-0.0.1-SNAPSHOT.jar ./
CMD java -jar HelloFinal-0.0.1-SNAPSHOT.jar
