# SocialNetworker

## Preview

![preview](.github/preview.gif)

After cloning, run Bundler to install packages and dependencies:

```
cd social
bundle install
```

### Ruby version
	- ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin17]

### System dependencies
Ruby, rails gem, bundler, sqlite3/mysql, rake, homebrew
	- `brew install rbenv ruby-build mysql`
	- `gem install rails`
	- `bew install mysql`

## Setup

- Clone the repo to your local machine.  
- Install mysql with Homebrew (mac) `brew install mysql`.  
- After installing the database, run the following command to start the mysql server: `mysql.server start`.  
- After cloning the repository, cd into `social` and run `bundle install`.  
- Install packages and dependencies, run `bin/rails server` to start the web server.  
- Stop the database with `mysql.server stop`.  

### Database creation

Database should be created locally with the rails setup. If you need to, run `rake db:migrate` to get the database to the latest version.


### How to run the test suite

	- `bin/rails server` or
	- `rails server`
	- Make sure the database is running, and run `rails test` to run the tests.

### Services (job queues, cache servers, search engines, etc.)

## Deployment instructions

- Coming soon!

## Issues running `rails test` or `rails server`

Sometimes rails will try to run tests off the previous process of spring. Use the command `spring stop` to stop the current process and run `rails server|test` again.

