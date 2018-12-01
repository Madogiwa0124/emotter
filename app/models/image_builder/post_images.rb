class ImageBuilder::PostImages
  require 'mini_magick'
  require 'securerandom'

  BASE_IMAGE_PATH = './app/assets/images/post_image.png'.freeze
  GRAVITY = 'center'.freeze
  TEXT_POSITION = '0,0'.freeze
  FONT = './app/assets/fonts/komorebi-gothic.ttf'.freeze
  FONT_SIZE = 24
  INDENTION_COUNT = 18
  ROW_LIMIT = 28

  class << self
    def build(body)
      @images = []
      body.each_char.each_slice(INDENTION_COUNT * ROW_LIMIT).map(&:join).map do |text|
        text = prepare_text(text)
        @images << MiniMagick::Image.open(BASE_IMAGE_PATH)
        configuration(text, @images.last)
      end
    end

    def write(body)
      build(body)
      @images.each { |image| image.write uniq_file_name }
    end

    private

    def uniq_file_name
      "#{SecureRandom.hex}.png"
    end

    def configuration(text, image)
      image.combine_options do |config|
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
