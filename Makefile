# Makefile
VERSION ?= 0.0.0
NAME=github-actions-test

test:
	@go test -mod=vendor ./... -v

test-and-report:
	@rm -f coverage.out report.json
	@go test -mod=vendor ./... -v -coverprofile=coverage.out -json > report.json && go tool cover -func=coverage.out

build:
	@go build -mod=vendor -o ${NAME} -gcflags "all=-trimpath=$GOPATH" .

release:
	@rm -rf build/*
	GOOS=darwin GOARCH=amd64 go build -mod=vendor -o build/darwin_amd64/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/darwin_amd64.zip build/darwin_amd64/${NAME}
	GOOS=freebsd GOARCH=386 go build -mod=vendor -o build/freebsd_386/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/freebsd_386.zip build/freebsd_386/${NAME}
	GOOS=freebsd GOARCH=amd64 go build -mod=vendor -o build/freebsd_amd64/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/freebsd_amd64.zip build/freebsd_amd64/${NAME}
	GOOS=freebsd GOARCH=arm go build -mod=vendor -o build/freebsd_arm/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/freebsd_arm.zip build/freebsd_arm/${NAME}
	GOOS=linux GOARCH=386 go build -mod=vendor -o build/linux_386/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/linux_386.zip build/linux_386/${NAME}
	GOOS=linux GOARCH=amd64 go build -mod=vendor -o build/linux_amd64/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/linux_amd64.zip build/linux_amd64/${NAME}
	GOOS=linux GOARCH=arm go build -mod=vendor -o build/linux_arm/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/linux_arm.zip build/linux_arm/${NAME}
	GOOS=openbsd GOARCH=386 go build -mod=vendor -o build/openbsd_386/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/openbsd_386.zip build/openbsd_386/${NAME}
	GOOS=openbsd GOARCH=amd64 go build -mod=vendor -o build/openbsd_amd64/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/openbsd_amd64.zip build/openbsd_amd64/${NAME}
	GOOS=solaris GOARCH=amd64 go build -mod=vendor -o build/solaris_amd64/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/solaris_amd64.zip build/solaris_amd64/${NAME}
	GOOS=windows GOARCH=386 go build -mod=vendor -o build/windows_386/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/windows_386.zip build/windows_386/${NAME}
	GOOS=windows GOARCH=amd64 go build -mod=vendor -o build/windows_amd64/${NAME} -gcflags "all=-trimpath=$$GOPATH" . && zip -j build/windows_amd64.zip build/windows_amd64/${NAME}

