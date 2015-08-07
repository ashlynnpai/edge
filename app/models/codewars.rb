class Codewars
  include HTTParty

  def self.response
    user = @badgeinput.codewars_name
    api_url = "https://www.codewars.com/api/v1/users/#{user}"
    HTTParty.get(api_url)
  end
  
  def self.language_parse(stats, language)
    total = 0
    stats["data"].each do |item|
      item["completedLanguages"].each do |name| 
        if name == language
          total+=1
        end
      end
    end    
    return total      
  end
  
  def self.latest(stats, num)
    kata = []
    latest_ten = stats["data"].take(10)
    latest_ten.each do |item|
      kata.push(item["name"])
    end
    return kata
  end
end