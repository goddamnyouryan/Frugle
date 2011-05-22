module Sitemap
  class Map
    class << self
      attr_reader :draw_block
      
      def draw(&block)
        @draw_block = block
      end
    end
  end
end