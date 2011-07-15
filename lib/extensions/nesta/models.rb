puts "in models"

raise "Nesta::FileModel not defined." unless defined?(Nesta::FileModel)

class Nesta::FileModel
  def convert_to_html(format, scope, text)
    case format
    when :mdown
      Maruku.new(text).to_html
    when :haml
      Haml::Engine.new(text).to_html(scope)
    when :textile
      puts "rendering redcloth"
      RedCloth.new(code_filter(text)).to_html
    end
  end
  
  def code_filter(txt)
    puts "In code filter"
    txt.gsub(/@@@ *(\w*)\r?\n? *(.+?)\r?\n?@@@/m) do
      # code = $2.gsub(/(^\n*|\n*$)/m, '')
      klass = $1.present? ? " class=\"#{$1.downcase}\"" : ""
      "<pre><code#{klass}>#{$2}</code></pre>"
    end
  end
end

  # def uploaded_image_tag(image_name, opts = {})
  #   opts.symbolize_keys

  #   opts[:size] = "original" if opts[:size].blank?
  #   opts[:size].strip!

  #   image = Image.find_by_image_file_name(image_name)

  #   return "<p><strong>Could not find image named #{image_name}</strong></p>" unless image

  #   image_options = { :src   => image.image.url(opts[:size]), 
  #                     :alt   => image.description,  
  #                     :class => "clear" }
  #   image_options[:class] << " float-right" if opts[:float] == :right
  #   image_options[:class] << " float-left"  if opts[:float] == :left

  #   url_options = { :href => image.source_url }

  #   img_tag = content_tag :img, "", image_options
  #   if image.source_url?
  #     return content_tag(:a, url_options) { img_tag }
  #   else
  #     return img_tag
  #   end
  # end

  # def image_filter(txt)
  #   txt.gsub(/^%([<>]?)([0-9a-zA-Z_.-]+)([^%]*)%/) do
  #     float    = $1
  #     image_id = $2
  #     size     = $3

  #     float = :right if float == '>'
  #     float = :left  if float == '<'

  #     uploaded_image_tag(image_id, :size => size, :float => float)
  #   end
  # end

  #   RedCloth.new(image_filter(code_filter(txt || ""))).to_html
