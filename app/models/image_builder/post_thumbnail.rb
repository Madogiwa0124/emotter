class ImageBuilder::PostThumbnail
  require 'mini_magick'
  require 'securerandom'

  BASE_IMAGE_PATH = './app/assets/images/thumbnail_bg.png'.freeze
  GRAVITY = 'center'.freeze
  TEXT_POSITION = '0,0'.freeze
  FONT = './app/assets/fonts/komorebi-gothic.ttf'.freeze
  FONT_SIZE = 65
  INDENTION_COUNT = 15
  ROW_LIMIT = 12

  class << self
    def build(text)
      text = prepare_text(text)
      @image = MiniMagick::Image.open(BASE_IMAGE_PATH)
      configuration(text)
    end

    def write(text)
      build(text)
      @image.write uniq_file_name
    end

    private

    def uniq_file_name
      "#{SecureRandom.hex}.png"
    end

    def configuration(text)
      @image.combine_options do |config|
        config.font FONT
        config.gravity GRAVITY
        config.pointsize FONT_SIZE
        config.draw "text #{TEXT_POSITION} '#{text}'"
      end
    end

    def prepare_text(text)
      text.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
    end
  end
end
