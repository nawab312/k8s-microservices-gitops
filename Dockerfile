FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app
COPY k8s-microservices-gitops/spring-petclinic/.mvn/ .mvn
COPY k8s-microservices-gitops/spring-petclinic/mvnw spring-petclinic/pom.xml ./
RUN ./mvnw dependency:resolve
COPY spring-petclinic/src ./src

#Build Application
RUN ./mvnw package -DskipTests

#Stage2
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]