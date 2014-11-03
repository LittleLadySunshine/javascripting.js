module MarkdownHelper

  RENDERER = Redcarpet::Markdown.new(
    Redcarpet::Render::HTML,
    autolink: true,
    tables: true,
    fenced_code_blocks: true,
  )

  def markdownify(raw)
    RENDERER.render(raw).html_safe
  end

end
