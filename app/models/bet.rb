# == Schema Information
#
# Table name: bets
#
#  id         :integer          not null, primary key
#  books1     :string
#  books2     :string
#  date       :string
#  event      :string
#  market     :string
#  odds1      :integer
#  odds2      :integer
#  return     :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Bet < ApplicationRecord
end
