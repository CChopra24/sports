desc "Fill the database tables with some sample data"
task({ :scrape => :environment}) do
  require "ferrum"

  #Navigate to oddsjam url 
  url = "https://oddsjam.com/arbitrage"
  browser = Ferrum::Browser.new(process_timeout: 5)
  browser.go_to(url)
 
  # Wait for 3 seconds 
  sleep(3)

  # Select the specific elements and return the text
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

  
  #we cannot use the same code to find the sportsbooks, since they are shown as images on the page 
  
  img_selector = "tr:nth-child(1) img"
  #Selects images from first row 
  images = browser.css(img_selector)

  books = Array.new 

  images.each do |img|
  # This contains the name of sportsbook
  books.push(img.attribute("alt"))
  
  end

  
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

  User.all.each do |user|
    user.account_balance = user.account_balance * (1 + (bet.return * 0.01)) 
    user.save
  end 
end