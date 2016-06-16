#! /usr/bin/env ruby

require 'yaml'
require 'colorize'

filename, pattern_text = if ARGV.length == 2
  ARGV
elsif ARGV.length == 1
  [
    "/Users/sergio/projects/textmaster/textmaster-root/services/TextMaster.com/config/locales/xx-XX.yml",
    ARGV[0],
  ]
else
  []
end

unless filename && pattern_text
  puts "Usage: grep_yaml.rb filename pattern"
  exit(1)
end

pattern = Regexp.new(pattern_text, :nocase)
# p pattern

hash = YAML.load_file(filename)

def recurse(obj, pattern, current_path = [], &block)
  if obj.is_a?(String)
    path = current_path.join('.')
    if obj =~ pattern || path =~ pattern
      yield [path, obj]
    end
  elsif obj.is_a?(Hash)
    obj.each do |k, v|
      recurse(v, pattern, current_path + [k], &block)
    end
  end
end

recurse(hash, pattern) do |path, value|
  line = "#{path}:\t#{value}"
  line = line.gsub(pattern) {|match| match.green }
  puts line
end
