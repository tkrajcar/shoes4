class Shoes
  class Link < Span

    include Common::Style

    attr_reader :app, :parent, :gui, :blk
    style_with :text_block_styles
    STYLES = { underline: true, stroke: ::Shoes::COLORS[:blue], fill: nil }

    def initialize(app, parent, texts, styles = {}, blk = nil)
      @app = app
      @parent = parent
      style_init(styles)
      @gui = Shoes.backend_for(self, @style)

      setup_click(blk, @style)
      super texts, @style
    end

    # Doesn't use Common::Clickable because of URL flavor option clicks
    def setup_click(blk, style)
      if blk.nil? && style.include?(:click)
        if style[:click].respond_to?(:call)
          blk = style[:click]
        else
          # Slightly awkward, but we need App, not InternalApp, to call visit
          blk = Proc.new { app.app.visit(style[:click]) }
        end
      end

      click(&blk)
    end

    def click(&blk)
      @gui.click(blk) if blk
      @blk = blk
    end

    def pass_coordinates?
      false
    end

    def in_bounds?(x, y)
      @gui.in_bounds?(x, y)
    end

    def remove
      @gui.remove
    end
  end
end
