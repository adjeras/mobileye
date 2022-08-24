FROM python:3.8

LABEL maintainer="adjerassi"

COPY src /src
COPY data /data

ENV RESPONCE="Hello World"

WORKDIR /src

RUN pip install -r requirements.txt

EXPOSE 5000

#ENTRYPOINT ["python", "-m", "flask", "run"]
ENTRYPOINT ["python"]
CMD ["app.py"]
#ENTRYPOINT ["python3", "app.py"]
#CMD ["python3", "-m", "flask", "run"]
