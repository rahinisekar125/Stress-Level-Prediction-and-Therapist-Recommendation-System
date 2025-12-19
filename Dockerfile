# Use official Tomcat 10.1 with JDK 17
FROM tomcat:10.1-jdk17

# Install Maven
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

# Set working directory for build
WORKDIR /app

# Copy pom.xml first for better Docker layer caching
COPY pom.xml .

# Copy source code
COPY src ./src

# Build the WAR file
RUN mvn clean package -DskipTests

# Copy the WAR file to Tomcat webapps directory
RUN cp /app/target/StressApp.war /usr/local/tomcat/webapps/

# Create a startup script that configures Tomcat to use the PORT environment variable
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Configure Tomcat to listen on the PORT provided by Render\n\
if [ -n "$PORT" ]; then\n\
    echo "Configuring Tomcat to listen on port $PORT"\n\
    sed -i "s/8080/$PORT/g" /usr/local/tomcat/conf/server.xml\n\
    export JPDA_ADDRESS="$PORT"\n\
else\n\
    echo "PORT environment variable not set, using default port 8080"\n\
fi\n\
\n\
# Start Tomcat\n\
cd /usr/local/tomcat/bin\n\
exec ./catalina.sh run\n\
' > /usr/local/tomcat/start.sh && chmod +x /usr/local/tomcat/start.sh

# Make sure the WAR file exists
RUN ls -la /usr/local/tomcat/webapps/

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
CMD ["/usr/local/tomcat/start.sh"]