class Markdown
  class << self
    def renderer
      Redcarpet::Render::HTML.new(
        filter_html: true,
        no_images: false,
        no_links: false,
        no_styles: false,
        escape_html: true,
        safe_links_only: false,
        with_toc_data: false,
        hard_wrap: true,
        xhtml: false,
        prettify: true,
        link_attributes: {
          target: '_blank'
        }
      )
    end

    def markdown
      Redcarpet::Markdown.new(renderer,
        no_intra_emphasis: true,
        tables: true,
        fenced_code_blocks: true,
        autolink: true,
        disable_indented_code_blocks: true,
        strikethrough: true,
        lax_spacing: true,
        space_after_headers: true, # For hashtag
        superscript: true,
        underline: true,
        highlight: true,
        quote: true,
        footnotes: true,
      )
    end

    def render(content)
      markdown.render(content.to_s)
    end
  end
end
