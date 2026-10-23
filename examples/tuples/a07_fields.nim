type Config = tuple[host: string, port: int]

let config: Config = (host: "localhost", port: 8080)

for value in fields(config):
  echo value
