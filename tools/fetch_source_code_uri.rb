#!/usr/bin/env ruby

require 'open-uri'
require 'json'

# today_top_50 = URI.parse('https://rubygems.org/api/v1/downloads/top.json').read
top_50 = URI.parse('https://rubygems.org/api/v1/downloads/all.json').read
top_50 = JSON.parse(top_50)

gems = top_50['gems']

gems.each do |gem|
  full_name = gem.first['full_name']
  name = full_name.sub /-(\d+\.){1,}\d+\Z/, '' # strip the version

  gem_info = URI.parse("https://rubygems.org/api/v1/gems/#{name}.json").read
  gem_info = JSON.parse(gem_info)

  source_code_uri = gem_info["source_code_uri"]

  puts JSON.dump({name: name, source_code_uri: source_code_uri}) unless source_code_uri.nil?
end

