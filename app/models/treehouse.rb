class Treehouse
  include HTTParty
  
  def self.response
    user = @badgeinput.treehouse_name
    api_url = "http://teamtreehouse.com/#{user}.json"

    Rails.cache.fetch(api_url, :expires => 3.days) do
    my_response = HTTParty.get(api_url)
      if my_response.success?
      my_response.body
      end
  end
  
  def self.parse_response
    JSON.parse(self.response)
  end
  
end