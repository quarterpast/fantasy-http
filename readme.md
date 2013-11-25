fantasy-http
============

(Mostly) purely functional wrapper around Node's http module.

```
npm install fantasy-http
```

[![fantasy land compatible](https://github.com/fantasyland/fantasy-land/blob/master/logo.png)](https://github.com/fantasyland/fantasy-land)

Usage
-----

```livescript
Promise = require \fantasy-promises
{Readable} = require \stream
require \fantasy-streams
{serve, listen} = require \fantasy-http

main = listen 8000 serve ->
	Promise.of {status-code: 200 body: Readable.of "hello"}

main.unsafe-perform!
```

```bash
$ curl localhost:8000
hello
```

API
---
### Response
```haskell
type Response = { body :: Readable Buffer
                , status-code :: Int
                , status :: String
                , headers :: Map String String }
```
The objects you'll be mostly playing with. ``Readable`` is anything with a ``.pipe Writable`` method; a Node steam will do. Note there's no distiction between a successful and failing response.

### ```serve :: (Request → Promise Response) → Server```
Takes a request handler (a function that turns requests into fantasy-promises for Responses) and creates a Node HTTP server with an appropriate ``(Request, Response) → ()`` handler.

### ```listen :: Integer → Server → IO ()```
Creates an IO action to tell the server to listen on the port. Run it with ``.unsafePerform()``.

Licence
-------
[MIT](/licence.md). &copy; 2013 Matt Brennan.