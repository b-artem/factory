class Factory

  def self.new(*attrs, &block)

    attrs.each do |atr|
      raise NameError, "Argument #{atr} should be a symbol" unless atr.is_a? Symbol
    end

    Class.new do
      attr_accessor(*attrs)

      define_method :initialize do |*args|
        raise ArgumentError, "Too many arguments" if args.size > attrs.size
        attrs.zip(args) { |atr, val| public_send("#{atr}=", val) }
      end

      define_method :[] do |atr|
        case atr.class.to_s
        when 'String', 'Symbol' then public_send(atr)
        when 'Integer'          then public_send("#{attrs[atr]}")
        else wrong_type
        end
      end

      define_method :[]= do |atr, val|
        case atr.class.to_s
        when 'String', 'Symbol' then public_send("#{atr}=", val)
        when 'Integer'          then public_send("#{attrs[atr]}=", val)
        else wrong_type
        end
      end

      class_eval &block if block_given?
    end
  end

  def wrong_type
    raise TypeError, 'You should use type String, Symbol or Integer'
  end

end
