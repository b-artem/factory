require './factory.rb'

Customer1 = Factory.new(:name, :address, :zip)
joe = Customer1.new('Joe Smith', '123 Maple, Anytown NC', 12345)
# => #<struct Customer name="Joe Smith", address="123 Maple, Anytown NC", zip=12345>
puts joe.inspect

puts joe.name    # => "Joe Smith"
puts joe['name'] # => "Joe Smith"
puts joe[:name]  # => "Joe Smith"
puts joe[0]      # => "Joe Smith"

Customer2 = Factory.new(:name, :address) do
  def greeting
    "Hello #{name}!"
  end
end

dave = Customer2.new('Dave', '123 Main')
puts dave.inspect
puts dave.greeting
# puts dave.class.ancestors

