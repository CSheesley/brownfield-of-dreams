class Githubber
  attr_reader :name, :url, :git_id

  def initialize(githubber_data)
    @name = githubber_data['login']
    @url = githubber_data['html_url']
    @git_id = githubber_data['id']
  end

  def add_friend?
    User.find_by(git_id: self.git_id)

  end


  
end
