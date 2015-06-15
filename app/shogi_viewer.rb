# coding:utf-8

require 'sinatra/base'
require 'haml'
require 'yaml'

class Shogi_viewer < Sinatra::Base
  set :public_folder, File.expand_path(File.join(root, '..', 'public'))
  get '/' do
    File.open('./public/data/kifu.data') do |file|
      @data = YAML.load(file)
    end
    p @data
    haml :index
  end
end
