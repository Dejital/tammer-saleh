class Image
  mattr_accessor :images_root
  attr_accessor :name, :size, :description, :source_url

  self.images_root = "#{File.dirname(__FILE__)}/../content/attachments/images"

  def initialize(name, size)
    meta_file = "#{images_root}/#{File.basename(name, ".*")}/meta.yml"
    raise "Could not find #{meta_file}" unless File.exists?(meta_file)

    meta = YAML.load_file(meta_file)

    self.name        = name
    self.size        = size
    self.description = meta[:description]
    self.source_url  = meta[:source_url]
  end

  def path
    basename = File.basename(name, ".*")
    ext      = File.extname(name)

    "/attachments/images/#{basename}/#{size}#{ext}"
  end
end
