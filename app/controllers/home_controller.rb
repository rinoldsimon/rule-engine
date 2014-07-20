
class HomeController < ApplicationController 

  #before_filter :index, :only => [:index1] 
  #before_filter :index1, :only => [:index] 

  require 'httparty'
  require 'open-uri'
  
  require 'time'
  require 'time_diff'
  
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
    "startdate"=> "11-12-2012",
    "enddate"=> "01-1-2014",
    "starttime"=> "12:30:54",
    "endtime"=> "5:30:12"
     }

    #storing json data in database 
    @jsondata1 = {:jsondata => @jsondata} 
    Home.collection.insert(@jsondata1) 

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

  end 

  def index1 
    
  end 

end