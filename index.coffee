cson	= require 'cson'
path	= require 'path'

exports.load = (configPath) -> 
	unless configPath
		configPath = path.dirname module.parent.filename
		configPath += '/config.cson'
	c = cson.parseFileSync configPath 
	process.config[key] = val for key, val of c
