# _Recipe Box_

##### _A tool to store and find recipes, August 27, 2015_

#### By _**Kyle Mellander**_

## Description

_This application was a project to work on many-to-many relationships by creating a recipe box tool.  You are free to use it if you want, but it is not ready for production._

## Setup

* _`$ git clone https://github.com/kylemellander/recipe_box.git` into your computer_
* _`$ bundle` to install program dependencies_
* _`$ postgres` to start a postgres server_
* _Open new terminal tab_
* _`$ db:create` to create a database_
* _`$ db:migrate` to add appropriate table information_
* _open new tab and run `$ ruby app.rb` in the project directory to run sinatra app_
* _go to `localhost:4567` in your browser to open webapp_

## Technologies Used

* _Written in Ruby_
* _Site runs on Sinatra_
* _Error checking with RSpec and Capybara_
* _Database management with postgresql_
* _Object Modeling with ActiveRecord_

### Legal

Copyright (c) 2015 **_Kyle Mellander_**

This software is licensed under the MIT license.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
