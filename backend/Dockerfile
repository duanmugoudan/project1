FROM 10.0.0.31:80/library/python:3.11.9-slim

RUN sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list.d/debian.sources \
 && sed -i 's|security.debian.org|mirrors.aliyun.com/debian-security|g' /etc/apt/sources.list.d/debian.sources




WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt \
    -i https://mirrors.aliyun.com/pypi/simple/ \
    --timeout 60 \
    --trusted-host mirrors.aliyun.com

EXPOSE  8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
