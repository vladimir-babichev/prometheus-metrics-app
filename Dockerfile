FROM golang:1.12-alpine as builder

WORKDIR /go/src/metrics-app
RUN apk add --no-cache git

COPY . .
ENV GO111MODULE=on
RUN go get ./...

ARG VERSION=0.1.0
ENV CGO_ENABLED=0 \
    GOOS=linux \
    LDFLAGS="-X main.appVersion=${VERSION}"
RUN set -x && export && \
    go build \
        -v \
        -ldflags="${LDFLAGS}" \
        -o /go/bin/metrics-app

FROM scratch
COPY --from=builder /go/bin/metrics-app /
ENTRYPOINT ["/metrics-app"]
