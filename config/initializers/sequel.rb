## Load MySQL
$mysql = Sequel.connect(ENV["MYSQL_URI"])
$mysql.loggers << Logger.new($stdout) if ENV['RACK_ENV'] == "development"

## Load Postgres
$pg = Sequel.connect(ENV["PG_URI"])
$pg.extension :pg_json
$pg.loggers << Logger.new($stdout) if ENV['RACK_ENV'] == "development"