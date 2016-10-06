require 'sinatra'
require_relative 'model'
require 'json'
require_relative 'schema'
require 'pry'

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

get '/api/appointments/all/:physician_id' do
  appts = Appointment.select(:dr_name, :physician_id, :patient_id, :appointment_date).joins("FULL OUTER JOIN physicians ON appointments.physician_id = physicians.id").where(physician_id: params['physician_id']).all.to_json
  # return dr_name where physician_id in appointments is the params['physician_id']
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
  p = Physician.find_by(id: params[:id])
  p.update(
		dr_name: 	'Dr. Lori'
		).to_json
end

# delete '/api/tasks/:id' do
#   t = Task.find_by(id: params[:id])
#   if t.nil?
#     halt(404)
#   end
#   t.destroy
# end
