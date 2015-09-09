# lita-hangout

[![Build Status](https://travis-ci.org/brodock/lita-hangout.svg?branch=master)](https://travis-ci.org/brodock/lita-hangout)
[![Coverage Status](https://coveralls.io/repos/brodock/lita-hangout/badge.svg?branch=master)](https://coveralls.io/r/brodock/lita-hangout?branch=master)
[![Code Climate](https://codeclimate.com/github/brodock/lita-hangout/badges/gpa.svg)](https://codeclimate.com/github/brodock/lita-hangout)
[![Inch CI](http://inch-ci.org/github/brodock/lita-hangout.svg?branch=master)](http://inch-ci.org/github/brodock/lita-hangout)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/github/brodock/lita-hangout/master)

Lita handler plugin to generate Google+ Hangout URLs

## Installation

Add lita-hangout to your Lita instance's Gemfile:

``` ruby
gem "lita-hangout"
```

## Configuration

You must define a Google Apps domain settings to use this plugin:

```ruby
  config.handlers.hangout.domain='exampple.com'
```

## Usage

This plugin will let you create Google+ Hangout URLs.

There are 3 ways to generate them:
* lita hangout - generates a random room name
* lita hangout me - uses your username as room name
* lita hangout me <subject> - uses the informed subject as room name
