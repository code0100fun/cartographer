require 'net/http'
require 'json'

module Cartographer
  class Command
    def initialize message
      @message = message
    end

    def run
      req = Net::HTTP::Post.new uri
      req.set_form_data form
      req.content_type = 'application/x-www-form-urlencoded; charset=UTF-8'
      req['Cookie'] = cookie
      req['Accept'] = 'application/json'
      req['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.77 Safari/537.36'

      http = Net::HTTP.new uri.hostname, uri.port
      http.use_ssl = true

      res = http.start do |http|
        http.request req
      end

      JSON.parse res.body
    end

    private

    def cookie
      '__utma=1.1167356329.1390534582.1390534582.1390534582.1; __utmz=1.1390534582.1.1.utmcsr=playrustwiki.com|utmccn=(referral)|utmcmd=referral|utmcct=/wiki/List_of_Server_Providers; __gads=ID=4387798d041d295d:T=1390535039:S=ALNI_MYCuZFPjQ7o4aq5r8N2zaxOb3dULw; PHPSESSID=0c8h243et055qm7borhi6kcoi7; ClanForge=ozone1015%40gmail%2Ecom:2014-01-27-21-08-06:2015-01-27-21-08-06:1034565:252198:25:9df5fb9c79e916bd70eea5862a9e22b3; login=userid%3D1034565%26adminuser%3Dozone1015%40gmail.com%26created%3D1390879870%26hash%3D73573a6b193de04c50ae1e08739d4f49; __utma=138412769.689944291.1390535019.1390856892.1390879872.18; __utmc=138412769; __utmz=138412769.1390535019.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)'
    end

    def form
      {
        cftoken: 'ClanForge:1390901472:84774da0ef42cc1879c34cbb7abe7a4e6522bca0f7345e128ee5c33069a6adb8752919876d1f2db8d792a6aea0fda675025f116199593634a6b7d8d5b8d71db6',
        lc_console_text: @message,
        serverid: '258684'
      }
    end

    def data
      URI.encode_www_form form
    end

    def headers
      {
        'Cookie' => cookie,
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Accept' => 'application/json'
      }
    end

    def path
      '/cf/v1/livecontrol/console_send'
    end

    def host
      'clanforge.multiplay.co.uk'
    end

    def uri
      URI "https://#{host}#{path}"
    end
  end
end
