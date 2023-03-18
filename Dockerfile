FROM ubuntu:22.04

RUN apt-get update && apt-get install --no-install-recommends -y python3.10 python3-pip && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /src

COPY . /src/

RUN pip3 install --no-cache-dir wheel

RUN pip3 install --no-cache-dir -r requirements.txt

ENV PYTHONUNBUFFERED=1

ENV PYTHONDONTWRITEBYTECODE=1

CMD gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 0 backend.wsgi:application
