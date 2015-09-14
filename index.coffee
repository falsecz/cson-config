cson	= require './lib/cson'
path	= require 'path'
fs		= require 'fs'

stack = []
substitutes = []

exports.use = (regexp, callback) ->
	stack.push
		regexp: regexp
		handle: callback


exports.load = (configPath, exportToProcess = true) ->
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

	if stack.length > 0
		mapRecursive c, (val) ->
			for filter in stack
				if filter.regexp.test val
					substitute = filter.handle val
					unless substitute in substitutes
						substitutes.push substitute
					return substitute
			return val

	if c instanceof Error
		console.log "Error in config file #{configPath}"
		console.log c
		process.exit 1

	process.config[key] = val for key, val of c if exportToProcess

	return c


mapRecursive = (obj, callback) ->
	return unless typeof obj is "object"
	for key of obj
		if obj[key] in substitutes
			continue
		if typeof obj[key] is "object"
			mapRecursive obj[key], callback
		else
			val = callback obj[key]
			obj[key] = val if val
