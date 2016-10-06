require_relative 'environment'

class CreateAppointments < ActiveRecord::Migration[5.0]
  def up
    create_table :physicians do |t|
      t.string :dr_name
    end

    create_table :patients do |t|
      t.string :patient_name
    end

    create_join_table :physicians, :patients, table_name: :appointments do |t|
      t.belongs_to :physician, index: true # could get rid of t.references and add foreign_key: true here for each line
      t.belongs_to :patient, index: true
      t.references :physician, index: true, foreign_key: true
      t.references :patient, index: true, foreign_key: true
      t.datetime :appointment_date
    end

  end

  def drop
    drop_table :physicians
    drop_table :patients
    drop_table :physicians, :patients
  end
end

def main
  action = (ARGV[0] || :up).to_sym

  CreateAppointments.migrate(action)

end

main if __FILE__ == $PROGRAM_NAME
