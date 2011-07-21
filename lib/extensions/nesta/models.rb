raise "Nesta::FileModel not defined." unless defined?(Nesta::FileModel)

class Nesta::FileModel
  def convert_to_html(format, scope, text)
    case format
    when :mdown
      Maruku.new(text).to_html
    when :haml
      Haml::Engine.new(text).to_html(scope)
    when :textile
      RedCloth.new(Formatter.new(text).to_html).to_html
    end
  end
  
end

