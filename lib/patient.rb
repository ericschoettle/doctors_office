class Patient
  attr_accessor(:name, :doctor_id)
  attr_reader(:id)

  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def self.all
    all_patients = DB.exec('SELECT * FROM patients ORDER BY name;')
    saved_patients = []
    all_patients.each() do |patient|
      name = patient['name']
      doctor_id = patient['doctor_id']
      id = patient['id'].to_i()
      each_patient = Patient.new({:name => name, :doctor_id => doctor_id, :id => id})
      saved_patients.push(each_patient)
    end
    return saved_patients
  end

  def save
    result = DB.exec("INSERT INTO patients (name, doctor_id) VALUES ('#{@name}', '#{@doctor_id}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def ==(another_patient)
    return self.name() == another_patient.name()
  end

  def self.find(id)
    found_patient = nil
    Patient.all().each() do |patient|
      if patient.id() == id
        found_patient = patient
      end
    end
    return found_patient
  end
end
