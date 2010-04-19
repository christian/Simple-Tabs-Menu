require 'navigation'

module SimpleTabsMenuHelper
  def self.included(base)  
    base.send :include, ClassMethods 
  end 
  
  module ClassMethods
    include Navigation

    def simple_menu(options, &block)
      if block_given?
        m = Menu.new(options)
        # aliasing outside the class
        Menu.class_eval{ alias :menu_item :add_item }
        block.call(m)
        return m.draw(request.path)
      end
    end
  end
end

ActionView::Base.send :include, SimpleTabsMenuHelper
