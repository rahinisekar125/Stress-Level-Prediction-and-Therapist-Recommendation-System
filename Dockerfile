# Use Eclipse Temurin Java 17 as base image (official OpenJDK replacement)
FROM eclipse-temurin:17-jdk

# Install Maven
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy pom.xml first for better Docker layer caching
COPY pom.xml .

# Copy source code
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# Install required packages for Tomcat
RUN apt-get update && \
    apt-get install -y wget curl && \
    rm -rf /var/lib/apt/lists/*

# Download and install Tomcat
RUN wget -q https://downloads.apache.org/tomcat/tomcat-10/v10.1.31/bin/apache-tomcat-10.1.31.tar.gz && \
    tar -xzf apache-tomcat-10.1.31.tar.gz && \
    mv apache-tomcat-10.1.31 tomcat && \
    rm apache-tomcat-10.1.31.tar.gz

# Copy the WAR file to Tomcat webapps directory
COPY target/StressApp.war /app/tomcat/webapps/

# Create a startup script that configures Tomcat to use the PORT environment variable
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Configure Tomcat to listen on the PORT provided by Render\n\
if [ -n "$PORT" ]; then\n\
    echo "Configuring Tomcat to listen on port $PORT"\n\
    sed -i "s/8080/$PORT/g" /app/tomcat/conf/server.xml\n\
    export JPDA_ADDRESS="$PORT"\n\
else\n\
    echo "PORT environment variable not set, using default port 8080"\n\
fi\n\
\n\
# Start Tomcat\n\
cd /app/tomcat/bin\n\
exec ./catalina.sh run\n\
' > /app/start.sh && chmod +x /app/start.sh

# Make sure the WAR file exists
RUN ls -la /app/tomcat/webapps/

# Expose port (Render will set PORT environment variable)
EXPOSE 8080

# Set environment variables for database connection
ENV DATABASE_URL=""
ENV DATABASE_USERNAME=""
ENV DATABASE_PASSWORD=""
ENV PORT=8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:$PORT/StressApp/dbtest || exit 1

# Start the application
CMD ["/app/start.sh"]