
class HomeController < ApplicationController 

  before_filter :index, :only => [:index1] 
  before_filter :index1, :only => [:index] 

  require 'httparty'
  require 'open-uri'
  
  require 'time'
  require 'time_diff'
  require 'date'
  
  def index 

    #parsing json data 
    #@url = "https://graph.facebook.com/crisrinold" 
    #@jsondata = JSON.parse HTTParty.get(@url).response.body 
    
    #sample jsondata for testing
    @jsondata = {
    "id"=> "100001840157358",
    "name"=> "Rinold Simon",
    "ratings"=> "94.30",
    "start_date"=> "15-1-2012",
    "start_time"=> "12:30:54"
     }

    #listing data from mongodb
    @homes = Home.all
    @rules = Rule.all
    @dummyrules = DummyRule.all

    #identifying data types
    @jvalue = params[:jvalue] 

    if @jvalue != nil 
      @jvalue1 = @jvalue.split("  ").map do |entry| 
        if entry.to_i == 0 && entry != "0" # this is a string 
          entry 
        elsif entry = ( Text(entry) rescue Integer(entry) rescue Float(entry) rescue Date.parse(entry) rescue Time.parse(entry) rescue nil) 
        entry.nil? ? entry : entry 
        end end 
    end 

    @cond = params[:conditions] 

    @usrcond = params[:usercondition]

    #sidekiq
    @dummyrules.each do |d|
      HardWorker.perform_async(d.devise_id)
    end

  end 

  def index1 
    
  end 

end