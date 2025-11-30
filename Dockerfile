FROM ubuntu:20.04

# Prevent interactive prompts during apt operations (build-time only)
ARG DEBIAN_FRONTEND=noninteractive

# Install Apache and curl, clean apt cache and lists in one RUN statement
RUN apt-get update && \
    apt-get install -y --no-install-recommends apache2 curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Apache's default web root
WORKDIR /var/www/html

# Copy your site files into /var/www/html
COPY ./2147_titan_folio/ .

# Expose HTTP port
EXPOSE 80

# Run Apache in the foreground (Ubuntu uses apache2ctl)
CMD ["apache2ctl", "-D", "FOREGROUND"]
