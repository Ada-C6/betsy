# Notes about Testing with 'factory_girl_rails'

# factory_girl_rails
Documentation: https://github.com/thoughtbot/factory_girl_rails

+ factory_girl is a fixtures replacement with a straightforward definition syntax
+ support for multiple build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects)
+ support for multiple factories for the same class (user, admin_user, and so on), including factory inheritance.

Note_to_self: Currently using: Rails 4.2.6

##REASONS TO USE 'factory_girl':
1. https://www.hiringthing.com/2012/08/17/rails-testing-factory-girl.html
+ Good explanation of why its helpful: "The first (and possibly best) reason to use Factory Girl is because it solves the single worst problem of fixtures: maintenance. Tests become much easier to maintain when you can request a model instance that is always current."
+ Thorough examples!

2.
https://thoughtbot.com/upcase/videos/factory-girl
better than fixtures.
+ "How Factory Girl helps avoid mystery guests: Let's look at a specific example. Fixtures often lead to Mystery Guests, an anti-pattern where we are performing some assertions in our tests but it's not at all obvious at a glance what the data we're asserting against.
3. http://culttt.com/2016/02/17/replacing-fixtures-with-factory-girl-in-ruby-on-rails/
+ Gives great examples and discusses why "replacing fixtures with factories is helpful."
+ "Firstly, instead of defining each Fixture, you define a Factory that can be used to create models of that type. The Factory is basically just a blueprint for creating instances of that model object. Now whenever you need an instance of the model, or you need to pre-populate the database with data for a given scenario, you can use the Factory. is means that only the data required for the test will be in the database and it’s immediately clear where that data came from.
"


### HOW TO USE 'factory_girl':
1.
https://robots.thoughtbot.com/aint-no-calla-back-girl
+ Article goes over how to write and understand has_many associations.
+ Ex Factory:
```
factory :article do
  body 'password'

  factory :article_with_comment do
    after(:create) do |article|
      create(:comment, article: article)
    end
  end
end

factory :comment do
  body 'Great article!'
end
```
+ Nice. Callbacks let us do this:
```
article = create(:article_with_comment)
```
+ Article also covers: Polymorphic relationships

2. http://samuelmullen.com/categories/ruby-on-rails/
Extremely comprehensive guide on how to use/test: Validating Presence of Associations and Foreign Keys in Rails. Among other things. It's crazy long and thorough.

3. https://github.com/thoughtbot/factory_girl/wiki/How-factory_girl-interacts-with-ActiveRecord
+ Great example syntax



## Notes on Minitest, found most examples of using 'factory_girl_rails' used Rspec. Found these helpful for using Minitest syntax.

1. http://danwin.com/2013/03/ruby-minitest-cheat-sheet/
2. https://ariejan.net/2015/04/07/testing-with-minitest/
