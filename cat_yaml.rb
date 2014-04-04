#! /usr/bin/env ruby

require 'yaml'

filename = ARGV[0]

hash = YAML.load_file(filename)

def recurse(obj, current_path = [], &block)
  if obj.is_a?(String)
    yield [current_path.join('.'), obj]
  elsif obj.is_a?(Hash)
    obj.each do |k, v|
      recurse(v, current_path + [k], &block)
    end
  end
end

recurse(hash) do |path, value|
  puts "#{path}:\t#{value}"
end
