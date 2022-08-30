FROM python:3.8

LABEL maintainer="adjerassi"

COPY src /src
COPY data /data
COPY tmp/mobileye.txt /tmp/mobileye.txt

WORKDIR /src

RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["python", "-m", "http.server", "--directory", "/tmp/"]
