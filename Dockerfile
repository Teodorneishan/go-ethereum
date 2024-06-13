# Use an official Ubuntu base image
FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget git build-essential curl && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Install Go
RUN wget https://go.dev/dl/go1.22.4.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.22.4.linux-amd64.tar.gz && \
    rm go1.22.4.linux-amd64.tar.gz

# Update PATH environment variable
ENV PATH /usr/local/go/bin:$PATH

# Clone the go-ethereum repository 
RUN git clone https://github.com/Teodorneishan/go-ethereum.git && \
    cd go-ethereum && \
    git checkout v1.10

# Set the working directory
WORKDIR ./go-ethereum

# Build the go-ethereum project
RUN make geth

# Expose necessary ports
EXPOSE 30304 8552 8553

# Command to start the blockchain network
CMD ["build/bin/geth", "--datadir", "datadir", "--port", "30304", "--http", "--http.addr", "localhost", "--http.port", "8552", "--http.api", "personal,eth,web3,txpool,admin", "--networkid", "2345", "--allow-insecure-unlock", "--authrpc.port", "8553", "--nodiscover", "console"]

