require 'sinatra'
require_relative 'environment'
require_relative 'schema'
require_relative 'model'
require_relative 'seed'
require 'json'
require 'pry'

get '/:name?' do
  name = params[:name] || 'world'
  "Hello, #{name}!"
end


get '/api/all/appointments' do
  Appointment.all.to_json
end

get '/api/physicians/:id' do
  physician = Physician.find_by_id(params['id'])
  if physician.nil?
    halt(404)
  end
  physician.to_json
  status 200
end

get '/api/patients/:id' do
  patient = Patient.find_by_id(params['id'])
  if patient.nil?
    halt(404)
  end
  patient.to_json
  status 200
end

get '/api/appointments/get/:patient_id' do
  appointment = Appointment.includes(params['patient_id'])
  if appointment.nil?
    halt(404)
  end
  appointment.to_json
  status 200
end

get '/api/appointments/:physician_id' do
  Physician.find(Appointment.where(physician_id: params['physician_id']).first.physician_id).to_json
end

get '/api/appointments/all_drs/:physician_id' do
  appts = Appointment.select(:dr_name, :physician_id, :patient_id, :appointment_date).joins("FULL OUTER JOIN physicians ON appointments.physician_id = physicians.id").where(physician_id: params['physician_id']).all.to_json
end

get '/api/appointments/all_pats/:patient_id' do
  appts = Appointment.select(:dr_name, :physician_id, :patient_id, :patient_name, :appointment_date).joins("FULL OUTER JOIN patients ON appointments.patient_id = patients.id").where(patient_id: params['patient_id']).joins("FULL OUTER JOIN physicians ON appointments.physician_id = physicians.id").all.to_json
end

post '/api/appointments' do
  Appointment.create(physician_id: params['physician_id'], patient_id: params['patient_id'], appointment_date: Time.now).to_json
  status 201
end

post '/api/physicians' do
  Physician.create(dr_name: params['dr_name']).to_json
  status 201
end

put '/api/physicians/update/:id' do
  phys = Physician.find_by(id: params[:id])
  phys.update(
		dr_name: 	params['dr_name']
		).to_json
    if phys.nil?
      halt(404)
    end
end

# WANT TO DELETE ONLY WHEN PHYSICIAN ID AND PATIENT ID ARE A MATCH
delete '/api/appointments/destroy/:physician_id&:patient_id' do
  appt = Appointment.where(physician_id: params['physician_id'], patient_id: params['patient_id'])
  if appt.nil?
    halt(404)
  end
  appt.delete_all
  status 200
end
