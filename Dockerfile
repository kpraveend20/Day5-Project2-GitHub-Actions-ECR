FROM ubuntu:24.04

WORKDIR /app

COPY app.sh .

RUN chmod +x app.sh

CMD ["./app.sh"]