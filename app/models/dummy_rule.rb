class DummyRule
  include Mongoid::Document
  field :id, type: Integer
  field :name, type: String
  field :ratings, type: Float
  field :start_date, type: Date
  field :start_time, type: Time
  field :devise_id, type: Integer
end