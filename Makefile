.DEFAULT_GOAL := full-check

install-linter:
	go install golang.org/x/lint/golint@latest
	go install golang.org/x/vuln/cmd/govulncheck@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install mvdan.cc/gofumpt@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/fzipp/gocyclo/cmd/gocyclo@latest
	go install github.com/alexkohler/nakedret/cmd/nakedret@latest
	go install github.com/alexkohler/dogsled/cmd/dogsled@latest
	go install github.com/quasilyte/go-consistent@latest
	go install github.com/jgautheron/goconst/cmd/goconst@latest
	go install honnef.co/go/tools/cmd/staticcheck@latest
	go install github.com/mgechev/revive@master
	go install github.com/mdempsky/unconvert@latest
	go install github.com/securego/gosec/v2/cmd/gosec@latest
	go install -v github.com/go-critic/go-critic/cmd/gocritic@latest
.PHONY : init-tools

fmt:
	gofmt -s -w .
.PHONY: fmt

lint: fmt
	golint -set_exit_status ./...
.PHONY: lint

vet:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO VET STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	go vet ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO VET FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: vet

test:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO TEST STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	go test -v ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO TEST FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: test

govulcheck:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO VULN CHECK STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	govulcheck ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO VULN CHECK FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: govulcheck

golangci-lint:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GOLANGCI LINT STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	golangci-lint run
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GOALANGCI LINT FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: golangci-lint

gofumpt:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO FUMPT STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	gofumpt -w -l .
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO FUMPT FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: gofumpt

gocyclo:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO CYCLO STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	gocyclo .
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO CYCLO FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: gocyclo

nakedret:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< NAKEDRET STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	go vet -vettool=$(which nakedret) ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< NAKEDRET FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: nakedret

dogsled:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< DOGSLED STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	dogsled ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< DOGSLED FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: dogsled

go-consistent:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO CONSISTENT STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	go-consistent ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO CONSISTENT FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: go-consistent

go-const:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO CONST STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	goconst ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GO CONST FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: go-const

staticcheck:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< STATIC CHECK STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	staticcheck ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< STATIC CHECK FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: staticcheck

revive:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< REVIVE STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	revive ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< REVIVE FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'

unconvert:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< UNCONVERT STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	unconvert ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< UNCONVERT FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: unconvert
gosec:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GOSEC STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	gosec  ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GOSEC FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: gosec

gocritic:
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GOCRITIC STARTED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
	gocritic check ./...
	echo '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< GOCRITIC FINISHED >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
.PHONY: gocritic


full-check: fmt vet lint govulcheck gofumpt golangci-lint gocyclo nakedret dogsled go-consistent go-const staticcheck revive unconvert gosec gocritic
.PHONY: full-check
