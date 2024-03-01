# Use an official Ubuntu image as base
FROM postgres

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    python3-pip \
    python3-dev \
    groff \
    less \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI using pip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -f awscliv2.zip
    
# Reminder to use environment variables or mounted volumes for AWS configuration
RUN echo "Remember to configure AWS CLI using environment variables or by mounting your .aws directory."
WORKDIR /a1vincent-backup
COPY . .
RUN chmod +x backup.sh

# Command to run when the container starts
CMD ["./backup.sh"]


