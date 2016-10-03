# Deleting Logos
puts "Deleting all logos"
Logo.destroy_all
# Create logos
puts "Creating logos"
Logo.create!(color: "Bleu", image: "logo.png")
Logo.create!(color: "Bleu marine", image: "logo-blue-dark.png")
Logo.create!(color: "Rouge", image: "logo-red.png")
Logo.create!(color: "Orange", image: "logo-orange.png")
Logo.create!(color: "Jaune", image: "logo-yellow.png")
Logo.create!(color: "Vert", image: "logo-green.png")
Logo.create!(color: "Violet", image: "logo-purple.png")
Logo.create!(color: "Gris", image: "logo-grey.png")
Logo.create!(color: "Noir", image: "logo-black.png")
puts "Done!"
