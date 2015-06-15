# coding:utf-8

require 'sinatra/base'
require 'haml'

class Shogi_viewer < Sinatra::Base
  set :public_folder, File.expand_path(File.join(root, '..', 'public'))
  get '/' do
    haml :index
  end
end
