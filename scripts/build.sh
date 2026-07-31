#!/bin/bash
# This script was designed to run on GitHub Codespaces.

# Install elan.
curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | bash -s -- -y
source $HOME/.elan/env

# Build the Lean project.
lake exe cache get
lake build
