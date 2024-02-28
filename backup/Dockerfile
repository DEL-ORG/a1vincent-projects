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
WORKDIR /backup
COPY . .
RUN chmod +x backup.sh

# Command to run when the container starts
CMD ["/backup/backup.sh"]

ENV DB_USER='doadmin'
ENV DB_NAME='s6-user'
ENV DB_HOST='db-postgresql-nyc3-26515-do-user-12198957-0.c.db.ondigitalocean.com'
ENV DB_PORT='25060'
ENV DB_PASSWORD='AVNS_HkmaatXJL1QfH60HmnZ'
ENV AWS_ACCESS_KEY_ID='AKIAZI2LE2Z6CLDSGQZ7'
ENV AWS_SECRET_ACCESS_KEY='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'
ENV AWS_DEFAULT_REGION='us-east-1'
ENV BUCKET_NAME='del-db-backup/S6/a1vincent/'
