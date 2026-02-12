FROM python:3.9-slim
WORKDIR /app

# Install system dependencies for MySQL client
RUN apt-get update && apt-get install -y \
    gcc default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code
COPY . /app

EXPOSE 5000
CMD ["python", "app.py"]
