# builder image
FROM golang:1.18.1-alpine as base
WORKDIR /builder
RUN apk add upx
ENV GO111MODULE=on CGO_ENABLED=0
COPY go.mod go.sum /builder/
RUN go mod download
COPY . .
RUN go build -o /builder/main /builder/cmd/app/main.go
RUN upx -9 /builder/main

# runner image
FROM alpine:3.8
WORKDIR /app
COPY --from=base /builder/main main
EXPOSE 8901
CMD ["/app/main"]