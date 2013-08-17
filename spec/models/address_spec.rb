require 'spec_helper'

describe Address do

  it { should have_many(:companies) }

  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }

  it { should callback(:geocode).before(:validation) }

  it { should ensure_length_of(:state).is_equal_to(2) }
  it { should ensure_inclusion_of(:zip).in_range(00001..99999) }
  it { should_not allow_value('non-digit').for(:zip) }

  it { should allow_mass_assignment_of(:street) }
  it { should allow_mass_assignment_of(:city) }
  it { should allow_mass_assignment_of(:state) }
  it { should allow_mass_assignment_of(:zip) }
  it { should allow_mass_assignment_of(:latitude) }
  it { should allow_mass_assignment_of(:longitude) }

end
