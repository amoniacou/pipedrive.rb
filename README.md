# Pipedrive

[![Build Status](https://travis-ci.org/amoniacou/pipedrive.rb.svg?branch=master)](https://travis-ci.org/amoniacou/pipedrive.rb)
[![Code Climate](https://codeclimate.com/github/dotpromo/pipedrive.rb.png)](https://codeclimate.com/github/dotpromo/pipedrive.rb)

Pipedrive.com API wrapper

## Installation

Add this line to your application's Gemfile:

    gem 'pipedrive.rb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pipedrive.rb

## Usage

### Person

You need initialize Person client:

```ruby
client = ::Pipedrive::Person.new('api_token')
```

You can get person's JSON data:

```ruby
person = client.find_by_id(12345)
person.success? # check what request was successful
person.data # JSON data of person entity
```

You can update person:

```ruby
res = client.update(12345, name: 'New Name', 'custom_field_key' => 'value')
res.success? # check what request was successful
res.data # updated JSON data of person
```

Or you can update person with only hash what include id:

```ruby
res = client.update(id: 12345, name: 'New Name', 'custom_field_key' => 'value')
```

You can get the list of all persons:

```ruby
all_persons = client.all # all persons - can be a time consume operation
all_persons = client.all(start: 200) # Skipping first 200 persons
```

Or you can get first page of persons:

```ruby
first_page = client.chunk(start: 200, limit: 10) # get 10 records after skipping 200
```

Or you can iterate by all persons:

```ruby
client.each(start: 200) do |json_item|
  # some logic
end
```

Or you can work with enumerate:

```ruby
client.each(start: 100).select {|x| x['company_id'] == 12345}
```

### Rails integration

If you need use only one pipedrive account for whole application, then you can create `config/initializer/pipedrive.rb` file with next content:

```ruby
Pipedrive.setup do |n|
  n.api_token = ENV['PIPEDRIVE_API_TOKEN']
end
```

And you can skip providing `api_token` to the entities classes.

## Contributing

1. Fork it ( https://github.com/simonoff/pipedrive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
