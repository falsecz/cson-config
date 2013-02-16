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
