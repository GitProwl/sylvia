![Sylvia](http://www.montanamendy.com/alligator.png)
# Sylvia 
[![Build Status](https://semaphoreapp.com/api/v1/projects/d4cca506-99be-44d2-b19e-176f36ec8cf1/128505/shields_badge.svg)](https://semaphoreapp.com/boennemann/badges)
[![Build Status](https://semaphoreapp.com/api/v1/projects/d4cca506-99be-44d2-b19e-176f36ec8cf1/128505/badge.svg)](https://semaphoreapp.com/boennemann/badges)

## What is Sylvia?

Sylvia is meant to "grease" your Ruby tests via cleaning up memory leaks by releasing instance variables and defers garbage collection or GC.

## How do I use Sylvia? 

Sylvia is a Ruby gem. In order to get started, you'll need to setup the gem (instructions below). You'll optionally want to setup and configure your Ruby workflows so that you can track/debug the status of identified tests through your triage process, and obviously to see if your tests are running faster. Usage instructiosn are below.

```
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000
```
## Installing

From the command line, update your box 

```
sudo apt-get update
sudo apt-get -y install git libxslt-dev libxml2-dev build-essential bison openssl zlib1g libxslt1.1 libssl-dev libxslt1-dev libxml2 libffi-dev libxslt-dev libpq-dev autoconf libc6-dev libreadline6-dev zlib1g-dev libtool libsqlite3-dev libcurl3 libmagickcore-dev ruby-build libmagickwand-dev imagemagick bundler
```

Once you've updated your box and made sure you have all the dependicies needed, make sure you have Ruby/Rbenv installed, follow each command step by step

```
cd ~
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.0.0-p481
rbenv global 2.0.0-p481
ruby -v
```

Now we are going to install Ruby on Rails, for the sake of time I'm going to put the flag "--no-ri --no-rdoc", from the command line, which skips installing the documentation, for this, I'm installing Rails 5

```
gem install bundler --no-ri --no-rdoc
rbenv rehash
gem install rails -v 5.0.0
```

Now we are going install the last dependicies needed in order to run Sylvia properly 

```
sudo apt-get install redis-server
gem install sidekiq
rbenv rehash
```

Open another terminal or optionally an IDE, then navigate to your 'gemfile', and add the following line to your gemfile, in this instance the version really doesn't matter 

  ```
gem "sylvia"
  ```
  
Once you have added the Sylvia gem, you can run the following 

 ```
git clone https://github.com/Montana/sylvia.git
cd sylvia
bundle install
rake db:create
rake db:schema:load
 ```

That should install all the dependencies, and now Sylvia is installed, and a working gem. 

## Secrets

First you should generate secrets for the Rails Application and Devise

```
rake secret
```

Run this command twice. Put one secret on line 7 of config/initializers/secret_token.rb. Put the other on line 7 of config/initializers/devise.rb Now onto defining methods to the Proxy.

## Defining Methods to Proxy

```ruby
class Sylvia
  module Alligator
    def reverse(input)
      input.reverse
    end
  end
end
```

Your cucumber.rb file should look something like this

```ruby 
config.before(:each) do
  Sylvia.disable
end

config.after(:each) do
  Sylvia.collect
  ```
  
  
## Syncing 

In order to allow Sylvia to automatically run tests and send email notifications, you may want to setup cron jobs using the appropriate rake tasks
```
rake sync_all
 ```
This take will run all the tests and import any new errors or results. It will also generate screenshots of each result, if the integration with Sketchy is configured. 

# Cucumber

Make sure you have these lines in your setup file 

```ruby
require 'sylvia/cucumber'
```
Or if you want, you can optionally do, it's really up to you 

```ruby
Before do
  Sylvia.disable
end

After do
  Sylvia.collect.all
end
```
        

## Using Foreman

You can test using Foreman, or even Travis. Sylvia should start on `localhost:5000` if you're using Foreman, run 

```ruby
foreman start
```

You should see something similar to this

```ruby
14:31:46 web.1  | started with pid 699
```

If you want Foreman to use Sylvia on a different port than 5000, insert '.foreman' file that says 'port: 3000' at the root of your app. Or alternatively, run

```ruby
sylvia_rails --config-file config/sylvia.rb -p 3000
```

## Using Docker

You can also configure Sylvia to run in Docker

```ruby
Sylvia.new :host => '192.168.1.192', :port => 4243
```

## Questions

Please email me at montana@getprowl.com if there's any questions. I encourage in helping/improving/forking/sharing, etc. 
