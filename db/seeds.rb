# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
miguel = User.create(first_name: "Miguel", last_name: "Orjuela", email: "ma.orjuela73@gmail.com", birth_date: "1990-11-23", :password => "12345678", :password_confirmation => "12345678")
dorita = User.create(first_name: "Dora", last_name: "Suarez", email: "dmsuarezv@gmail.com", birth_date: "1992-09-02", :password => "12345678", :password_confirmation => "12345678")

# miguel.periods.create(is_active: false, is_updated: false, duration: 20, start_date: (Date.today-21).to_s, end_date: (Date.today-1).to_s)
miguel.periods.create(is_active: true, is_updated: false, duration: 10, start_date: Date.today.to_s, end_date: (Date.today+10).to_s)
dorita.periods.create(is_active: true, is_updated: false, duration: 10, start_date: Date.today.to_s, end_date: (Date.today+10).to_s)

miguel.periods.active.first.period_items.create(item: Item.find(1))
miguel.periods.active.first.period_items.create(item: Item.find(2))
miguel.periods.active.first.period_items.create(item: Item.find(3))
miguel.periods.active.first.period_items.create(item: Item.find(5))
miguel.periods.active.first.period_items.create(item: Item.find(6))
miguel.periods.active.first.period_items.create(item: Item.find(7))
miguel.periods.active.first.period_items.create(item: Item.find(9))
miguel.periods.active.first.period_items.create(item: Item.find(16))
miguel.periods.active.first.period_items.create(item: Item.find(17))
miguel.periods.active.first.period_items.create(item: Item.find(21))
miguel.periods.active.first.period_items.create(item: Item.find(22))

dorita.periods.active.first.period_items.create(item: Item.find(1))
dorita.periods.active.first.period_items.create(item: Item.find(2))
dorita.periods.active.first.period_items.create(item: Item.find(3))
dorita.periods.active.first.period_items.create(item: Item.find(5))
dorita.periods.active.first.period_items.create(item: Item.find(6))
dorita.periods.active.first.period_items.create(item: Item.find(7))
dorita.periods.active.first.period_items.create(item: Item.find(9))
dorita.periods.active.first.period_items.create(item: Item.find(16))
dorita.periods.active.first.period_items.create(item: Item.find(17))
dorita.periods.active.first.period_items.create(item: Item.find(21))
dorita.periods.active.first.period_items.create(item: Item.find(22))
