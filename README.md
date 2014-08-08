# Miclo [![Build Status](https://travis-ci.org/tnantoka/miclo.svg?branch=master)](https://travis-ci.org/tnantoka/miclo) [![Coverage Status](https://coveralls.io/repos/tnantoka/miclo/badge.png?branch=master)](https://coveralls.io/r/tnantoka/miclo?branch=master) [![Code Climate](https://codeclimate.com/github/tnantoka/miclo/badges/gpa.svg)](https://codeclimate.com/github/tnantoka/miclo)

[Miclo.org](http://miclo.org/) is a personal microblogging platform.

![](dashboard)

## Requirement

* Ruby 2.1
* Ruby on Rails 4.1
* GitHub API (Authorization callback path: `/auth/github/callback`)

## Installation

### Checkout

```
$ git clone git@github.com:tnantoka/miclo.git
```

### Development (Mac)

```
$ cd miclo/

$ bin/bundle
$ bin/rake db:setup

# .powrc 
export GITHUB_API_KEY="your-key"
export GITHUB_API_SECRET="your-secret"

$ curl get.pow.cx | sh
$ powder link
$ open http://miclo.dev/
```

### Staging (Vagrant)

```
$ cd miclo/miclo_cookbook

$ bundle exec berks vendor

$ cp ~/.ssh/id_rsa.pub site-cookbooks/miclo_cookbook/files/default/authorized_keys
$ cp ~/.ssh/id_rsa site-cookbooks/miclo_cookbook/files/default/id_rsa

# ~/.ssh/config
Host vagrant.local
  Hostname 127.0.0.1
  User ops
  Port 2222

$ export GITHUB_API_KEY="your-key"
$ export GITHUB_API_SECRET="your-secret"

$ vagrant up

$ cd ../
$ bin/bundle exec cap staging deploy
$ open http://localhost:8080/
```

### Production (exmaple.com)

```
$ cd miclo/miclo_cookbook
$ bundle exec knife solo bootstrap user@example.com
$ bundle exec knife solo cook user@example.com

$ cd ../
$ bin/bundle exec cap production deploy
$ open http://example.com/
```

## Contributing

Please see [CONTRIBUTING.md](https://github.com/tnantoka/miclo/blob/master/CONTRIBUTING.md).

## License

[The MIT License](https://github.com/tnantoka/miclo/blob/master/LICENCE)

## Author

[@tnantoka](https://twitter.com/tnantoka)
