# SocialRails

A chronological town square for builders. Newest first. No ranking. No ads.

Rails 8, Hotwire, PostgreSQL, Devise, Pundit.

## Run locally

Ruby 3.4 and PostgreSQL 16.

```bash
bin/setup
bin/rails server
```

Open [http://localhost:3000](http://localhost:3000).

Demo accounts (password `demo1234`):

- `maya@socialrails.dev`
- `arjun@socialrails.dev`
- `lena@socialrails.dev`

Development mail (password reset) is at [http://localhost:3000/letter_opener](http://localhost:3000/letter_opener).

## Features

- Public chronological feed and a Following view
- Profiles, follows, posts, comments, likes
- Direct messages and a live public Yard (Action Cable)
- Google / GitHub sign-in when OAuth env vars are set

## Deploy

Host on Render (native **Ruby**, not Docker) with Postgres from Neon.

Environment variables:

| Variable | Required |
| --- | --- |
| `DATABASE_URL` | yes |
| `SECRET_KEY_BASE` | yes |
| `RAILS_MASTER_KEY` | yes (from `config/master.key`, not committed) |
| `APP_HOST` | yes (e.g. `your-service.onrender.com`) |
| `FORCE_SEEDS` | first deploy only (`1`) |
| `GOOGLE_CLIENT_ID` / `GOOGLE_CLIENT_SECRET` | optional |
| `GITHUB_CLIENT_ID` / `GITHUB_CLIENT_SECRET` | optional |

OAuth callbacks:

- `https://YOUR-SERVICE.onrender.com/users/auth/google_oauth2/callback`
- `https://YOUR-SERVICE.onrender.com/users/auth/github/callback`
