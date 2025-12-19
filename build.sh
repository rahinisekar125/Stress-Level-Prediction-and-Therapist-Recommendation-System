#!/bin/bash

# Build script for Render deployment
echo "Building StressApp for Render deployment..."

# Clean and package the application
mvn clean package -DskipTests

# Build Docker image
echo "Building Docker image..."
docker build -t stress-app .

echo "Build complete! Ready for deployment."
echo ""
echo "To test locally:"
echo "docker run -p 8080:8080 -e DATABASE_URL='your-db-url' -e DATABASE_USERNAME='your-user' -e DATABASE_PASSWORD='your-pass' stress-app"
echo ""
echo "For Render deployment:"
echo "1. Push this code to GitHub"
echo "2. Connect repository to Render"
echo "3. Set environment variables in Render dashboard"
echo "4. Deploy!"