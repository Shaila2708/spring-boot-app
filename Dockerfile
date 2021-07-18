FROM openjdk:8 as build
ARG VERSION=3.8.1
WORKDIR /app
RUN wget https://downloads.apache.org/maven/maven-3/$VERSION/binaries/apache-maven-$VERSION-bin.zip
RUN unzip apache-maven-$VERSION-bin.zip 
RUN mv apache-maven-$VERSION-bin.zip apache-maven
RUN rm -rf apache-maven-$VERSION-bin.zip
ENV MAVEN_HOME=/app/apache-maven-$VERSION
ENV PATH="$MAVEN_HOME/bin:$PATH"
COPY . .
RUN mvn clean package
#RUN java -jar -Dspring.profiles.active=test target/spring-boot-rest-example-0.5.0.war
ENTRYPOINT ["java","-jar","-Dspring.profiles.active=test","target/spring-boot-rest-example-0.5.0.war"]

#FROM openjdk:8-jdk-alpine
#COPY --from=build  /app/target/docker-product-server-1.0.0.jar docker-product-server-1.0.0.jar
#ENTRYPOINT ["java","-jar","-Dspring.profiles.active=test","/docker-product-server-1.0.0.jar"]

