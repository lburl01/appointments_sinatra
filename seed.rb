require_relative 'environment'
require_relative 'model'
require_relative 'schema'

def main
  lori = Patient.create(
  patient_name: 'Lori'
  )

  ellis = Patient.create(
  patient_name: 'Ellis'
  )

  peter = Patient.create(
  patient_name: 'Peter'
  )

  miles = Physician.create(
  dr_name: 'Dr. Miles'
  )

  kathy = Physician.create(
  dr_name: 'Dr. Kathy'
  )

  october = Appointment.create(
  physician_id: 1,
  patient_id: 1,
  appointment_date: Time.now
  )

end

main if __FILE__ == $PROGRAM_NAME
