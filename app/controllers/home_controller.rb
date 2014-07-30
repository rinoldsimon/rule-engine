
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
    
    @jsondata = {
    "id"=> "100001840157358",
    "first_name"=> "Rinold",
    "gender"=> "male",
    "last_name"=> "Simon",
    "link"=> "https://www.facebook.com/crisrinold",
    "locale"=> "en_US",
    "name"=> "Rinold Simon",
    "username"=> "crisrinold",
    "ratings"=> "94.30",
    "start_date"=> "15-1-2012",
    "end_date"=> "25-5-2014",
    "start_time"=> "12:30:54",
    "end_time"=> "5:30:12"
     }

    #storing json data in database 
    if params[:jvalue] == nil 
      @jsondata1 = {:jsondata => @jsondata} 
      Home.collection.insert(@jsondata1) 
    end

    #listing data from mongodb
    @homes = Home.all
    @rules = Rule.all

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

  end 

  def index1 
    
  end 

end