http = require("http")
http_proxy = require("http-proxy")

port = process.env.PORT or 3001
dropbox_id = process.env.DROPBOX_ID

throw "Needs a dropbox id" unless dropbox_id

http_proxy.createServer((req, res, proxy) ->
  console.log "Proxing #{req.url}"
  req.url = "/u/#{dropbox_id}#{req.url}"
  if /^[^.]+[\/]?$/.test req.url #Add change a directory path into a path to index.html inside of that directory. 
    req.url = req.url.concat "/" if not /\/$/.test req.url
    req.url = req.url.concat "index.html"
  proxy.proxyRequest req, res,
    host: "dl.dropbox.com"
    port: 80
).listen port

console.log "Proxing requests on port #{port} to dropbox"