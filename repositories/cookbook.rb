require 'csv'
require_relative '../models/recipe'

class Cookbook
  attr_reader :recipes
  def initialize(csv_file) # loads existing Recipe from the CSV
    @recipes = [] # stock des instences de Recipe
    @csv_file = csv_file
    load_csv
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end

  def add_recipe(recipe) # adds a new recipe to the cookbook
    @recipes << recipe
    update_csv
  end

  def remove_recipe(recipe_id) # removes a recipe from the cookbook.
    @recipes.delete_at(recipe_id)
    update_csv
  end

  private

  def load_csv
    # CSV parsing
    CSV.foreach(@csv_file) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3])
    end
  end

  def update_csv
    CSV.open(@csv_file, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.cooking_time, recipe.difficulty]
      end
    end
  end
end
