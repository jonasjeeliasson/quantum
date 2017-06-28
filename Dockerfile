FROM openjdk:8u131-jre-alpine
VOLUME /tmp
ADD target/quantum-0.0.1-SNAPSHOT.jar app.jar
RUN sh -c 'touch app.jar'
EXPOSE 8080
ENV JAVA_OPTS=""
ENTRYPOINT ["java", $JAVA_OPTS, "-Djava.security.egd=file:/dev/./urandom","-jar","app.jar"]