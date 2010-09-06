# Roles for Data Mapper

A Data Mapper implementation of [roles generic](http://github.com/kristianmandrup/roles_generic)

## Update!

Now implements the [roles generic](http://github.com/kristianmandrup/roles_generic) Roles API
It also implements the following Role strategies:

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

## Rails generator

_Note_:

*The Rails generator is a bit "rusty" and hasn't been tested with the latest changes. I hope to update it soon.*

The library comes with a Rails 3 generator that lets you populate a user model with a given role strategy 
The following role strategies are included by default. Add your own by adding extra files inside the strategy folder, one file for each role strategy is recommended.

* admin_flag
* inline_role
* inline_roles
* role_relations
* role_mask

Example:

<code>$ rails g data_mapper:roles User --strategy admin_flag</code>

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
