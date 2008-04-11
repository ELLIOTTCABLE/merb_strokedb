class SDBTest < Merb::Controller

  def _template_location(action, type = nil, controller = controller_name)
    controller == "layout" ? "layout.#{action}.#{type}" : "#{action}.#{type}"
  end

  def index
    apple = Fruit.new
    "#{CGI::escapeHTML(apple.inspect)}" # Will be sent to the browser
  end
  
  def test
    @apple = Fruit.new
  end
  
end

Fruit = StrokeDB::Meta.new