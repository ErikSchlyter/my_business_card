#!/usr/bin/env ruby
require 'cgi'

script_name = 'my_business_card.rb'
correct = open(script_name).read
generated = ''
`./#{script_name}`              # execute script
.scan(/<text.*?>(.*?)<\/text>/) # parse all text elements
.pop(46)                        # pop the elements that will contain the code
.each{|line|                    # unescape the HTML and add newline
  generated << CGI::unescapeHTML(line[0]) << "\n"
};

puts generated == correct
exit (generated == correct) ? 0 : -1
