ifeq ($(GOPATH),)
  $(error GOPATH is not set, terminating)
endif

BINARY :=
VET_REPORT := vet
TEST_REPORT := test

VERSION ?= 1.0.0
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
COMMIT := $(shell git rev-parse --short HEAD)
COMMIT_TIME := $(shell git log -1 --format=%ci)
BUILD :=

# Symlink into GOPATH
ORG :=
PROJECT :=
REPO := github.com/${ORG}/${PROJECT}
ROOT_DIR := ${GOPATH}/src/${REPO}
SOURCE_DIR :=
OUTPUT_DIR := ${ROOT_DIR}/dist
$(shell mkdir -p ${OUTPUT_DIR})

# Supported platforms and tools
PLATFORMS := linux/amd64 windows/amd64 darwin/amd64
GOOS = $(word 1, $(subst /, ,$@))
GOARCH = $(word 2, $(subst /, ,$@))
PWD = $(shell pwd)

# Setup the -ldflags option for go build here, interpolate the variable values
LDFLAGS = -ldflags "-X ${REPO}/x.name=${PROJECT} -X ${REPO}/x.version=${VERSION} -X ${REPO}/x.gitBranch=${BRANCH} -X ${REPO}/x.lastCommitSHA=${COMMIT} -X '${REPO}/x.lastCommitTime=${COMMIT_TIME}' -X ${REPO}/x.build=${BUILD}"

# Targets
all: clean vet test $(PLATFORMS)

$(PLATFORMS):
	cd ${SOURCE_DIR}; \
	GOOS=${GOOS} GOARCH=${GOARCH} go build ${LDFLAGS} -o ${OUTPUT_DIR}/bin/${BINARY}.${GOOS}.${GOARCH} . ; \
	cd - >/dev/null

vet:
	-cd ${ROOT_DIR}; \
	go vet ./... > ${OUTPUT_DIR}/${VET_REPORT} 2>&1 ; \
	cd - >/dev/null

test:
	-cd ${ROOT_DIR}; \
	go test ./... > ${OUTPUT_DIR}/${TEST_REPORT} 2>&1 ; \
	cd - >/dev/null

rsa2048:
	-mkdir -p ${OUTPUT_DIR}/pk
	openssl genrsa -out ${OUTPUT_DIR}/pk/${PROJECT}.private.key 2048
	openssl rsa -in ${OUTPUT_DIR}/pk/${PROJECT}.private.key -outform PEM -pubout -out ${OUTPUT_DIR}/pk/${PROJECT}.public.pem

clean:
	-rm -rf ${OUTPUT_DIR}/*

.PHONY: linux darwin windows test vet clean