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
    type = params[:item_type]
    
    item = StageItem.create(
      :item_type => type,
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

  def inc_item_phase
    item = StageItem.find(params[:id])

    if item.nil? 
      render :nothing => true
    else
      type = ItemType.find(item.item_type)
      if type.phase_count > item.phase
        item.phase = item.phase + 1
      end
      item.save
      render :nothing => true
    end        
  end

  def get_game_state
      state = Builder::XmlMarkup.new( :target => out_string = "", :indent => 2 )
      state.Stage{
        StageItem.all.each { |item|
          state.Item(
            "id" => item[:id], 
            "item_type" => item[:item_type], 
            "phase" => item[:phase],
            "x" => item[:x], 
            "y" => item[:y]);
        }
      }
      render :xml => out_string;  
  end

  def collect_item
    StageItem.destroy(params[:id])  
    render :nothing => true     
  end

end
