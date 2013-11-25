Promise = require \fantasy-promises
{Readable} = require \stream
require \fantasy-streams
{serve, listen} = require \./

main = listen 8000 serve ->
	Promise.of {status-code: 200 body: Readable.of "hello"}

main.unsafe-perform!