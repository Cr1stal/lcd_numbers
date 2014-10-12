#!/usr/bin/env ruby
require 'optparse'
require_relative 'tabloid'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: lcd_numbers.rb [options]"

  options[:size] = 2
  opts.on("-s", "--size SIZE", "Size of line (Default equals 2)") do |size|
    options[:size] = Integer(size)
  end
end.parse!

number = ARGV.pop
tabloid = Tabloid.new
tabloid.add_number(number)
context = {
    line_size: options[:size]
}
result = tabloid.render(context)
puts result
