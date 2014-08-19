require 'rubygems'
require 'json'
require 'net/http'

class HardWorker
  include Sidekiq::Worker

  def perform(dev)
  	@dummy = DummyRule.collection.find(devise_id: dev)

    @rules = Rule.all
    @rules.each do|r|
      if r.datatype == "Fixnum"
        @dummy.each do |d|
          if r.condition == "<"
            if d[:_id] < r.usercond.to_i
              @a = "True"
              @m = "Mail"
            else 
              @a = "False"
              @m = "--"
            end
          elsif r.condition == ">"
            if d[:_id] > r.usercond.to_i
              @a = "True"
              @m = "Mail"
            else
              @a = "False"
              @m = "--"
            end
          elsif r.condition == "="
            if d[:_id] == r.usercond.to_i
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
        @result = {
          dev_id: d[:devise_id],
          condition: r.condition,
          result: @a
           }
          @ruleid = Rule.collection.find(value: "#{d[:_id]}", condition: r.condition, usercond: r.usercond).count()
          if @ruleid == 0
            Rule.collection.insert(@rule)
            Result.collection.insert(@result)
          end
        end
        
      elsif r.datatype == "String"
        @dummy.each do |d|
          if r.condition == "regex"
            if d[:name]=~/#{r.usercond}/
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
        @result = {
          dev_id: d[:devise_id],
          condition: r.condition,
          result: @a
           }
        @ruleid = Rule.collection.find(value: "#{d[:name]}", condition: r.condition, usercond: r.usercond).count()
          if @ruleid == 0
            Rule.collection.insert(@rule)
            Result.collection.insert(@result)
          end
        end
      end 
    end

  end

  
end