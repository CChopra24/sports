class BettingController < ApplicationController
  
  require "ferrum"

  def index
    @bets = Bet.all
    render({ :template => "betting/index.html.erb"})
  end 

  #SHOULD EVERYTHING BELOW GO IN THE RAKE FILE? 

  def create

  #Navigate to oddsjam url 
  url = "https://oddsjam.com/arbitrage"
  browser = Ferrum::Browser.new
  browser.go_to(url)
 
  # Wait for 3 seconds 
  sleep(3)

  # Select the specific elements and return the text
  #NOTE TO CURRAN: NEED TO FILL OUT THE ELEMENTS HERE 
  arb_event = browser.at_css("tr:nth-child(1) td:nth-child(4) .text-dark-75").text
  arb_market = browser.at_ccs("tr:nth-child(1) td:nth-child(6) .text-dark-75").text
  arb_date = browser.at_ccs("tr:nth-child(1) .py-8~ .py-8+ td .font-size-md").text
  arb_odds1 = browser.at_ccs("tr:nth-child(1) div:nth-child(1) .align-middle").text
  arb_odds2 = browser.at_ccs("tr:nth-child(1) div+ div .align-middle").text
  arb_return = browser.at_ccs("tr:nth-child(1) .align-items-center .font-size-md").text
  
  #we cannot use the same code to find the sportsbooks, since they are shown as images on the page 
  
  img_selector = "tr:nth-child(1) img"
  #Selects images from first row (note this )
  images = browser.css(img_selector)

  images.each do |img|
  # Print "alt" attribute of each img element
  # This contains the name of sportsbook
  p img.attribute("alt")
  #Ask Pat - how can I store the "alt" into arb_books1 and arb_books2
  end

  #NOTE TO CURRAN: STILL NEED TO GENERATE BET MODEL 
  bet = Bet.new
  bet.event = arb_event
  bet.market = arb_market
  bet.date = arb_date 
  bet.odds1 = arb_odds1 
  bet.odds2 = arb_odds2
  bet.books1 = arb_books1
  bet.books2 = arb_books2
  bet.return = arb_return
  bet.save

  end 

end 


#OLD CODE using mechanize - ignore

#mechanize = Mechanize.new
#page = mechanize.get('https://oddsjam.com/arbitrage')
#date = page.search('tr:nth-child(1) .py-8~ .py-8+ td .font-size-md').text.strip
#event = page.search('tr:nth-child(1) td:nth-child(4) .text-dark-75').text.strip
#market = page.search('tr:nth-child(1) td:nth-child(6) .text-dark-75').text.strip
#odds1 = page.search('tr:nth-child(1) td:nth-child(6) .text-dark-75').text.strip
#books = page.search('tr:nth-child(1) .text-dark-75 div:nth-child(1)').text.strip



