class Result
  include Mongoid::Document
  field :dev_id, type: Integer
  field :condition, type: String
  field :result, type: String
end
