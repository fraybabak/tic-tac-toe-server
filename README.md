# README

this is a simple tic-toc-toe game server.

# Ruby version

ruby 3.2.2

# Database creation

- Database initialization
  the database is sqlite3, so you don't need to install any database server.

```bash
rails db:migrate
```

- Deployment instructions

```bash
bundle install
rails db:migrate
rails s -p 3001
```

# database schema

there is three tables in the database.

```bash
Player table
| id | name | username | is_bot | created_at | updated_at |
```

```bash
Game table

| id | player_one_id | player_two_id | winner_id | status | game_type | created_at | updated_at |
```

```bash
Move table

| id | game_id | player_id | position | created_at | updated_at |
```

# API

there is a postman collection in the root directory of the project.

```bash
tictoc.postman_collection.json
```

## keep in mind

the game bot is not smart, it just play randomly.
bot is handled in front-end side, so you can play with bot in the front-end side.
bot algorith is poor minmax.
