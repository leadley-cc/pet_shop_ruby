require 'minitest/autorun'
require 'minitest/pride'
require_relative '../object_pet_shop'

class TestPetShop < Minitest::Test

  def setup

    @customers = [
      Customer.new("Craig", [], 1000),
      Customer.new("Harrison", [], 50)
    ]

    @new_pet = Pet.new("Bors the Younger", :cat, "Cornish Rex", 100)

    @pet_shop_pets = [
      Pet.new("Sir Percy", :cat, "British Shorthair", 500),
      Pet.new("King Bagdemagus", :cat, "British Shorthair", 500),
      Pet.new("Sir Lancelot", :dog, "Pomsky", 1000),
      Pet.new("Arthur", :dog, "Husky", 900),
      Pet.new("Tristan", :dog, "Basset Hound", 800),
      Pet.new("Merlin", :cat, "Egyptian Mau", 1500)
    ]

    @pet_shop = PetShop.new("Camelot of Pets", 1000, 0, @pet_shop_pets)

  end

  def test_pet_shop_name
    name = @pet_shop.name
    assert_equal("Camelot of Pets", name)
  end

  def test_total_cash
    sum = @pet_shop.total_cash
    assert_equal(1000, sum)
  end

  def test_pets_sold
    sold = @pet_shop.pets_sold
    assert_equal(0, sold)
  end

  def test_add_or_remove_cash__add
    @pet_shop.add_or_remove_cash(10)
    cash = @pet_shop.total_cash
    assert_equal(1010, cash)
  end

  def test_add_or_remove_cash__remove
    @pet_shop.add_or_remove_cash(-10)
    cash = @pet_shop.total_cash
    assert_equal(990, cash)
  end

  def test_add_or_remove_cash__zero
    @pet_shop.add_or_remove_cash(0)
    cash = @pet_shop.total_cash
    assert_equal(1000, cash)
  end

  def test_increase_pets_sold
    @pet_shop.increase_pets_sold(2)
    sold = @pet_shop.pets_sold
    assert_equal(2, sold)
  end

  def test_increase_pets_sold__negative_fail
    @pet_shop.increase_pets_sold(-2)
    sold = @pet_shop.pets_sold
    assert_equal(0, sold)
  end

  def test_stock_count
    count = @pet_shop.stock_count
    assert_equal(6, count)
  end

  def test_all_pets_by_breed__found
    pets = @pet_shop.pets_by_breed("British Shorthair")
    assert_equal(2, pets.count)
  end

  def test_all_pets_by_breed__not_found
    pets = @pet_shop.pets_by_breed("Dalmation")
    assert_equal(0, pets.count)
  end

  def test_find_pet_by_name__returns_pet
    pet = @pet_shop.find_pet_by_name("Arthur")
    assert_equal("Arthur", pet.name)
  end

  def test_find_pet_by_name__returns_nil
    pet = @pet_shop.find_pet_by_name("Fred")
    assert_nil(pet)
  end

  def test_remove_pet_by_name
    @pet_shop.remove_pet_by_name("Arthur")
    pet = @pet_shop.find_pet_by_name("Arthur")
    assert_nil(pet)
  end

  def test_add_pet_to_stock
    @pet_shop.add_pet_to_stock(@new_pet)
    count = @pet_shop.stock_count
    assert_equal(7, count)
  end

  def test_add_pet_to_stock__right_pet
    @pet_shop.add_pet_to_stock(@new_pet)
    right_pet = @pet_shop_pets.include?(@new_pet)
    assert_equal(true, right_pet)
  end

  def test_customer_pet_count
    count = @customers[0].pet_count
    assert_equal(0, count)
  end

  def test_add_pet_to_customer
    customer = @customers[0]
    customer.add_pet(@new_pet)
    assert_equal(1, customer.pet_count)
  end

  # # OPTIONAL

  def test_customer_can_afford_pet__insufficient_funds
    customer = @customers[1]
    can_buy_pet = customer.can_afford_pet(@new_pet)
    assert_equal(false, can_buy_pet)
  end

  def test_customer_can_afford_pet__sufficient_funds
    customer = @customers[0]
    can_buy_pet = customer.can_afford_pet(@new_pet)
    assert_equal(true, can_buy_pet)
  end

  def test_customer_remove_cash
    customer = @customers[0]
    customer.remove_cash(500)
    assert_equal(500, customer.cash)
  end

  #These are 'integration' tests so we want multiple asserts.
  #If one fails the entire test should fail
  def test_sell_pet_to_customer__pet_found
    customer = @customers[0]
    pet = @pet_shop.find_pet_by_name("Arthur")

    @pet_shop.sell_pet_to_customer(pet, customer)

    assert_equal(1900, @pet_shop.total_cash)
    assert_equal(1, @pet_shop.pets_sold)
    assert_equal(1, customer.pet_count)
  end

  def test_sell_pet_to_customer__pet_not_found
    customer = @customers[0]
    pet = @pet_shop.find_pet_by_name("Dave")

    @pet_shop.sell_pet_to_customer(pet, customer)

    assert_equal(1000, @pet_shop.total_cash)
    assert_equal(0, @pet_shop.pets_sold)
    assert_equal(0, customer.pet_count)
  end

  def test_sell_pet_to_customer__insufficient_funds
    customer = @customers[1]
    pet = @pet_shop.find_pet_by_name("Arthur")

    @pet_shop.sell_pet_to_customer(pet, customer)

    assert_equal(1000, @pet_shop.total_cash)
    assert_equal(0, @pet_shop.pets_sold)
    assert_equal(0, customer.pet_count)
  end

end
