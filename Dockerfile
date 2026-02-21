FROM nikolaik/python-nodejs:python3.10-nodejs19-bullseye

# System dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg aria2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy only requirements first (better caching)
COPY requirements.txt .

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy remaining project files
COPY . .

# Start bot
CMD ["python", "-m", "bot.main"]
