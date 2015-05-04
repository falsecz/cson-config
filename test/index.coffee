assert = require 'assert'
util = require 'util'
require('../').load()
assert process.config.mongo is 'mmmm', "mongo isnt mmmm"

localConfig = require('../').load './test/config2.cson', no
assert localConfig.url is 'mmmm', "local url isnt mmmm"
assert process.config.url is undefined, "global url isnt undefined"