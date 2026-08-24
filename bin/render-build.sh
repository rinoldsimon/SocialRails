#!/usr/bin/env bash
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails db:migrate
if [ "$FORCE_SEEDS" = "1" ]; then
  bundle exec rails db:seed
fi
