# README

Instruction for creating a Rails application by API mode.

## Versions

- Ruby 2.6.3
- Ruby on Rails 5.2.3
- psql (PostgreSQL) 11.3

## Setup

Create a Rails Application in quite simple way.

- Create a new application:

  ```sh
  $ rails new rails_api --api
  ```

  `--skip-bundle` and `-d postgresql` are optional.

  Run the command below.

  ```sh
  $ bundle install (use --path option if needed. )
  ```


- Generate a model and create a DB.

  User model is generated in this example.

  ```sh
  $ rails g model user name:string email:string
  ```

  Don't forget to run create the DB and migrate it then.

  ```sh
  $ rails db:create db:migrate
  ```

  Update Seed:

  `db/seed.rb`

  ```ruby
  User.create([
    {name: "Zaku", email: "test_email1@test.com"},
    {name: "Gouf", email: "test_email2@test.com"},
    {name: "Dom", email: "test_email3@test.com"},
    {name: "Acguy", email: "test_email4@test.com"},
    {name: "Z'gok", email: "test_email5@test.com"}
  ])
  ```

  Insert the seed data:

  ```sh
  $ rails db:seed
  ```

- Create a controller

  ```sh
  $ rails g controller users
  ```

  `users_controller.rb`

  ```ruby
  class UsersController < ApplicationController
    before_action :set_user, only: %i(update destroy)
  
    def index
      @users = User.all
      render json: @users
    end
  
    def create
      @user = User.create(user: params[:user])
      render json: @user
    end
  
    def update
      @user.update_attributes(user: params[:user])
      render json: @user
    end
  
    def dsetroy
      if @user.destroy
        head :no_content, status: :ok
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_user
      User.find(params[:id])
    end
  end
  ```

- Routing

  ```ruby
  Rails.application.routes.draw do
    resources :users
  end
  ```



- CORS settings

  Add the below to `config/application.rb`

  ```ruby
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3000'
      resource '*',
      :headers => :any,
      :methods => %i(get post patch delete options)
    end
  end
   ```

The application is ready.



## Check json response

Start the application:

```sh
$ rails s -p 3001
```

Access to the GET endpoint

```sh
$ curl -G http://localhost:3001/products/

[{"id":1,"name":"Zaku","email":"test_email1@test.com","created_at":"2019-07-19T11:10:08.713Z","updated_at":"2019-07-19T11:10:08.713Z"},{"id":2,"name":"Gouf","email":"test_email2@test.com","created_at":"2019-07-19T11:10:08.716Z","updated_at":"2019-07-19T11:10:08.716Z"},{"id":3,"name":"Dom","email":"test_email3@test.com","created_at":"2019-07-19T11:10:08.718Z","updated_at":"2019-07-19T11:10:08.718Z"},{"id":4,"name":"Acguy","email":"test_email4@test.com","created_at":"2019-07-19T11:10:08.720Z","updated_at":"2019-07-19T11:10:08.720Z"},{"id":5,"name":"Z'gok","email":"test_email5@test.com","created_at":"2019-07-19T11:10:0

```

json data return.

<br />

