require 'spec_helper'

describe User do

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:default_city) }
  it { should validate_presence_of(:default_state) }

  it { should ensure_length_of(:default_state).is_equal_to(2) }

  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }

  it { should allow_mass_assignment_of(:first_name) }
  it { should allow_mass_assignment_of(:last_name) }
  it { should allow_mass_assignment_of(:username) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:password_digest) }
  it { should allow_mass_assignment_of(:default_city) }
  it { should allow_mass_assignment_of(:default_state) }

end


