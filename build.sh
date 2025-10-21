#!/usr/bin/env bash

main(){

  HUGO_VERSION=0.145.0
  
  export TZ=Europe/London

  # Install Hugo
  echo "Installing Hugo ${HUGO_VERSION}..."
  curl -sLJO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
  mkdir "${HOME}/.local/hugo"
  tar -C "${HOME}/.local/hugo" -xf "hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
  rm "hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
  export PATH="${HOME}/.local/hugo:${PATH}"

  # Verify installations
  echo "Verifying installations..."
  echo Go: "$(go version)"
  echo Hugo: "$(hugo version)"
  echo Node.js: "$(node --version)"

  # Clone themes repository
  git submodule update --init --recursive
  git config core.quotepath false

  # Build the website ...
  hugo --gc --minify
}

set -euo pipefail
main "$@"