class GameController < ApplicationController
  require "builder"
  
  def all_item_types
    type = Builder::XmlMarkup.new( :target => out_string = "", :indent => 2 )
    type.Itemtype{
      ItemType.all.each { |curType|
        type.Type(
          "id" => curType[:id], 
          "phase_count" => curType[:phase_count], 
          "name" => curType[:name]); 
      }
    }
    render :xml => out_string;  
  end
end
