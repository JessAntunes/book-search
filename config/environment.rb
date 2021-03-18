
require 'pry'
require 'json'
require 'uri'
require 'net/http'
require 'colorize'
require 'summary'
require 'linesetter'
require 'dotenv'

Dotenv.load

require_relative '../lib/book.rb'
require_relative '../lib/cli.rb'
