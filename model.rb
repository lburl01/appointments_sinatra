require 'active_record'
require_relative 'schema'
require_relative 'environment'

class Physician < ActiveRecord::Base
  has_many :appointments
  has_many :patients, through: :appointments # physician has many patients via the appointments joined table
end

class Appointment < ActiveRecord::Base
  belongs_to :physician
  belongs_to :patient
end

class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :physicians, through: :appointments
end
