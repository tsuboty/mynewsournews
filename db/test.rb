require "csv"
Encoding.default_external = 'UTF-8'

table = CSV.table('kiji20140812.csv')

p table.headers
table.map{ |c| 
	print c[:no]
	print c[:midashi]
	print c[:honbun]
	p c[:category]
}