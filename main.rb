require './factory'

# Example 1
Customer = Factory.new(:name, :address, :zip)
joe = Customer.new('Joe Smith', '123 Maple, Anytown NC', 12345)
puts joe.inspect
puts "Changing name to 'John Smith'..."
joe[:name] = 'John Smith'
puts joe.name
puts joe['name']
puts joe[:name]
puts joe[0]
puts

# Example 2
Supplier = Factory.new(:name, :address) do
  def greeting
    "Hello, #{name}!"
  end
end
dave = Supplier.new('Dave', '123 Main')
puts dave.inspect
puts dave.greeting
