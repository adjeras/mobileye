FROM python:3.8

LABEL maintainer="adjerassi"

COPY src /src
COPY data /data
COPY tmp/mobileye.txt /tmp/mobileye.txt

ENV RESPONCE="Hello World"

WORKDIR /src

RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python"]
CMD ["app.py"]
