module Breeze
  module Content
    class PageView < Breeze::Content::View
      def page
        content
      end
      
      def render_as_html
        controller.instance_variable_set "@variables_for_render", variables_for_render
        # TODO: catch the missing template error if the template isn't available.
        # We should at least be able to render :layout => "page" with the built-in views.
        controller.send :render, :inline => content.to_erb(self), :locals => variables_for_render, :layout => template
      end
      
      def editor_html
        <<-HTML
          <script type="text/javascript">
            // Breeze content editing

            // Ensure presence of jQuery & jQuery UI
            if (typeof(jQuery) == 'undefined') { document.write('<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></s' + 'cript>'); }
            if (typeof(jQuery) == 'undefined' || typeof(jQuery.ui) == 'undefined') { document.write('<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js"></s' + 'cript>'); }

            // Insert content editor javascripts
            document.write('<script type="text/javascript" src="#{ActionController::Base.helpers.asset_path 'breeze/front.js'}"></s' + 'cript>');

            // TODO: I'm not sure what the purpose of the following is - Isaac
            document.write('<script type="text/javascript" defer="defer">$(function() {');
            document.write('$("body").breeze({ page_id:"#{content.id}", view:"#{self.name}", views:#{(content.views.empty? ? %w(default) : content.views.map(&:name)).inspect}, template:"#{content.template}", templates:#{Breeze::Theming::Theme.available_templates.inspect} });');
            #{"document.write('$(\"#breeze-template-chooser\").val(\"#{content.template}\")');" if content.template?}
            document.write('});</s' + 'cript>');
          </script>
        HTML
      end
    end
  end
end



      #def editor_html
        #<<-HTML
          #<script type="text/javascript">
            #// Breeze content editing
            #if (typeof(jQuery) == 'undefined') { document.write('<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></s' + 'cript>'); }
            #if (typeof(jQuery) == 'undefined' || typeof(jQuery.ui) == 'undefined') { document.write('<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js"></s' + 'cript>'); }

            #document.write('<script type="text/javascript" src="/assets/breeze/front.js"></s' + 'cript>');
            #document.write('<script type="text/javascript" src="/breeze/javascripts/rails.js"></s' + 'cript>');
            #document.write('<script type="text/javascript" src="/breeze/javascripts/marquess/marquess.js"></s' + 'cript>');
            #document.write('<script type="text/javascript" src="/breeze/editor/editor.js"></s' + 'cript>');
            #document.write('<script type="text/javascript" src="/breeze/javascripts/assets.js"></s' + 'cript>');
            #document.write('<script type="text/javascript" src="/breeze/javascripts/jcrop/js/jquery.Jcrop.min.js"></s' + 'cript>');
            #document.write('<script type="text/javascript" src="/breeze/javascripts/uploadify/swfobject.js"></s' + 'cript>');
            #document.write('<script type="text/javascript" src="/breeze/javascripts/uploadify/uploadify.js"></s' + 'cript>');
            #document.write('<script type="text/javascript" defer="defer">$(function() {');
            #document.write('$("body").breeze({ page_id:"#{content.id}", view:"#{self.name}", views:#{(content.views.empty? ? %w(default) : content.views.map(&:name)).inspect}, template:"#{content.template}", templates:#{Breeze::Theming::Theme.available_templates.inspect} });');
            ##{"document.write('$(\"#breeze-template-chooser\").val(\"#{content.template}\")');" if content.template?}
            #document.write('});</s' + 'cript>');
          #</script>
        #HTML
      #end
