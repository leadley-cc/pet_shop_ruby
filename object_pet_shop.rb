class Customer
  def initialize(name, pets, cash)
    @name = name
    @pets = pets
    @cash = cash
  end

  attr_reader :cash

  def pet_count
    return @pets.count
  end

  def add_pet(new_pet)
    @pets.push(new_pet)
  end

  def can_afford_pet(new_pet)
    return @cash >= new_pet.price
  end

  def remove_cash(price)
    @cash -= price
  end

end

class Pet
  def initialize(name, pet_type, breed, price)
    @name = name
    @pet_type = pet_type
    @breed = breed
    @price = price
  end

  attr_reader :name
  attr_reader :breed
  attr_reader :price

end

class PetShop
  def initialize(name, total_cash, pets_sold, pets)
    @name = name
    @total_cash = total_cash
    @pets_sold = pets_sold
    @pets = pets
  end

  attr_reader :name
  attr_reader :total_cash
  attr_reader :pets_sold

  def add_or_remove_cash(cash_amount)
    @total_cash += cash_amount
  end

  def increase_pets_sold(new_sales)
    @pets_sold += new_sales if new_sales > 0
  end

  def stock_count
    return @pets.count
  end

  def pets_by_breed(breed)
    matching_pets = []
    for pet in @pets do
      matching_pets.push(pet) if pet.breed == breed
    end
    return matching_pets
  end

  def find_pet_by_name(name)
    for pet in @pets do
      return pet if pet.name == name
    end
    return nil
  end

  def remove_pet_by_name(name)
    for pet in @pets do
      @pets.delete(pet) if pet.name == name
    end
  end

  def add_pet_to_stock(new_pet)
    @pets.push(new_pet)
  end

  def sell_pet_to_customer(pet, customer)
    return nil if pet == nil
    return nil if customer.can_afford_pet(pet) == false
    customer.remove_cash(pet.price)
    add_or_remove_cash(pet.price)
    increase_pets_sold(1)
    remove_pet_by_name(pet.name)
    customer.add_pet(pet)
  end

end
