http = require("http")
http_proxy = require("http-proxy")

port = process.env.PORT || 3001
host = "40foo.com:3030"
dropbox_id = "24793108"

http_proxy.createServer((req, res, proxy) ->
  req.url = "/u/#{dropbox_id}#{req.url}"
  proxy.proxyRequest req, res,
    host: "dl.dropbox.com"
    port: 80
).listen port

console.log "Proxing requests on port #{port} to dropbox"