util = require 'util'
require('../').load()

util.log util.inspect process.config

c2 = require('../').load './config2.cson', false
util.log util.inspect c2
util.log util.inspect process.config