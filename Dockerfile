# Use an OpenJDK base image with GUI support
FROM openjdk:11-jdk

# Install necessary packages for X11 forwarding, Xvfb and missing dependencies
RUN apt-get update && apt-get install -y \
    xvfb \
    x11-apps \
    libxtst6 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code
COPY src /app/src

# Compile Java sources
RUN javac /app/src/currencyConverter/*.java

# Set environment variable for Xvfb display
ENV DISPLAY=:99

# Expose port 8080 (if needed for any backend service, else can be removed)
EXPOSE 8080

# Command to run the Java Swing app with Xvfb
CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x16 & java -cp /app/src currencyConverter.CurrencyConverter"]
