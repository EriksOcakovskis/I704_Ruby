require 'bundler/setup'
Bundler.require
require 'sinatra/base'
require 'haml'
require 'json'
require 'sequel'
require 'bcrypt'

require 'fluffy_paws/version'
require 'fluffy_paws/helpers'
require 'fluffy_paws/models'
require 'fluffy_paws/interactions/login'
require 'fluffy_paws/interactions/register'
require 'fluffy_paws/app'
