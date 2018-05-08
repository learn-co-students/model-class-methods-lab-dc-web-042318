class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
  	 self.all.limit(5)
  end

  def self.dinghy
  	 self.all.where("length < 20")
  end

  def self.ship
	   self.all.where("length >= 20")
  end

  def self.last_three_alphabetically
  	 self.all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
	   self.all.where("captain_id IS null")
  end

  def self.sailboats 	
	   self.all.joins(boat_classifications: :classification).where('classifications.name = "Sailboat"')
  end

  def self.with_three_classifications
	   self.all.joins(boat_classifications: :classification).group("boats.name").having("count(classifications.id) > ?",2)
  end

  def self.longest
      order('length DESC').first
  end
end
