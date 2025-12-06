#######################################################
# Run Evironment for java22
# docker build -t java22 .
# docker run --rm java22
# (c) 2025 cndrbrbr
#######################################################

FROM debian:bookworm-slim

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    mc \
    screen \
    nano \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Add Adoptium APT repo for JDK 22
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor -o /usr/share/keyrings/adoptium.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb bookworm main" \
    > /etc/apt/sources.list.d/adoptium.list

# Install Temurin JDK 22
RUN apt-get update && apt-get install -y temurin-22-jdk && \
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME
ENV JAVA_HOME="/usr/lib/jvm/temurin-22-jdk"
ENV PATH="$JAVA_HOME/bin:${PATH}"

WORKDIR /app

CMD ["java", "-version"]
