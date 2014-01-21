#! /usr/bin/env ruby

require 'yaml'

filename = '/Users/sergio/projects/textmaster/textmaster.com/config/locales/en-EU.yml'
pattern = ARGV[0] || 'summary'

hash = YAML.load_file(filename)

def recurse(obj, pattern, current_path = [], &block)
  if obj.is_a?(String)
    if obj =~ /#{pattern}/i
      yield [current_path.join('.'), obj]
    end
  elsif obj.is_a?(Hash)
    obj.each do |k, v|
      recurse(v, pattern, current_path + [k], &block)
    end
  end
end

recurse(hash, pattern) do |path, value|
  puts "#{path}: #{value}"
end
