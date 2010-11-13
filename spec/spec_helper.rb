$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'i18n_emails'

ENV['BUNDLE_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)

require 'rubygems'
require "bundler"
Bundler.setup

require 'rspec'
require 'rspec/autorun'
