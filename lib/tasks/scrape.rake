desc "Fill the database tables with some sample data"
task({ :scrape => :environment}) do
  require "ferrum"

  #Navigate to oddsjam url 
  url = "https://oddsjam.com/arbitrage"
  browser = Ferrum::Browser.new(browser_options: { 'no-sandbox': nil })
  browser.go_to(url)
 
  # Wait for 3 seconds 
  sleep(3)

  # Select the specific elements and return the text
  #NOTE TO CURRAN: NEED TO FILL OUT THE ELEMENTS HERE 
  arb_event = browser.at_css('tr:nth-child(1) td:nth-child(4) .text-dark-75').text
  p arb_event
  arb_market = browser.at_css('tr:nth-child(1) td:nth-child(6) .text-dark-75').text
  p arb_market
  arb_date = browser.at_css('tr:nth-child(1) .py-8~ .py-8+ td .font-size-md').text
  p arb_date
  arb_odds1 = browser.at_css('tr:nth-child(1) div:nth-child(1) .align-middle').text
  p arb_odds1
  arb_odds2 = browser.at_css('tr:nth-child(1) div+ div .align-middle').text
  p arb_odds2
  arb_return = browser.at_css('tr:nth-child(1) .align-items-center .font-size-md').text
  p arb_return


  #arb_market = browser.at_ccs("tr:nth-child(1) td:nth-child(6) .text-dark-75").text
  #arb_date = browser.at_ccs('tr:nth-child(1) .py-8~ .py-8+ td .font-size-md').text
  #arb_odds1 = browser.at_ccs("tr:nth-child(1) div:nth-child(1) .align-middle").text
  #arb_odds2 = browser.at_ccs("tr:nth-child(1) div+ div .align-middle").text
  #arb_return = browser.at_ccs("tr:nth-child(1) .align-items-center .font-size-md").text
  
  
  #we cannot use the same code to find the sportsbooks, since they are shown as images on the page 
  
  img_selector = "tr:nth-child(1) img"
  #Selects images from first row (note this )
  images = browser.css(img_selector)

  books = Array.new 

  images.each do |img|
  # Print "alt" attribute of each img element
  # This contains the name of sportsbook
  books.push(img.attribute("alt"))
  #Ask Pat - how can I store the "alt" into arb_books1 and arb_books2
  end

  #NOTE TO CURRAN: STILL NEED TO GENERATE BET MODEL 
  bet = Bet.new
  bet.event = arb_event
  bet.market = arb_market
  bet.date = arb_date 
  bet.odds1 = arb_odds1 
  bet.odds2 = arb_odds2
  bet.books1 = books.at(0)
  bet.books2 = books.last
  bet.return = arb_return
  bet.save
  p bet 

end