# Use rocker/r-ver as base for R and install Python
FROM rocker/r-ver:4.3.2

# Install Python and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip

# Set working directory
WORKDIR /app

# Copy all project files
COPY . /app

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Install R packages
RUN R -e "install.packages(c('readr', 'dplyr', 'tidyr'), repos='https://cloud.r-project.org/')"

# Expose Flask port
EXPOSE 5000

# Set environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_PORT=5000

# Run the Flask app
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
