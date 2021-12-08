# == Schema Information
#
# Table name: bets
#
#  id         :integer          not null, primary key
#  sport      :string
#  date       :datetime         not null
#  event      :string        
#  odds_1     :integer
#  odds_2     :integer
#
class Bet < ApplicationRecord  
end
