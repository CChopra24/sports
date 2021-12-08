#Notes from talking with Pat: go to the site, return the object, print it out 
#Notes from mechanize website: Create a new folder with a Gemfile. In the Gemfile include gem 'mechanize' and run bundle in terminal to create a Gemfile.lock. Then create a new ruby file and add require 'mechanize' at the top of the file.
class BettingController < ApplicationController

require 'mechanize'

def index 

mechanize = Mechanize.new
page = mechanize.get('https://oddsjam.com/arbitrage')
date = page.search('tr:nth-child(1) .py-8~ .py-8+ td .font-size-md').text.strip
event = page.search('tr:nth-child(1) td:nth-child(4) .text-dark-75').text.strip
market = page.search('tr:nth-child(1) td:nth-child(6) .text-dark-75').text.strip
odds1 = page.search('tr:nth-child(1) td:nth-child(6) .text-dark-75').text.strip
books = page.search('tr:nth-child(1) .text-dark-75 div:nth-child(1)').text.strip

render({ :template => "betting/index.html.erb"})

end 

end 
