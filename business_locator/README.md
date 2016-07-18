#Business Location File Uploader

##Configure development database

__If mysql needs to be installed locally:__

```bash
brew install mysql
```

__Test it out on the command line:__

```bash
mysql
```

__In your `database.yml` file configure as followed:__

```yaml
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password:
  socket: /tmp/mysql.sock

development:
  <<: *default
  database: business_locator_development

test:
  <<: *default
  database: business_locator_test

production:
  <<: *default
  database: business_locator_production
  username: business_locator
  password: <%= ENV['BUSINESS_LOCATOR_DATABASE_PASSWORD'] %>
 ```

__Test it out on the command line:__

##Set up gems and dependancies

```bash
bundle install
```

##Create and migrate Database

 ```bash
 rake db:create db:migrate
 ```

 ##Run rails dev server
 ```
 rails s
 ```

