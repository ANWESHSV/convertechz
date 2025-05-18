# Use an OpenJDK base image with GUI support
FROM openjdk:11-jdk

# Install necessary packages for X11 forwarding and missing dependencies
RUN apt-get update && apt-get install -y \
    x11-apps \
    libxtst6 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code
COPY src /app/src

# Compile Java sources
RUN javac /app/src/currencyConverter/*.java

# Set environment variable for display (to be set by user when running container)
ENV DISPLAY=:0

# Expose port 8080 (if needed for any backend service, else can be removed)
EXPOSE 8080

# Command to run the Java Swing app
CMD ["java", "-cp", "/app/src", "currencyConverter.CurrencyConverter"]
