module MarkdownHelper

  RENDERER = Redcarpet::Markdown.new(
    Redcarpet::Render::HTML,
    autolink: true,
    tables: true,
    fenced_code_blocks: true,
    no_intra_emphasis: true,
  )

  def markdownify(raw)
    if raw.present?
      RENDERER.render(raw).gsub("<img ", '<img class="img-responsive" ').html_safe
    else
      ''
    end
  end

end
