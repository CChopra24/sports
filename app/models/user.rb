# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  account_balance :integer
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  validates :account_balance, :presence => true 
  has_secure_password
end
