# Roles for Data Mapper

A Data Mapper implementation of [roles generic](http://github.com/kristianmandrup/roles_generic)

The following role strategies from Roles Generic are currently supported

* admin_flag
* many_roles
* one_role
* roles_mask
* role_string

See [roles_active_record](http://github.com/kristianmandrup/roles_active_record) and [roles generic](http://github.com/kristianmandrup/roles_generic) for more info on using the API.

## Install

<code>gem install roles_data_mapper</code>

To install from cloned repo:

This gem is based on Jeweler, so simply:

<code>rake install</code>

## Roles Generator

The library comes with a Rails 3 generator that lets you populate a user model with a given role strategy 
The following role strategies are included by default. Add your own by adding extra files inside the strategy folder, one file for each role strategy is recommended.

* admin_flag
* many_roles
* one_role
* roles_mask
* role_string

## Usage examples

Apply :admin_flag Role strategy to User model using default roles :admin and :guest (default)

<code>$ rails g data_mapper:roles User --strategy admin_flag</code>

Apply :admin_flag Role strategy to User model using default roles and extra role :author

<code>$ rails g data_mapper:roles_migration User --strategy admin_flag --roles author</code>

Apply :one_role Role strategy to User model without default roles, only with roles :user, :special and :editor

<code>$ rails g data_mapper:roles_migration User --strategy one_role --roles user special editor --no-default-roles</code>

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
