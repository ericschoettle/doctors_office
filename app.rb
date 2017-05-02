require 'sinatra'
require 'sinatra/reloader'
require './lib/doctor'
require './lib/patient'
require './lib/specialty'
require './lib/helper'
require 'pry'
require 'pg'
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "doctors_office"})

get('/') do
  @specialties = Specialty.all()
  @doctors = Doctor.all()
  @patients = Patient.all()
  erb(:index)
end

post('/specialty') do
  name = params[:name]
  new_specialty = Specialty.new({:name => name})
  new_specialty.save()
  @specialties = Specialty.all()
  @doctors = Doctor.all()
  @patients = Patient.all()
  erb(:index)
end

post('/doctor') do
  name = params[:name]
  specialty_id = params[:specialty].to_i()
  new_doctor = Doctor.new({:name => name, :specialty_id => specialty_id})
  new_doctor.save()
  @specialties = Specialty.all()
  @doctors = Doctor.all()
  @patients = Patient.all()
  erb(:index)
end

post('/patient') do
  name = params[:name]
  doctor_id = params[:doctor].to_i()
  new_patient = Patient.new({:name => name, :doctor_id => doctor_id})
  new_patient.save()
  @specialties = Specialty.all()
  @doctors = Doctor.all()
  @patients = Patient.all()
  erb(:index)
end

get('/specialty/:id') do
  @specialty = Specialty.find(params[:id].to_i())
  erb(:specialty)
end

get('/doctor/:id') do
  @doctor = Doctor.find(params[:id].to_i())
  erb(:doctor)
end

post('/clear') do
  Helper.clear_db()
  @specialties = Specialty.all()
  @doctors = Doctor.all()
  @patients = Patient.all()
  erb(:index)
end
