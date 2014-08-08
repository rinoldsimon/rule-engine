require 'rubygems'
require 'json'
require 'net/http'

class HardWorker
  include Sidekiq::Worker

  def perform(dev)
  	@dummy = DummyRule.collection.find(devise_id: dev)

  	@dummy.each do |d1|
  	puts d1
  	puts d1.keys
  	puts d1.key("harish")
  	puts d1[:name]
    end

    @rules = Rule.all
    @rules.each do|r|
      if r.datatype == "Fixnum"
        @dummy.each do |d|
          if r.condition == "<"
            if "#{d[:_id]}" < r.usercond
              @a = "True"
              @m = "Mail"
            else
              @a = "False"
              @m = "--"
            end
          elsif r.condition == ">"
            if "#{d[:_id]}" > r.usercond
              @a = "True"
              @m = "Mail"
            else
              @a = "False"
              @m = "--"
            end
          elsif r.condition == "="
            if "#{d[:_id]}" == r.usercond
              @a = "True"
              @m = "Mail"
            else
              @a = "False"
              @m = "--"
            end
          end
        @rule = {
          field: r.field,
          datatype: r.datatype,
          value: "#{d[:_id]}",
          condition: r.condition,
          usercond: r.usercond,
          result: @a,
          action: @m
           } 
        
        end
        #Rule.collection.insert(@rule) 
        
      elsif r.datatype == "String"
        @dummy.each do |d|
          if r.condition == "regex"
            if "#{d[:name]}"=~/#{r.usercond}/
              @a = "True"
              @m = "Mail"
            else
              @a = "False"
              @m = "--"
            end
          end
        @rule = {
          field: r.field,
          datatype: r.datatype,
          value: "#{d[:name]}",
          condition: r.condition,
          usercond: r.usercond,
          result: @a,
          action: @m
           } 
        
        end
        #Rule.collection.insert(@rule) 
      end 
    end

  end

  
end