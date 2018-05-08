class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	self.all.joins(boats: :classifications).where('classifications.name ="Catamaran"')
  end

  def self.sailors
  	self.all.joins(boats: :classifications).where('classifications.name ="Sailboat"').group("captains.name")
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
