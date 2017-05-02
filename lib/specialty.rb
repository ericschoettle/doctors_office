require 'pry'

class Specialty
  attr_accessor(:name)
  attr_reader(:id)

  def initialize(attributes)
    # attributes.each do |key, value|
    #   instance_variable_set("@#{key}", value) unless value.nil?
    # end
    instance_variable_set("@name", attributes[:name])
    instance_variable_set("@id", attributes[:id]) unless attributes[:id].nil?
  end

  def self.all
    all_specialties = DB.exec('SELECT * FROM specialties;')
    saved_specialties = []
    all_specialties.each() do |specialty|
      name = specialty['name']
      id = specialty['id'].to_i()
      each_specialty = Specialty.new({:name => name, :id => id})
      saved_specialties.push(each_specialty)
    end
    return saved_specialties
  end

  def save
    result = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first()['id'].to_i()
  end

  def ==(another_specialty)
    return self.name() == another_specialty.name()
  end

  def self.find(id)
    found_specialty = nil
    Specialty.all().each() do |specialty|
      if specialty.id() == id
        found_specialty = specialty
      end
    end
    return found_specialty
  end

  def doctors
    list_doctors = []
    doctors = DB.exec('SELECT * FROM doctors WHERE specialty_id = #{self.id};')
    doctors.each() do |doctor|
      name = doctor['name']
      specialty_id = doctor['specialty_id'].to_i()
      list_doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id}))
    end
    return list_doctors
  end
end
