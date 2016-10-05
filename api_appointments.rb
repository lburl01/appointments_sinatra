require 'sinatra'
require_relative 'model'
require 'json'

get '/api/appointments' do
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

post '/api/appointments' do
  Appointment.create(physician_id: params['physician_id'], patient_id: params['patient_id'], appointment_date: Time.now).to_json
  status 201
end
#
# put '/api/tasks/:id' do
#   t = Task.find_by(id: params[:id])
#   if t.nil?
#     halt(404)
#   end
# 	t.update(
# 		description: 	params['description'],
#     priority: params['priority'],
#     completed: params['completed']
# 		).to_json
# end
#
# delete '/api/tasks/:id' do
#   t = Task.find_by(id: params[:id])
#   if t.nil?
#     halt(404)
#   end
#   t.destroy
# end
