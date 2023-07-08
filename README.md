# zombies-events
An API to make Zombies events more fun.

## Setup

- Clone the repo

- Install dependencies
```sh
bundle install
```

- Create the `.env` file. Get your Twitch `<CLIENT-ID>` and `<CLIENT_SECRET>`. See `.env.example` for details.

## Run

- start server
```sh
ruby src/server.rb
```

- The server is running on localhost:4567

## Usage

- `aethereggs/players/online` -> List all players online on the event. Returns a list of livestreams. The file is cached, the time to live is 10 minutes.
