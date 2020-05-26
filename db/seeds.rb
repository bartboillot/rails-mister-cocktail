# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'
require 'resolv-replace'
require 'faker'

puts "Cleaning Ingredient database..."
Ingredient.destroy_all

puts 'Creating Ingredient from Json'
url = URI.parse('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list')

ingredients_serialized = open(url).read

ingredients = JSON.parse(ingredients_serialized)

ingredients['drinks'].each do |ingr|
  Ingredient.create!(name: ingr['strIngredient1'])
end

puts "Cleaning Cocktail database..."
Cocktail.destroy_all

puts 'Creating 10 fake cocktails'
20.times do |n|
  cocktail = Cocktail.new
  cocktail.name = Faker::Coffee.blend_name
  cocktail.description = Faker::Food.description
  file = URI.open("https://source.unsplash.com/1600x900/weekly?cocktail/#{n}")
  cocktail.photo.attach(io: file, filename: "cocktail#{n}", content_type: 'image/png')
  cocktail.save
end

puts "Cleaning Dose database..."
Dose.destroy_all

Cocktail.all.each do |c|
  (5..10).to_a.sample.times do
    dose = Dose.new
    dose.measurement = Faker::Food.measurement
    dose.cocktail = c
    dose.ingredient = Ingredient.all.sample
    dose.save
  end
end

puts 'Done!'
