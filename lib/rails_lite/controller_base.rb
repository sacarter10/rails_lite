require 'erb'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = Params.new(req, route_params)
    @already_rendered = false
  end

  def session
    @session ||= Session.new(@req)
  end

  def already_rendered?
    @already_rendered
  end

  def redirect_to(url)
    @res.header['location'] = url
    @res.status = 302
    session.store_session(@res)
  end

  def render_content(content, type)
    @res.body = content
    @res.content_type = type
    @already_rendered = true
    session.store_session(@res)
  end

  def render(template_name)
    file_str = File.read("views/#{self.class.to_s.underscore}/#{template_name}.html.erb")
    my_view = ERB.new(file_str).result(binding) #saves @res
    render_content(my_view, 'text/html')
  end

  def invoke_action(name)
  end
end
