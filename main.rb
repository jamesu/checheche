require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'
include Magick

get '/' do
  haml :index
end

get '/style.css' do
  send_file 'style.css'
end

get '/CHE.jpg' do
  send_file 'CHE.jpg'
end

post '/cheify' do
  if params[:data].nil? or params[:data][:tempfile].nil?
    redirect '/'
  end

  image_data = params[:data][:tempfile].read
  images = Image.from_blob(image_data)
  if images.nil? or images.empty?
    redirect '/'
  else
    image = images[0]
    image.format = 'PNG'
    content_type 'image/png'
    image.threshold(MaxRGB * 0.5).to_blob
  end
end
