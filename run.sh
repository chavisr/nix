#!/bin/bash

set -euo | pipefail

home-manager switch --flake .#chavi -b backup
