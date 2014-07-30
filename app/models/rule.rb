class Rule
  include Mongoid::Document
  field :field, type: String
  field :datatype, type: String
  field :value, type: String
  field :condition, type: String
  field :usercond, type: String
  field :result, type: String
  field :action, type: String
end
