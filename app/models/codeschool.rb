class Codeschool
  include HTTParty

  def self.response
    user = @badgeinput.codeschool_name
    api_url = "https://www.codeschool.com/users/#{user}.json"
    HTTParty.get(api_url)
  end
end