# Dockerfile — پایتون + هسته‌ی Xray (برای Reality / gRPC / HTTPUpgrade)
FROM python:3.11-slim
RUN apt-get update && apt-get install -y --no-install-recommends curl unzip ca-certificates \
    && rm -rf /var/lib/apt/lists/*
# آخرین نسخه‌ی Xray (برای XHTTP+Reality حداقل v24.11 لازمه)
RUN curl -fsSL -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
    && unzip -o /tmp/xray.zip xray -d /usr/local/bin && chmod +x /usr/local/bin/xray && rm /tmp/xray.zip
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "main.py"]
