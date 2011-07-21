class Formatter
  attr_accessor :text

  include Padrino::Helpers::OutputHelpers
  include Padrino::Helpers::TagHelpers
  include Padrino::Helpers::AssetTagHelpers
  include Padrino::Helpers::FormHelpers
  include Padrino::Helpers::FormatHelpers
  include Padrino::Helpers::RenderHelpers
  include Padrino::Helpers::NumberHelpers
  include Padrino::Helpers::TranslationHelpers

  def initialize(text)
    self.text = text
  end

  def to_html
    code_filter(image_filter(text))
  end

  def code_filter(txt)
    txt.gsub(/@@@ *(\w*)\r?\n? *(.+?)\r?\n?@@@/m) do
      # code = $2.gsub(/(^\n*|\n*$)/m, '')
      klass = $1.present? ? " class=\"#{$1.downcase}\"" : ""
      "<pre><code#{klass}>#{$2}</code></pre>"
    end
  end

  def uploaded_image_tag(image_name, opts = {})
    opts.symbolize_keys

    opts[:size] = "original" if opts[:size].blank?
    opts[:size].strip!

    image = Image.new(image_name, opts[:size])

    image_options = { :src   => image.path, 
                      :alt   => image.description,  
                      :class => "clear" }
    image_options[:class] << " float-right" if opts[:float] == :right
    image_options[:class] << " float-left"  if opts[:float] == :left

    url_options = { :href => image.source_url }

    img_tag = content_tag :img, "", image_options
    if image.source_url.present?
      return content_tag(:a, url_options) { img_tag }
    else
      return img_tag
    end
  end

  def image_filter(txt)
    txt.gsub(/^%([<>]?)([0-9a-zA-Z_.-]+)([^%]*)%/) do
      float    = $1
      image_id = $2
      size     = $3

      float = :right if float == '>'
      float = :left  if float == '<'

      uploaded_image_tag(image_id, :size => size, :float => float)
    end
  end
end
