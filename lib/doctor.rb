class Doctor
  attr_accessor(:name, :specialty_id)
  attr_reader(:id)

  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value) unless value.nil?
    end
  end

  def self.all
    all_doctors = DB.exec('SELECT * FROM doctors;')
    saved_doctors = []
    all_doctors.each() do |doctor|
      binding.pry
      name = doctor['name']
      specialty_id = doctor['specialty_id']
      id = doctor['id'].to_i()
      each_doctor = Doctor.new({:name => name, :specialty_id => specialty_id})
      saved_doctors.push(each_doctor)
    end
    return saved_doctors
  end

  def save
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', '#{@specialty_id}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def ==(another_doctor)
    return self.name() == another_doctor.name()
  end

  def self.find(id)
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id() == id
        found_doctor = doctor
      end
    end
    return found_doctor
  end

  def patients
    list_patients = []
    patients = DB.exec('SELECT * FROM patients WHERE doctor_id = #{self.id};')
    patients.each() do |patient|
      name = patient['name']
      doctor_id = patient['doctor_id'].to_i()
      list_patients.push(Doctor.new({:name => name, :doctor_id => doctor_id}))
    end
    return list_patients
  end
end
