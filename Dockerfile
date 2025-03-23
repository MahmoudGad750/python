# Use an official Python image
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy all files from your repo to container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Create SQLite DB (optional, or let app create on first run)
# RUN python -c "from your_app_module import db; db.create_all()"

# Expose Flask port
EXPOSE 5000

# Run the app
CMD ["python", "your_script_name.py"]
