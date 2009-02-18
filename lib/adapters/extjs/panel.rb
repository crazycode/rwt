module Rwt
  class Panel < Rwt::Component
    def render_create
      @config.merge!(:items=>@components) if @components.length > 0
      Rwt << "var #{self}=new Ext.Panel(#{@config.render});"
      generate_default_events
    end

  end
end