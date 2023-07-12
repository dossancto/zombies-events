# zombies-events
An API to make Zombies events more fun.

## Setup

- Clone the repo

```sh
$ git clone https://github.com/lu-css/zombies-events
```

- cd project

```sh
$ cd zombies-events
```

- Install dependencies

```sh
$ bundle install
```

- Start databases in docker compose

```sh
$ docker compose up -d
```

- Create postgres database

```sh
$ bundle exec rake db:create
```

- Run migrations

```sh
$ bundle exec rake db:migrate
```

- Create the `.env` file. Get your Twitch `<CLIENT-ID>` and `<CLIENT_SECRET>`. Check `.env.example` for details.

- The database uses the docker-compose configuration, you do not need to config it on .env file.

## Run

- Start server
```sh
$ bundle exec thin start
```

- The server is running on localhost:3000

## Usage

- `/aethereggs/players/online` -> List all players online on the event. Returns a list of livestreams. The file is cached, the time to live is 3 minutes.

- `/aethereggs/players/vods` -> List all vods stored at database. The cache time is 10 minutes. 
