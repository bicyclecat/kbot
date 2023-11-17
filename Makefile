APP:=$(shell basename -s .git $(shell git remote get-url origin))
REGISTRY=bicyclecat
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

TARGETOS=linux # arm macOS Windows
TARGETARCH=amd64 # arm64 

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get-dependencies:
	go get

build: format get-dependencies
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/bicyclecat/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS} --build-arg TARGETOS=${TARGETOS}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}