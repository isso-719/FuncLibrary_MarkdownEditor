require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'

# .envを定義
require 'dotenv'

# Cloudinaryの必要事項を定義
before do
  Dotenv.load
  Cloudinary.config do |config|
    config.cloud_name = ENV['CLOUD_NAME']
    config.api_key = ENV['CLOUDINARY_API_KEY']
    config.api_secret = ENV['CLOUDINARY_API_SECRET']
  end
end

# mdフォームと作ったmdを表示する
get '/' do
  @contents = Contents.all
  erb :index
end

# mdをデータベースに登録
post '/create' do
  Contents.create(
    body: params[:body]
  )
  redirect '/'
end

post '/image' do
  # 画像アップロード
  img_url = ''
  if params[:file]
    img = params[:file]
    tempfile = img[:tempfile]
    upload = Cloudinary::Uploader.upload(tempfile.path)
    img_url = upload['url']
  end
  
  # 画像のURLを返す
  data = {img: img_url}
  data.to_json
end