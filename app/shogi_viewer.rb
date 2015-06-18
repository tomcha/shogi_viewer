# coding:utf-8

require 'sinatra/base'
require 'tilt/haml'
require 'yaml'

class Shogi_viewer < Sinatra::Base
  set :public_folder, File.expand_path(File.join(root, '..', 'public'))

  configure do
    File.open('./public/data/kifu.data') do |file|
      @@data = YAML.load(file)
    end
  end

  get '/' do
    p @@data
    @data = @@data
    haml :index
  end

  post '/data_receive/' do
    teban = params[:teban]
    before_place = params[:before].to_i
    after_place = params[:after].to_i
    koma = params[:koma]
    p before_place
    p after_place
#    if(@@data[after_place] != '*')
#      @@data[teaban + '00'] = @@data[after_place]
#    end
    @@data[after_place] = teban + koma
    @@data[before_place] = '*'
#    puts @@data
#    haml :index
  end
end
