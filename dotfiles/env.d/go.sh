git -C ~/.goenv pull > /dev/null 2>&1
export GOENV_ROOT="$HOME/.goenv"
export PATH="$PATH:$GOENV_ROOT/bin"
eval "$(goenv init -)"
export PATH="$PATH:$(go env GOROOT)/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
export GO111MODULE=on