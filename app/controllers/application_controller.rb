class ApplicationController < ActionController::Base
  require 'csv'
  protect_from_forgery with: :exception
end
