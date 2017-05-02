DB = PG.connect({:dbname => "doctors_office"})

class Helper
  def self.clear_db
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM specialties *;")
  end
end
