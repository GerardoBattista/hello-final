FROM openjdk:16 AS base
WORKDIR /opt/hello-final
COPY ./ ./
RUN ./gradlew assemble
FROM amazoncorretto:16
WORKDIR /opt/hello-final
COPY ./ ./
COPY --from=base /opt/hello-final/build/libs/hello-final-0.0.1-SNAPSHOT.jar ./
CMD java -jar hello-final-0.0.1-SNAPSHOT.jar ./
