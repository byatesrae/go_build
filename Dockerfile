FROM golang:1.23.0-alpine3.20

# Git complains about unsafe directories without this.
RUN touch ~/.gitconfig && \
    (echo "[safe]" >> ~/.gitconfig) && \
    (echo "  directory = /workspace" >> ~/.gitconfig)

RUN apk add --no-cache --upgrade \
    bash \
    curl \
    make \    
    grep \
    g++ \
    git \
    docker-cli

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.60.2

RUN curl -sSf https://atlasgo.sh | ATLAS_VERSION=v0.26.1 CI=true sh

RUN go install golang.org/x/pkgsite/cmd/pkgsite@v0.0.0-20240913130837-7d0ea0a0e8cd