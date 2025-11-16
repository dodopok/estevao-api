#!/usr/bin/env bash

set -o errexit

# Ensure SECRET_KEY_BASE is set
if [ -z "$SECRET_KEY_BASE" ]; then
  echo "ERROR: SECRET_KEY_BASE environment variable is not set!"
  echo "Please add SECRET_KEY_BASE to your Render environment variables."
  echo "You can generate one using: ruby -e \"require 'securerandom'; puts SecureRandom.hex(64)\""
  exit 1
fi

bundle install
bin/rails db:migrate
bin/rails db:seed
