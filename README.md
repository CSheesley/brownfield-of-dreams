# Brownfield Of Dreams

Brownfield of Dreams was a paired project between [n-flint](https://github.com/CSheesley) and [n-flint](https://github.com/n-flint) during Mod 3 at the Turing School of Software & Design. The basic premise of the project was to build functionality on top of an existing code base, where we would be exposed to, and learn about the implications of `tech debt`. While working under a deadline, strategic decisions were needed to determine which pieces of functionality should stay, which pieces should be improved upon and tested, and which pieces would ultimately be cut. A link to the original project description and repo can be found here: https://github.com/turingschool-examples/brownfield-of-dreams/projects/1

An example of the additional features which were added on top of the existing code base can be found by looking at the original project board, which can be found here: https://github.com/turingschool-examples/brownfield-of-dreams/projects/1

### Key Functionality Added:

- Successful set up API calls to gather user data from github.
- Implemented OAuth, where a user can connect to their github account.
- Added functionality for users to add github followers/followees as friends on our app.
- Used Sendgrid to enable email for account activation and invitations.

### Other Links:

Repository Link for cloning: https://github.com/CSheesley/brownfield-of-dreams

Heroku Link for viewing: https://pacific-refuge-67925.herokuapp.com/


### Project Board

Students will continue to build on the existing code base using the cards within the following Github Project: https://github.com/turingschool-examples/brownfield-of-dreams/projects/1

**Learning Goals and Labels**

The cards are labeled in a way that correspond to learning goals or to specific areas you might personally want to focus on.

Cards should be completed from top to bottom in the To Do column. Cards labeled `good first issue` are good as filler work and will allow you to practice common Rails skills.

### About the Project

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

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
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.3
