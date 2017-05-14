require 'byebug'

class Factory

  def self.new(*attributes, &block)
    # super()
    Class.new do
      # include Enumerable
      @@attributes = attributes
      attr_accessor(*attributes)

      def initialize(*args)
        # raise ArgumentError, "Too many arguments" if args.size > @@attributes.size
        @@attributes.zip(args) do |attribute, value|
          instance_variable_set("@#{attribute}", value)
        end
      end

      class_eval &block if block_given?

      def [](attribute)
        if attribute.instance_of?(String) || attribute.instance_of?(Symbol)
          public_send(attribute)
        elsif attribute.instance_of?(Integer)
          public_send("#{@@attributes[attribute]}")
        else
          puts "Wrong argument #{attribute}"
        end
      end

    end
  end

end
