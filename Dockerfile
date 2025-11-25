# Step 1: Use Python image
FROM python:3.10-slim AS build

# Set working directory
WORKDIR /app

# Copy requirements first (for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the entire project
COPY . .

# Collect static files (optional)
RUN python manage.py collectstatic --noinput

# Step 2: Expose port
EXPOSE 8000

# Step 3: Run Gunicorn
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "0.0.0.0:8000"]