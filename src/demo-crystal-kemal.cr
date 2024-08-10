require "kemal"

# Root endpoint
get "/" do
  "Hello World!"
end

# JSON endpoint
get "/json" do |env|
  env.response.content_type = "application/json"
  "{\"message\": \"Hello, JSON!\"}"
end

# HTML endpoint
get "/html" do |env|
  env.response.content_type = "text/html"
  "<html><body><h1>Hello, HTML!</h1></body></html>"
end

Kemal.run
