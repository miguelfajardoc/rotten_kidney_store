# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Characters
characters_by_klass = {
  "Marvel" => %w[Deadpool Wolverine Spider-Man Iron\ Man],
  "DC" => ["Batman", "Joker", "Superman", "Harley Quinn"],
  "Movies" => ["Terminator", "Predator", "Yoda", "Darth Vader"]
}

characters_by_klass.each do |klass, names|
  names.each do |name|
    Character.find_or_create_by!(name: name, klass: klass)
  end
end

# Product kinds
product_kind_names = %w[magnet full half lamp]
materials = ["resin", "white plaster"]
descriptions = [
  "Hand-painted collectible piece with fine detail work.",
  "High-quality figure perfect for display or gifting.",
  "Limited edition design inspired by the original character.",
  "Durable finish with vivid color accuracy.",
  "Premium craftsmanship with intricate sculpting."
]

product_kind_names.each do |name|
  ProductKind.find_or_create_by!(name: name) do |product_kind|
    product_kind.material = materials.sample
    product_kind.description = descriptions.sample
  end
end

# Sizes (0 to 4)
(0..4).each do |value|
  Size.find_or_create_by!(size: value)
end

# Link a random subset of sizes to each product kind
sizes = Size.all.to_a
ProductKind.find_each do |product_kind|
  product_kind.sizes = sizes.sample(rand(1..sizes.size))
end

# Products
characters = Character.all.to_a
product_kinds = ProductKind.all.to_a
additional_infos = [
  "Includes certificate of authenticity",
  "Comes in gift box",
  "Signed by the artist",
  nil
]

if Product.count.zero?
  20.times do
    price = rand(10.0..200.0).round(2)
    cost = (price * rand(0.3..0.8)).round(2)

    Product.create!(
      stock: rand(0..100),
      price: price,
      cost: cost,
      aditional_info: additional_infos.sample,
      character: characters.sample,
      product_kind: product_kinds.sample
    )
  end
end
