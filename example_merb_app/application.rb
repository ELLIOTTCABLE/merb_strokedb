Fruit = StrokeDB::Meta.new

class SdbTest < Merb::Controller

  def _template_location(action, type = nil, controller = controller_name)
    controller == "layout" ? "layout.#{action}.#{type}" : "#{action}.#{type}"
  end

  def index
    @apple = Fruit.new
    @apple.color = :red
    @apple.save!
    "#{CGI::escapeHTML(@apple.color.inspect)}"
  end
  
  def test
    @orange = Fruit.new
    @orange.color = :orange
    @orange.save!
  end
  
  def list
    @fruitcake = Fruit.find
    "#{CGI::escapeHTML(@fruitcake.inspect)}"
  end
  
end