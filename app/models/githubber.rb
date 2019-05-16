class Githubber
  attr_reader :name, :url, :git_id

  def initialize(githubber_data)
    @name = githubber_data['login']
    @url = githubber_data['html_url']
    @git_id = githubber_data['id']
  end

  def a_user?
    User.find_by(git_id: git_id)
  end

  def not_friend?(current_user)
    friend = User.find_by(git_id: git_id)
    !current_user.friends.include?(friend)
  end
end
