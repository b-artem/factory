class Factory

  def self.new(*attrs, &block)
    Class.new do
      attr_accessor(*attrs)
      @@attrs = attrs

      def initialize(*args)
        raise ArgumentError, "Too many arguments" if args.size > @@attrs.size
        @@attrs.zip(args) { |atr, val| instance_variable_set("@#{atr}", val) }
      end

      def [](atr)
        case atr.class.to_s
        when 'String', 'Symbol' then public_send(atr)
        when 'Integer'          then public_send("#{@@attrs[atr]}")
        else Factory.wrong_type
        end
      end

      def []=(atr, val)
        case atr.class.to_s
        when 'String', 'Symbol' then instance_variable_set("@#{atr}", val)
        when 'Integer'          then instance_variable_set("@#{@@attrs[atr]}", val)
        else Factory.wrong_type
        end
      end

      class_eval &block if block_given?
    end
  end

  def self.wrong_type
    raise TypeError, 'You should use type String, Symbol or Integer'
  end

end
