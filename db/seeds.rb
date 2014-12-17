# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"
Encoding.default_external = 'UTF-8'

names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤","鈴木","高橋","田中"]
gnames = ["太郎","次郎","花子"]

0.upto(9) do |idx| 
	Member.create(
		number: idx + 10,
		name:names[idx],
		full_name: "#{fnames[idx %4]} #{gnames[idx % 3]}",
		email:"#{names[idx]}@fujitsu.com",
		birthday:"1981-12-1",
		gender:[0,0,1][idx % 3],
		administrator:(idx == 0) 
	)
end

table = CSV.table('db/kiji20140812.csv')

table.map{ |c| 
	Content.create(
		midashi: c[:midashi],
		honbun: c[:honbun],
		category: c[:category],
		link: c[:link]
		)
	
}
