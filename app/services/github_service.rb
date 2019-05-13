class GithubService
  def initialize(user)
    @user = user
  end

  def get_repos
    get_json('/user/repos')
  end

  def get_followers
    get_json('/user/followers')
  end

  def get_followed
    get_json('/user/following')
  end

  private

  def get_json(url)
    response = conn.get(url)
    data = JSON.parse(response.body, symbolize_name: true)
  end

  def conn
    Faraday.new('https://api.github.com/users/reps') do |f|
      f.headers['Authorization'] = "TOKEN #{@user.git_key}"
      f.adapter Faraday.default_adapter
    end
  end
end
