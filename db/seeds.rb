# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

mapping = [
  {
    title: 'Medarodh (Weight Loss)',
    icp: 'Male, 20-45, Has a sitting job',
    competitors: ['Plix (ACV)', 'Shoepals', 'Whats Up Wellness', 'Cureveda', 'Kapiva (Juice)', 'Auric (Drink)', 'Oziva', 'Krishna Herbal']
  },
  {
    title: 'Manamrit (Sleep)',
    icp: 'Male, 25-50, Stress due to financial issues/office, too much reels/overthinking',
    competitors: ['Wellbeing Nutrition', 'Setu', 'Manmatters', 'Kapiva', 'Amrutam', 'healthvedaorganics', 'Carbamide Forte', 'HealthyHey']
  },
  {
    title: 'KeshArt(Hair)',
    icp: 'Male/Female - 20-45, lifestyle and chronic issues',
    competitors: ['Traya', 'Manmatters', 'Vedix', 'TAC - The Ayurveda Co', 'Indulekha']
  },
  {
    title: 'Yakritas (Liver Detox)',
    icp: 'Male, 20-45, Has a sitting job, combined with weight problem',
    competitors: ['Setu', 'Auri', 'Cureveda', 'Upakarma Ayurveda', 'Kapiva (Juice)']
  },
  {
    title: 'White Discharge',
    icp: 'Female, 30-50, lifestyle issue',
    competitors: ['Gynoveda', 'Namyaa', 'Life Aveda', 'Vedobi', 'Zeroharm', 'Girlyveda Whitelia –', 'Nova For Vaginal Microbiome']
  },
  {
    title: 'Weight Gain',
    icp: 'Male, 16-25, Tier 2 folks who didnt have access to nutrition while growing up',
    competitors: ['Ayuvya', 'Oziva', 'Plix', 'AS-IT-IS Nutrition', 'Bolt by Bold care', 'Dr. Vaidya', 'AccuMass']
  }
]

# code is looping for every product in the mapping array.
mapping.each do |row|
  # Finds or creates a product with the given title.
  # Product.where(title: row[:title]) → SQL SELECT * FROM products WHERE title = ?.
  p = Product.where(title: row[:title]).first_or_create!(price: nil, currency: 'INR', brand: 'myUpchar', icp: row[:icp])
  row[:competitors].each do |name|
    # Looks inside this product’s competitor_products association.
    # Tries to find one with that name.
    # If none exists → creates it.
    p.competitor_products.where(name: name).first_or_create!
  end
end

puts 'Seeded mapping + ICP.'


# Yeh code ek product aur uske competitors ko database me insert ya ensure karta hai.
# Agar pehle se hai → duplicate nahi banayega.
# Agar nahi hai → naya record create karega.
