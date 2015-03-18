source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

# ----------- Added on user Authentication course ----------
gem 'bcrypt'
# ----------------------------------------------------------

# ----------- Added on Layouts and CSS Frameworks course ----------
gem 'foundation-rails', '~> 5.2.2'
# ----------------------------------------------------------
gem 'font-awesome-rails', '~> 4.1.0.0'


gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc


#-------------

# GROUP, FOR DEVELOPMENT

group :development do
	gem 'spring'    # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem "quiet_assets", "~> 1.0.2"
end


# GROUPS, FOR DEVELOPMENT AND TEST

group :development, :test do
	gem 'sqlite3'
	gem 'rspec-rails', '~> 2.0'
	gem 'factory_girl_rails', '~>4.0'
end


#GROUP FOR TEST ONLY

group :test do 
	gem 'capybara', '~> 2.1.0'
	gem 'capybara-email', '~> 2.2.0'
	gem 'shoulda-matchers'
end


#GROUP FOR PRODUCTION !!

group :production do
	gem 'pg', '~> 0.18.0'
end

# To be able to bundle install the pg gem, I had to download from http://postgresapp.com
# the Postgres.app and added it to the applications folder
# Then ran:
# =>  gem install pg -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/9.4/bin/pg_config 

<<<<<<< HEAD
  ################# CHANGE IN CONFIG/ENVIRONMENTS/PRODUCTION.RB ####################
  # config.serve_static_assets = true
  #######################################################################
=======
# For iMac I had to use:
# $ sudo su
# $ env ARCHFLAGS="-arch x86_64" em install pg -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/9.4/bin/pg_config

>>>>>>> 04b0418d14c9cab790db96fc1a6a548df140117b
#-------------



# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

