cson	= require './lib/cson'
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
			# split by first '='
			s = item.match /^([A-Z0-9_-]+)=(.+)/
			continue unless s

			# find and replace environment variables
			env = s[2].match(/\$[A-Z0-9_-]+/g) || []
			for key in env
				if value = process.env[key.slice(1)]
					s[2] = s[2].replace key, value

			process.env[s[1]] ?= s[2]
	catch err



	c = cson.parseFileSync configPath, sandbox: global

	if c.stack?
		console.log "Error in config file #{configPath}"
		console.log c
		process.exit 1

	process.config[key] = val for key, val of c
