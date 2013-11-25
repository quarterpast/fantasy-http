IO = require \fantasy-io
http = require \http

# type Response = { body :: Readable Buffer
#                 , status-code :: Int
#                 , status :: String
#                 , headers :: Map String String }

# wrap-handler :: (Request → Promise Response) → Request → NodeRes → ()
export wrap-handler = (handler, req, res)-->
	handler req
	.map write-head res
	.map (.chain (.body `pipe` res))
	.fork (.unsafe-perform!)

# pipe :: Readable → Writable → IO Readable
export pipe = (src,dst)-->
	new IO -> src.pipe dst

# write-head :: NodeRes → Response → IO Response
export write-head = (res, response)-->
	new IO ->
		res.write-head do
			response.status-code ? 200
			response.status ? \OK
			response.headers ? {}

		return response

# listen :: Integer → Server → IO ()
export listen = (port, server)-->
	new IO -> server.listen port

# serve :: (Request → Promise Response) → Server
export serve = http.create-server . wrap-handler