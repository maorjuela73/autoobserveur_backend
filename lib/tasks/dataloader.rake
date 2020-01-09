namespace :dataloader do
  desc "TODO"
  require 'csv'

  task importItems: :environment do
    CSV.foreach('data/input/items.csv', headers: true) do |row|
      Item.create(code: row[0],	function: row[1], dimension: row[2], name: row[3],	description: row[4],	is_active: row[5]=="TRUE")
    end
  end

  task importAdvices: :environment do
    CSV.foreach('data/input/advices_html.csv', headers: true) do |row|
      item = Item.find_by(code: row[1])
      item.advices.create(level: row[3], advice: row[4])
    end
  end

end
