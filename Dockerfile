# Build stage
FROM openjdk:11 AS base
WORKDIR /home/viewadmin/hello-final
COPY ./ ./
RUN ./gradlew assemble

# Runtime stage
FROM amazoncorretto:11
WORKDIR /home/viewadmin/hello-final
COPY --from=base /home/viewadmin/hello-final/build/classes/java/main/com/viewnext/hellofinal/HelloFinal-0.0.1-SNAPSHOT.jar ./
CMD java -jar HelloFinal-0.0.1-SNAPSHOT.jar

