require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
   # validation tests/examples here
   
   it "validates that a product is sucessfully created (all fields present)" do
     @category = Category.new(name: 'Misc')
     @product = Product.new(name: "test", category: @category, price: 123, quantity: 123)
     @product.save!
     expect(@product.id).to be_present
     expect(@product.name).to eq("test")
     expect(@product.quantity).to eq(123)
   end 

    it "validates the presence of a name" do
      @category = Category.new(name: "Misc")
      @product = Product.new(name: nil, category: @category, price: 123, quantity: 123)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "validates the presence of a price" do
      @category = Category.new(name: "Misc")
      @product = Product.new(name: "test", category: @category, price: nil, quantity: 123)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "validates the presence of quanitity" do
      @category = Category.new(name: "Misc")
      @product = Product.new(name: "test", category: @category, price: 123, quantity: nil)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates the presence the presence of a category' do
      @category = Category.new
      @product = Product.new(name: "test", quantity: 1, price: 123)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end