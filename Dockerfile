FROM golang:1.12-alpine
LABEL name="aws-es-proxy" \
  version="latest"

RUN apk add --update bash curl git && rm /var/cache/apk/*

ENV GO111MODULE=on

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /usr/local/bin/aws-es-proxy


ENV PORT_NUM 9200
EXPOSE ${PORT_NUM}

ENTRYPOINT ["aws-es-proxy"] 
CMD ["-h"]