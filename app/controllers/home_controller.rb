class HomeController < ApplicationController

  require 'httparty'

  def index

    #parsing json data
    @url = "https://graph.facebook.com/crisrinold"
    @jsondata = JSON.parse HTTParty.get(@url).response.body

    #storing json data in database
    @jsondata1 = {:jsondata => @jsondata}
    Home.collection.insert(@jsondata1)

  
  end
end
