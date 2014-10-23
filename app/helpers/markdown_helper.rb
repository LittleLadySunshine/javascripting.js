module MarkdownHelper

  RENDERER = Redcarpet::Markdown.new(
    Redcarpet::Render::HTML,
    autolink: true,
    tables: true
  )

  def markdownify(raw)
    RENDERER.render(raw).html_safe
  end

end
