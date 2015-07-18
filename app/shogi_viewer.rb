# coding:utf-8

require 'sinatra/base'
require 'tilt/haml'
require 'yaml'
require 'logwriter'
require_relative 'lib/kifu'

@lw = Logwriter::Logger.new('./shogi_viewr.log')
class Shogi_viewer < Sinatra::Base
  set :public_folder, File.expand_path(File.join(root, '..', 'public'))

  configure do
    @@current_kifu = Kifu.new('../public/data/kifu.data')
    @@current_kifu.create_yaml('./public/data/kifu.data')
  end

  get '/' do
    @current_kifu = @@current_kifu.boad
    haml :index
  end

  get '/newgame' do
    @@current_kifu = Kifu.new('../public/data/kifu.data')
    @@current_kifu.create_yaml('./public/data/kifu.data')
    redirect '/'
  end

  post '/data_receive/' do
    param = params[:sasite]
#    puts param
    if(param =~ /^(\+|\-)(\d\d)(\d\d)(.+),(T\d+)$/)
      teban = $1
#      before_place = $2.to_i
      before_place = $2.to_i
#      after_place = $3.to_i
      after_place = $3.to_i
      unit = $4

      @@current_kifu.change_boad(teban, before_place, after_place, unit)
      @current_kifu = @@current_kifu.boad
      haml :index
    end
  end
end
