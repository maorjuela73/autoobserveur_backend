# Librería que carga los CSV
require 'csv'


CSV.foreach('C:\Users\maorj\Documents\Miguel Orjuela\Autoobservacion\Apps\autoobserver_backend\data\input\advises.csv', headers: true) do |row|
	puts '---------------------'
	numColumnas = row.length
	for i in 0..numColumnas
		puts 'L'+i+'
	end
end