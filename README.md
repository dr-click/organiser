# Organisers

Events organisers

## Getting Started

You'll need to do a few things to get up-and-running.  Here are a few items:

* Install all the necessary gems with ```bundle install```
* Update your database with ```rails db:wipe```
* Start your web server with ```rails server:start```

---

### Test

  Using RSpec and some other testing tool to reach the 97% code coverage, to run the test run the following command:
  ```
  rspec
  ```
  Follow this path to check the code coverage results: APP_ROOT/coverage/index.html


### API Documentation

  Using apipie-rails to provide an API documentation, run the server and open the URL "/api/apipie" to check the documentation


---

## Project Details:

* Environment

  > Ruby 2.4.2

  > Rails 5.0.6

  > PostgreSQL


* Project dependencies

  > rspec: testing framework for Rails

  > faker: A library for generating fake data such as names, addresses, and phone numbers

  > factory_girl_rails: fixtures replacement with a straightforward definition syntax

  > simplecov: Code coverage for Ruby

  > carrierwave: Classier solution for file uploads for Rails

  > apipie-rails: Ruby on Rails API documentation tool

  > jwt: A pure ruby implementation of the RFC 7519 OAuth JSON Web Token


---

### Changes todo later

- The factory_girl gem is deprecated, upgrade to factory_bot
- reach 100% test coverage
- Include user sign_up/sign_up in API
- Secure /api/apipie URL and api/generate_secret
- Add events table, and link them with organisers
- User token should expire.
- Each organiser should manage his photographers only
- Create association between attendee and photographs directly (using id instead of access_code)
- implement fingerprinting for the uploaded files
