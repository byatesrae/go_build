FROM golang:1.24.4-alpine3.22

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

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v2.1.6

RUN curl -sSf https://atlasgo.sh | ATLAS_VERSION=v0.34.0 CI=true sh

RUN go install golang.org/x/pkgsite/cmd/pkgsite@v0.0.0-20250611185244-041c7c0b878c