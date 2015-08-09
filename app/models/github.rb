class Github
  include HTTParty
  
  def self.response
    user = @badgeinput.github_name
    api_url = "https://api.github.com/users/#{user}/events/public"
    HTTParty.get(api_url)
  end
  
end


