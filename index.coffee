cson	= require 'cson'
path	= require 'path'

exports.load = (configPath) -> 
	unless configPath
		configPath = path.dirname module.parent.filename
		configPath += '/config.cson'
		
	c = cson.parseFileSync configPath, sandbox: global

	if c.stack?
		console.log "Error in config file #{configPath}"
		console.log c
		process.exit 1

	process.config[key] = val for key, val of c
