# Use OpenJDK 17 as base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the WAR file to the container
COPY target/StressApp.war /app/StressApp.war

# Install Tomcat
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.31/bin/apache-tomcat-10.1.31.tar.gz && \
    tar -xzf apache-tomcat-10.1.31.tar.gz && \
    mv apache-tomcat-10.1.31 tomcat && \
    rm apache-tomcat-10.1.31.tar.gz

# Copy the WAR file to Tomcat webapps directory
RUN cp /app/StressApp.war /app/tomcat/webapps/

# Create a startup script that configures Tomcat to use the PORT environment variable
RUN echo '#!/bin/bash\n\
# Configure Tomcat to listen on the PORT provided by Render\n\
if [ -n "$PORT" ]; then\n\
    sed -i "s/8080/$PORT/g" /app/tomcat/conf/server.xml\n\
    echo "Tomcat configured to listen on port $PORT"\n\
else\n\
    echo "PORT environment variable not set, using default port 8080"\n\
fi\n\
\n\
# Start Tomcat\n\
exec /app/tomcat/bin/catalina.sh run\n\
' > /app/start.sh && chmod +x /app/start.sh

# Expose port (Render will set PORT environment variable)
EXPOSE 8080

# Set environment variables for database connection
ENV DATABASE_URL=""
ENV DATABASE_USERNAME=""
ENV DATABASE_PASSWORD=""
ENV PORT=8080

# Start the application
CMD ["/app/start.sh"]