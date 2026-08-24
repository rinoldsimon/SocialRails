# SocialRails

A chronological town square for builders. Rails 8, Hotwire, Postgres. Newest first. No ranking. No ads.

## Demo

```bash
export PATH="/opt/homebrew/opt/ruby@3.4/bin:/opt/homebrew/opt/postgresql@16/bin:$PATH"
cd /Users/rinold/Work/SocialRails
bin/setup
bin/dev
```

Open http://localhost:3000

Local mail (password reset, etc.) is at http://localhost:3000/letter_opener — not a real inbox.

Demo login: `maya@socialrails.dev` / `demo1234`  
(also arjun, lena, theo, priya, jonah, sofia, kenji @ socialrails.dev)

## What I need from you to go live

Nothing is required to run locally.

| You create | I wire |
| --- | --- |
| Render account (free web) | `render.yaml` + this README |
| Neon Postgres (paste `DATABASE_URL`) | Production DB |
| Google OAuth client ID + secret (optional) | Sign in with Google |
| GitHub OAuth app ID + secret (optional) | Sign in with GitHub |
| Resend API key + a domain you own (optional) | Password-reset mail to real inboxes |
| `SECRET_KEY_BASE` (`bin/rails secret`) | Render env |

OAuth callback URLs:

- `http://localhost:3000/users/auth/google_oauth2/callback`
- `https://YOUR-SERVICE.onrender.com/users/auth/google_oauth2/callback`
- same pattern for `/users/auth/github/callback`

Until OAuth keys exist, use email + password or a demo account.

Until a domain is verified with Resend, confirmation/reset mail will not reach other people’s inboxes. Google/GitHub login does not need mail.

## Render

1. New Web Service from this repo, Ruby, build `bin/render-build.sh`, start `bundle exec puma -C config/puma.rb`.
2. Env: `DATABASE_URL`, `SECRET_KEY_BASE`, `APP_HOST` (your onrender host), optional OAuth and `RESEND_API_KEY`.
3. First deploy: set `FORCE_SEEDS=1` once so demo people exist, then unset it.

## Stack

Rails 8.1, Ruby 3.4, PostgreSQL, Hotwire, Tailwind, Devise, Pundit, Action Cable (async on a single process).
