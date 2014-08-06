require 'rubygems'
require 'json'
require 'net/http'

class HardWorker
  include Sidekiq::Worker

  def perform(dev)
  	@dummy = DummyRule.collection.find(devise_id: dev)

  	@dummy.each do |d1|
  	puts d1
    end

  end
  
end