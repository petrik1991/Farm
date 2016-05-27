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

  def add_item_on_stage
    x = params[:x]  
    y = params[:y]
    
    item = StageItem.create(
      :phase => 0,
      :x => x,
      :y => y)

    state = Builder::XmlMarkup.new( :target => out_string = "", :indent => 2 )
    state.Item(
      "id" => item.id, 
      "item_type" => item.item_type, 
      "phase" => item.phase,
      "x" => item.x, 
      "y" => item.y);
    render :xml => out_string;  
  end  

end
