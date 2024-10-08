require 'rails_helper'

RSpec.describe Notification, type: :model do
  # Association tests
  it { should belong_to(:user) }
  it { should belong_to(:actor).class_name('User') }
  it { should belong_to(:tweet).optional }


  # Validation tests
  it { should validate_presence_of(:verb) }
  it { should validate_inclusion_of(:verb).in_array(Notification::VERBS) }
end
