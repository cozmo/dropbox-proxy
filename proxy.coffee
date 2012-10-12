http = require("http")
http_proxy = require("http-proxy")

port = process.env.PORT || 3001
dropbox_id = "24793108"

http_proxy.createServer((req, res, proxy) ->
  console.log "Proxing #{req.url}"
  req.url = "/u/#{dropbox_id}#{req.url}"
  if /^[^.]+[\/]?$/.test req.url
    req.url = req.url.concat "/" if not /\/$/.test req.url
    req.url = req.url.concat "index.html"
  proxy.proxyRequest req, res,
    host: "dl.dropbox.com"
    port: 80
).listen port

console.log "Proxing requests on port #{port} to dropbox"