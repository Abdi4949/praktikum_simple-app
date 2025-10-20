# Gunakan image base Python
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy file requirements.txt ke container
COPY requirements.txt ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy seluruh file project ke /app
COPY . .

# Expose port untuk Flask / FastAPI
EXPOSE 5000

# Jalankan aplikasi
CMD ["python", "app.py"]
