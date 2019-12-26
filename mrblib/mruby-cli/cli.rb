module MRubyCLI
  class CLI
    def initialize(argv, output_io = $stdout, error_io = $stderr)
      @options = setup_options
      @opts = @options.parse(argv)
      @output_io = output_io
      @error_io  = error_io
    end

    def run
      if app_name = @options.option(:setup)
        mruby_version = @options.option(:'mruby-version') || '1.2.0'
        Setup.new(app_name, @output_io, mruby_version).run
      elsif @options.option(:version)
        Version.new(@output_io).run
      else
        Help.new(@output_io).run
      end
    end

    private
    def setup_options
      options = Options.new
      options.add(Option.new("setup", "s", true))
      options.add(Option.new("mruby-version", nil, true))
      options.add(Option.new("version", "v"))
      options.add(Option.new("help", "h"))

      options
    end
  end
end
