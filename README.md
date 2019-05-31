# Brownfield Of Dreams

Brownfield of Dreams was a paired project between [CSheesley](https://github.com/CSheesley) and [n-flint](https://github.com/n-flint) during Mod 3 at the Turing School of Software & Design. The basic premise of the project was to build functionality on top of an existing code base, where we were exposed to, and learned about the implications of `tech debt`. While working under a deadline, strategic decisions were needed to determine which pieces of functionality should stay, which pieces should be improved upon and tested, and which pieces would ultimately be cut. A link to the original project description and repo can be found here: https://github.com/turingschool-examples/brownfield-of-dreams/projects/1

An example of the additional features which were added on top of the existing code base can be found by looking at the original project board, which can be found here: https://github.com/turingschool-examples/brownfield-of-dreams/projects/1

### Key Functionality Added:

- Successfully set up API calls to gather user data from GitHub.
- Implemented OAuth, where a user can connect to their GitHub account.
- Added functionality for users to add GitHub followers/followees as friends on our app.
- Used Sendgrid to enable email for account activation and invitations.

### Other Links:

Repository Link for cloning: https://github.com/CSheesley/brownfield-of-dreams

Heroku Link for viewing: https://pacific-refuge-67925.herokuapp.com/

## Local Setup

Obtain and define the following API keys in an `config/application.yml` file:
  YouTube - `ENV['YOUTUBE_API_KEY']`
  Github -  `ENV['GITHUB_API_KEY']`

Clone down the repo
```
$ git clone https://github.com/CSheesley/brownfield-of-dreams
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [webmock](https://github.com/webmock/webmock)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.3
