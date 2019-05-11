Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], {:provider_ignores_state => true}
# added information about state

  # provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
  #     {
  #       :client_options => {
  #         :site => 'https://github.YOURDOMAIN.com/api/v3',
  #         :authorize_url => 'https://github.YOURDOMAIN.com/login/oauth/authorize',
  #         :token_url => 'https://github.YOURDOMAIN.com/login/oauth/access_token',
  #       }
  #     }
  #
end
