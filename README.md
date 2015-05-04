[![Build Status](https://travis-ci.org/falsecz/cson-config.svg?branch=master)](https://travis-ci.org/falsecz/cson-config)
[![Dependency Status](https://david-dm.org/falsecz/cson-config.svg)](https://david-dm.org/falsecz/cson-config)

Installation
-----
`npm install cson-config`

Usage
-----

`require('cson-config').load()` 
or
`require('cson-config').load('/path/to/config.cson')`


all variables are exported to process.config

if `.env` is present content will be auto loaded to proces.env before loading config
`
NAME=server1
PORT=5566
`



see test/

Draft
-----
    csonConfig = require 'cson-config'
    mongoq = require 'mongoq'

    csonConfig.use /^mongodb:/, (url) ->
        return mongoq url
    csonConfig.load()

All values in configuration matching `/^mongodb:/` will be replaced by instance of mongoq
