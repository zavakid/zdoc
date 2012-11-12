module Jekyll
  class HlBlock < Liquid::Block
    include Liquid::StandardFilters

    SYNTAX = /^([a-zA-Z0-9.+#-]+)((\s+\w+(=\w+)?)*)$/

    def initialize(tag_name, markup, tokens)
      super
       if markup.strip =~ SYNTAX
         @lang = $1
       else
         raise SyntaxError.new("Syntax Error in 'highlight' - Valid syntax: hl <lang> [linenos]")
       end
    end

    def parse(tokens)
      @nodelist ||= []
      @nodelist.clear

      while token = tokens.shift
        if token =~ FullToken
          if block_delimiter == $1
            end_tag
            return
          end
        end
        @nodelist << token if not token.empty?
      end
    end

    def render(context)
      render_hl(context, super)
    end

    def render_hl(context, code)

      <<-HTML
<div>
  <pre><code class="#{@lang}">#{h(code).strip}</code></pre>
</div> 
      HTML
    end

  end

end

Liquid::Template.register_tag('hl', Jekyll::HlBlock)
