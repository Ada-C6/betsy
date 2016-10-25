FactoryGirl.define do

  # product with a 'belongs_to' user
  factory :product do
    category "fashion"
    description "A cape like no other, for the undead"
    inventory 1
    name "Magic Cape"
    photo_url "Minions/Ghosts.png"
    price 10.00

    trait :no_inventory do
      inventory 0
    end
  end
  factory :user do
    first_name "Michelle"
    last_name "Obama"
    # practicing with dependent attributes
    email {"#{first_name.downcase}@example.com"}
    street_address "2100 Bad Ass Drive"
    state "WA"
    zip 98122
    # credit_card 4000400040002000
    # credit_expiration 10/17
    # phone 2062223333

  end

  factory :order do
    product
    user
  end


end
