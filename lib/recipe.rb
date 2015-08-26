class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:categories)

  validates(:name, :presence => true)
  validates(:instructions, :presence => true)
  before_save(:check_tags)

  def display_tags
    tags = []
    categories.each do |c|
      tags.push("<a href='/categories/#{c.id}'>#{c.tag}</a>")
    end
    tags.join(", ")
  end

private

  def check_tags
    self.categories.validates_each
  end

end
