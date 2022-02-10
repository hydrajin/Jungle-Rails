require 'rails_helper'

# RSpec.feature "AddToCarts", type: :feature do
#   pending "add some scenarios (or delete) #{__FILE__}"
# end

RSpec.feature "Users can navigate from the home page.", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: "Apparel"

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset("apparel1.jpg"),
        quantity: 10,
        price: 64.99,
      )
    end
  end

  scenario "They click on the add button and the cart total updates" do
    # ACT
    visit root_path

    first(:button, "Add").click
  
    expect(page).to have_text "My Cart (1)"
    sleep(3)
    save_screenshot

  end
end