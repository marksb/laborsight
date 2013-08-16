require 'spec_helper'

describe Industry do

  it { should validate_presence_of(:naic_code) }
  it { should validate_presence_of(:naic_code_description) }
  it { should validate_uniqueness_of(:naic_code) }
  it { should validate_uniqueness_of(:naic_code_description) }

  it { should_not allow_value('non-digit').for(:naic_code) }
  it { should ensure_inclusion_of(:naic_code).in_range(1000..9999999) }

  it { should allow_mass_assignment_of(:naic_code) }
  it { should allow_mass_assignment_of(:naic_code_description) }

end