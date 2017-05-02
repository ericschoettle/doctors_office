require 'spec_helper'

describe(Doctor) do
  describe '#name' do
    it('gives the name of the doctor') do
      test_doctor = Doctor.new({:name => "dr death", :specialty_id => 1})
      expect(test_doctor.name()).to eq("dr death")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      test_doctor = Doctor.new({:name => "dr death", :specialty_id => 1})
      test_doctor.save()
      expect(test_doctor.id()).to be_an_instance_of(Fixnum)
      expect(Doctor.all()).to eq([test_doctor])
    end
  end

  describe '#==' do
    it('is true if specialties have same name') do
      doctor1 = Doctor.new({:name => "dr death", :specialty_id => 1})
      doctor2 = Doctor.new({:name => "dr death", :specialty_id => 1})
      expect(doctor1).to eq(doctor2)
    end
  end

  describe '.find' do
    it('returns a speciaty by its ID') do
      doctor1 = Doctor.new({:name => "dr death", :specialty_id => 1})
      doctor1.save()
      doctor2 = Doctor.new({:name => "dr life", :specialty_id => 1})
      doctor2.save()
      expect(Doctor.find(doctor2.id())).to eq(doctor2)
    end
  end

  describe '#patients' do
    it('returns an array of patients for that doctor') do
      test_doctor = Doctor.new({:name => "dr death", :specialty_id => 1})
      test_doctor.save()
      test_patient = Patient.new({:name => "Patient Zero", :doctor_id => test_doctor.id()})
      test_patient.save()
      test_patient1 = Patient.new({:name => "Jane Doe", :doctor_id => test_doctor.id()})
      test_patient1.save()
      expect(test_doctor.patients()).to eq([test_patient, test_patient1])
    end
  end
end
