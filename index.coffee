cson	= require 'cson'
path	= require 'path'
fs		= require 'fs'

exports.load = (configPath) -> 
	unless configPath
		configDir = path.dirname module.parent.filename
		configPath = "#{configDir}/config.cson"
	else
		configDir = path.dirname configPath
		
	try 
		ef = "#{configDir}/.env"
		items = fs.readFileSync(ef).toString().split "\n"
		for item in items
			s = item.split '='
			process.env[s[0]] ?= s[1..]
	catch err
	
	
		
	c = cson.parseFileSync configPath, sandbox: global

	if c.stack?
		console.log "Error in config file #{configPath}"
		console.log c
		process.exit 1

	process.config[key] = val for key, val of c
