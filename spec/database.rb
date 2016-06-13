module Database
  def self.clean_all
    PostgreSQL.clean
    MySQL.clean
  end
end

module PostgreSQL
  def self.clean
    tables.each { |t|
      $pg[t].truncate(restart: true)
    }
  end

  def self.tables
    [ ]
  end
end

module MySQL
  def self.clean
    tables.each { |t|
      $mysql[t].truncate
      $mysql.run "ALTER TABLE #{t.to_s} AUTO_INCREMENT = 1"
    }
  end

  def self.tables
    []
  end
end