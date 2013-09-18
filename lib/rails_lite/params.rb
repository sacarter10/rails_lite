require 'uri'

class Params
  def initialize(req, route_params)
    @params = {}
    parse_www_encoded_form(req.body, req.query_string)
  end

  def [](key)
  end

  def to_s
    @params.to_s
  end

  private
  def parse_www_encoded_form(request_body, query_string)
    params_arr = []
    params_arr += URI.decode_www_form(request_body) if request_body
    params_arr += URI.decode_www_form(query_string) if query_string

    params_arr.each do |key, val|
      args_arr = parse_key(key)

      if args_arr.length == 1
        @params[args_arr.first] = val
      else
        @params[args_arr.first] ||= {}
        @params[args_arr.first][args_arr.last] = val
      end

    end


      # body_arr = URI.decode_www_form(request_body) unless request_body.nil?
      # query_arr = URI.decode_www_form(query_string) unless query_string.nil?
      # params_arr = []
      # params_arr += body_arr if body_arr
      # params_arr += query_arr if query_arr
      #
      # p '!!!!!!!!!!!'
      # p params_arr
      #
      # params_arr.each do |attrib, val|
      #
      #   key_arr = parse_key(attrib)
      #   key_val_arr = key_arr << val
      #
      #   until key_val_arr.length == 2
      #     if @params[key_val_arr[-2]]
      #       @params[key_val_arr[-2]] =  key_val_arr.pop
      #     else
      #       key_val_arr[-1] = { key_val_arr[-2] => key_val_arr[-1] }
      #       key_val_arr.delete_at(-2)
      #     end
      #   end
      #
      #   @params[key_val_arr.first] = key_val_arr.last

    # end
  end

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end
