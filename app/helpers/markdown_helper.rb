module MarkdownHelper

  RENDERER = Redcarpet::Markdown.new(
    Redcarpet::Render::HTML,
    autolink: true,
    tables: true,
    fenced_code_blocks: true,
  )

  def markdownify(raw)
    if raw.present?
      RENDERER.render(raw).html_safe
    else
      ''
    end
  end

end
