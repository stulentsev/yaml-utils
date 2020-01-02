#! /usr/bin/env ruby

require 'yaml'

filename = if ARGV.length == 1
  ARGV[0]
elsif ARGV.length == 0
  "/home/sergio/projects/textmaster-root/services/TextMaster.com/config/locales/new.yml"
end

unless filename
  puts "Usage: flat_print.rb filename"
  exit(1)
end

hash = YAML.load_file(filename)
hash = hash[hash.keys.first]

def recurse(obj, current_path = [], &block)
  if obj.is_a?(String)
    path = current_path.join('.')
    yield [path, obj]
  elsif obj.is_a?(Hash)
    obj.each do |k, v|
      recurse(v, current_path + [k], &block)
    end
  end
end

recurse(hash) do |path, value|
  puts path
end
