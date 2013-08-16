require 'spec_helper'

describe Address do

  it { should belong_to(:company) }

  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }

  it { should ensure_length_of(:state).is_equal_to(2) }
  it { should ensure_inclusion_of(:zip).in_range(10000..99999) }
  it { should_not allow_value('non-digit').for(:zip) }

  it { should allow_mass_assignment_of(:street) }
  it { should allow_mass_assignment_of(:city) }
  it { should allow_mass_assignment_of(:state) }
  it { should allow_mass_assignment_of(:zip) }

end
