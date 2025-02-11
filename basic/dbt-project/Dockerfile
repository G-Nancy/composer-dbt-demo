FROM python:3.9.2

# Install required system packages and cleanup to reduce image size
RUN apt-get update -y && \
  apt-get install --no-install-recommends -y -q \
  git libpq-dev python-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install data build tool
RUN pip install -U pip
RUN pip install dbt-bigquery==0.20.1

# Set working directory
ENV DBT_DIR /dbt/
WORKDIR $DBT_DIR

# Copy files to the image
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt
COPY . $DBT_DIR

# Run dbt
ENTRYPOINT ["dbt"]