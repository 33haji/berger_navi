module ApplicationHelper

  # ページごとの完全なタイトルを返す
  def full_title(page_title = '')
    base_title = "厳選ハンバーガーマガジン"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Markdownに対応
  require "redcarpet"
  require "coderay"
  class HTMLwithCoderay < Redcarpet::Render::HTML
      def block_code(code, language)
          language = language.split(':')[0]

          case language.to_s
          when 'rb'
              lang = 'ruby'
          when 'yml'
              lang = 'yaml'
          when 'css'
              lang = 'css'
          when 'html'
              lang = 'html'
          when ''
              lang = 'md'
          else
              lang = language
          end

          CodeRay.scan(code, lang).div
      end
  end

  def markdown(text)
      html_render = HTMLwithCoderay.new(hard_wrap: true)
      options = {
          autolink: true,
          space_after_headers: true,
          no_intra_emphasis: true,
          fenced_code_blocks: true,
          tables: true,
          hard_wrap: true,
          xhtml: true,
          lax_html_blocks: true,
          strikethrough: true
      }
      markdown = Redcarpet::Markdown.new(html_render, options)
      markdown.render(text)
  end

  # spページに変換するためのメソッド
  def check_sp_user
    request.variant = :sp if is_sp_device?
  end

  # spページかどうかを判断するメソッド
  def is_sp_device?
    request.user_agent.include?('Mobile') || request.user_agent.include?('Android')
  end
end
