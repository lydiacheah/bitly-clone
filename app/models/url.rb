class Url < ActiveRecord::Base
  validates :long_url, format: {with: /http.?:\/\/\S+/, message: "Please enter a valid URL."}, presence: true 
  before_create :shorten
  
  def shorten
		self.short_url = rand(36**rand(5..8)).to_s(36)		
  end
end

