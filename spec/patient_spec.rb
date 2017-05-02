require 'spec_helper'

describe(Patient) do
  describe '#name' do
    it('gives the name of the patient') do
      test_patient = Patient.new({:name => "eric", :doctor_id => 1})
      expect(test_patient.name()).to eq("eric")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      test_patient = Patient.new({:name => "eric", :doctor_id => 1})
      test_patient.save()
      expect(test_patient.id()).to be_an_instance_of(Fixnum)
      expect(Patient.all()).to eq([test_patient])
    end
  end

  describe '#==' do
    it('is true if patients have same name') do
      patient1 = Patient.new({:name => "eric", :doctor_id => 1})
      patient2 = Patient.new({:name => "eric", :doctor_id => 1})
      expect(patient1).to eq(patient2)
    end
  end
end
