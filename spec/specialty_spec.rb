require 'spec_helper'

describe(Specialty) do
  describe '#name' do
    it('gives the name of the specialty') do
      test_specialty = Specialty.new({:name => "urologist"})
      expect(test_specialty.name()).to eq("urologist")
    end
  end

  describe '#id and #save' do
    it('saves and gives ID') do
      test_specialty = Specialty.new({:name => "urologist"})
      test_specialty.save()
      expect(test_specialty.id()).to be_an_instance_of(Fixnum)
      expect(Specialty.all()).to eq([test_specialty])
    end
  end

  describe '#==' do
    it('is true if specialties have same name') do
      specialty1 = Specialty.new({:name => "urologist"})
      specialty2 = Specialty.new({:name => "urologist"})
      expect(specialty1).to eq(specialty2)
    end
  end

  describe '.find' do
    it('returns a speciaty by its ID') do
      specialty1 = Specialty.new({:name => "urologist"})
      specialty1.save()
      specialty2 = Specialty.new({:name => "dog doctor"})
      specialty2.save()
      expect(Specialty.find(specialty2.id())).to eq(specialty2)
    end
  end

  describe '#doctors' do
    it('returns an array of doctors for that specialty') do
      test_specialty = Specialty.new({:name => "urologist"})
      test_specialty.save()
      test_doctor = Doctor.new({:name => "Dr Bob", :specialty_id => test_specialty.id()})
      test_doctor1 = Doctor.new({:name => "Dr Jesus", :specialty_id => test_specialty.id()})
      expect(test_specialty.doctors()).to eq([test_doctor, test_doctor1])
    end
  end

end
