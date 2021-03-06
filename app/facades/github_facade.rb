class GithubFacade
  def initialize(current_user)
    @user = current_user
    @key = @user.git_key
  end

  def repos(limit = 5)
    limited = newest_repos.take(limit)
    limited.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def followers(limit = 5)
    rand_limited = github_followers.sample(limit)
    rand_limited.map do |follower_data|
      Githubber.new(follower_data)
    end
  end

  def followed(limit = 5)
    rand_limited = github_followed.sample(limit)
    rand_limited.map do |followed_data|
      Githubber.new(followed_data)
    end
  end

  private

  def github_followers
    @_github_followers = service.get_followers
  end

  def github_followed
    @_github_followed = service.get_followed
  end

  def newest_repos
    sorted = repo_data.sort_by { |repo| repo['updated_at'] }
    sorted.reverse!
  end

  def repo_data
    @_repo_data = service.get_repos
  end

  def service
    @_service ||= GithubService.new(@user)
  end
end
