module Navigation
  class Menu
    attr_accessor :menu_items
    
    def initialize(options = {})
      @ul_class = options[:ul_class] || "tabs"
      @li_selected_class = options[:li_selected_class] || "selected"
      @menu_items = []
    end
    
    def add_item(menu_item)
      if menu_item.is_a?(Hash) then menu_item = MenuItem.new(menu_item) end
      @menu_items << menu_item unless @menu_items.include?(menu_item)
    end
    
    def remove_item(name)
      @menu_items.each do |menu_item|
        if menu_item.name == name
          @menu_items.remove(menu_item)
        end
      end
    end
    
    # url = the url for which we dras the menu (without the host)
    # e.g. for http://www.examples.com/cms/page_1, the url would be /cms/page_1
    def draw(url) 
      s = "<ul class='#{@ul_class}'>"
      @menu_items.each do |menu_item|
        s += "<li><a href='#{menu_item.url}' "
        if menu_item.url == url
          s += "class='#{@li_selected_class}'"
        elsif url =~ /^#{menu_item.url}.*/ && menu_item.url != @menu_items[0].url
          s += "class='#{@li_selected_class}'"
        end
        
        # handle highlights_on
        if menu_item.highlights_on != nil
          menu_item.highlights_on.each do |ho|
            if url =~ /^#{ho}.*/
              s += "class='#{@li_selected_class}'"
            end
          end
        end
        
        s += ">#{menu_item.name}</a></li>"
      end
      s += "</ul>"
    end
    
  end
  
  class MenuItem
    attr_accessor :url
    attr_accessor :name
    attr_accessor :highlights_on
    
    def initialize(options = {})
      @url           = options[:url]
      @name          = options[:name]
      @highlights_on = options[:highlights_on]
    end
  end
end