require 'json'
require 'webrick'

class Session
  def initialize(req)
    @cookie_val = {}
    req.cookies.each do |cookie|
      if cookie.name == "_rails_lite_app"
        @cookie_val = JSON.parse(cookie.value)
      end
    end
  end

  def [](key)
    @cookie_val[key]
  end

  def []=(key, val)
    @cookie_val[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new("_rails_lite_app", @cookie_val.to_json)
  end
end
