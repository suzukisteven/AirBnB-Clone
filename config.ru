# This file is used by Rack-based servers to start the application.
require 'carrierwave/orm/activerecord'
require_relative 'config/environment'

run Rails.application
