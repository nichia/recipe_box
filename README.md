# sinatra-recipe-box

Welcome to the Recipe Box. This is a sinatra web application for sharing recipes. To use the application, please sign up to create an account, login, share recipes and logout. A registered user can:
- view all recipes,
- attach private notes to other user's recipes,
- add new recipes from scratch, or
- add new recipe by adapting from an existing recipe in the system.

## Installation

In a bash terminal, clone the application repository from github then run the application.
git clone git@github.com:nichia/sinatra-recipe-box.git
cd sinatra-recipe-box
run bundle install
run rake db:migrate
run shotgun

## Usage

Open up another terminal and visit http://localhost:9393 to use the application
Sign up and login to share recipes.

## Requirements of Flatiron School Sinatra Portfolio Project

Build an MVC Sinatra Application.
Use ActiveRecord with Sinatra.
Use Multiple Models.
Use at least one has_many relationship on a User model and one belongs_to relationship on another model
Must have user accounts. The user that created a given piece of content should be the only person who can modify that content
Must have the abilty to create, read, update and destroy any instance of the resource that belongs to a user.
Ensure that any instance of the resource that belongs to a user can be edited or deleted only by that user.
You should also have validations for user input to ensure that bad data isn't added to the database. The fields in your signup form should be required and the user attribute that is used to login a user should be a unique value in the DB before creating the user.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nichia/sinatra-recipe-box.


## License

The application is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
