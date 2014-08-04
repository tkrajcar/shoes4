class Shoes
  class Link < Span
    attr_reader :app, :parent, :gui, :blk

    DEFAULT_OPTS = { underline: true, stroke: ::Shoes::COLORS[:blue] }

    def initialize(app, parent, texts, opts = {}, blk = nil)
      @app = app
      @parent = parent

      opts = DEFAULT_OPTS.merge(opts)
      @gui = Shoes.backend_for(self, opts)

      setup_click(blk, opts)

      super texts, opts
    end

    # Doesn't use Common::Clickable because of URL flavor option clicks
    def setup_click(blk, opts)
      if blk.nil? && opts.include?(:click)
        if opts[:click].respond_to?(:call)
          blk = opts[:click]
        else
          # Slightly awkward, but we need App, not InternalApp, to call visit
          blk = Proc.new { app.app.visit(opts[:click]) }
        end
      end

      click(&blk) if blk
      @blk = blk
    end

    def click(&blk)
      @gui.click(blk)
      @blk = blk
    end

    def in_bounds?(x, y)
      @gui.in_bounds?(x, y)
    end

    def remove
      @gui.remove
    end
  end
end
