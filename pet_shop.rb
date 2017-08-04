def pet_shop_name(pet_shop)
  return pet_shop[:name]
end

def total_cash(pet_shop)
  return pet_shop[:admin][:total_cash]
end

def pets_sold(pet_shop)
  return pet_shop[:admin][:pets_sold]
end

def add_or_remove_cash(pet_shop, cash_amount)
  pet_shop[:admin][:total_cash] += cash_amount
end

def increase_pets_sold(pet_shop, new_sales)
  pet_shop[:admin][:pets_sold] += new_sales if new_sales > 0
end

def stock_count(pet_shop)
  return pet_shop[:pets].count
end

def pets_by_breed(pet_shop, breed)
  matching_pets = []
  for pet in pet_shop[:pets] do
    matching_pets.push(pet) if pet[:breed] == breed
  end
  # pet_shop[:pets].each do |pet|
  #   matching_pets.push(pet) if pet[:breed] == breed
  # end
  return matching_pets
end

def find_pet_by_name(pet_shop, name)
  for pet in pet_shop[:pets] do
    return pet if pet[:name] == name
  end
  return nil
end

def remove_pet_by_name(pet_shop, name)
  for pet in pet_shop[:pets] do
    pet_shop[:pets].delete(pet) if pet[:name] == name
  end
end

def add_pet_to_stock(pet_shop, new_pet)
  pet_shop[:pets].push(new_pet)
end

def customer_pet_count(customer)
  return customer[:pets].count
end

def add_pet_to_customer(customer, new_pet)
  customer[:pets].push(new_pet)
end

def customer_can_afford_pet(customer, new_pet)
  return customer[:cash] >= new_pet[:price]
end

def customer_remove_cash(customer, price)
  customer[:cash] -= price
end

def sell_pet_to_customer(pet_shop, pet, customer)
  return nil if pet == nil
  return nil if customer_can_afford_pet(customer, pet) == false
  price = pet[:price]
  customer_remove_cash(customer, price)
  add_or_remove_cash(pet_shop, price)
  increase_pets_sold(pet_shop, 1)
  remove_pet_by_name(pet_shop, pet[:name])
  add_pet_to_customer(customer, pet)
end
