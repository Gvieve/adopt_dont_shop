class Shelter < ApplicationRecord
  has_many :pets

  def self.sorted_by_name_desc
    find_by_sql("select * from shelters order by name desc")
  end

  def self.get_name_and_address(shelter_id)
    find_by_sql(
      "select name, address, city, state, zip from shelters where id = #{shelter_id}"
    ).first.full_address
  end

  def full_address
   "#{street_address ||= address} #{city} #{state} #{zip_code ||= zip}"
  end

  def self.with_pending_apps
    Shelter.joins(pets: :applications).where(applications: {status: 1}).select(:name).distinct.select(:id).order(:name)
  end
end
