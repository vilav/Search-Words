require 'sinatra'
require 'csv'
require 'fileutils'
require 'rubygems'
require 'active_support/inflector'
require "#{settings.root}/helpers/application_helper.rb"
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'classes'))
Dir.glob(settings.root + '/classes/*.rb') {|file| require file}

class SearchWordApp < Sinatra::Base
  get "/" do
    erb :index
  end

  get "/file/:access_code/:filename" do
    send_file file_path(settings.root, params[:access_code].gsub(".","")), :filename => params[:filename], :type => 'application/octet-stream'
  end

  post "/" do
    file = SearchDataFile.new(params['file'])
    file.write
    @link = "/file/#{file.access_code}/#{file.name}"
    erb :index
  end
end
