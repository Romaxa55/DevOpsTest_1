FROM python:3.7-alpine

COPY requirements.txt main.py  ./app/

WORKDIR /app

RUN pip install -r requirements.txt
RUN apk --update add curl

HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl --fail http://localhost:8080/healthz || exit 1

CMD ["python", "main.py"]
