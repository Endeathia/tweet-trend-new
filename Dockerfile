FROM openjdk:8
ADD /jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar demo-workshop-2.1.2.jar
ENTRYPOINT [ "java", "-jar", "demo-workshop-2.1.2.jar" ]