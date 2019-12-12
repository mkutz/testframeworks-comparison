#!/usr/bin/env ruby

require 'rspec/autorun'
require 'date'
require_relative 'user'

# tag::describe[]
describe User do
# end::describe[]

  # tag::subject[]
  subject { described_class.new("tdoe", "Timmy", "Doe", Date.today) }
  # end::subject[]

  # tag::let[]
  let(:eighteenYearsAgo) {
    today = Date.today
    Date.new(today.year - 18, today.month, today.day)
  }
  # end::let[]

  # tag::long_it[]
  it "has all attributes" do
    expect(subject.username).to eq("tdoe")
    expect(subject.firstname).to eq("Timmy")
    expect(subject.lastname).to eq("Doe")
    expect(subject.birthday).to eq(Date.today)
    expect(subject.age).to eq(0)
    expect(subject.of_age).to eq(false)
  end
  # end::long_it[]

  context "adult" do

    # tag::short_it[]
    subject { described_class.new("jdoe", "John", "Doe", eighteenYearsAgo) }
    it("should be of age") { should be_of_age == true }
    # end::short_it[]

  end

  # tag::context[]
  context "child" do

    subject { described_class.new("rdoe", "Rose", "Doe", eighteenYearsAgo+1) }
    
    it { should have_attributes(:of_age => false, :age => 17) }

  end
  # end::context[]

  context "not born yet" do

    it "can't be created" do
      expect { described_class.new("hdoe", "Hope", "Doe", Date.today+1) }.to raise_error("future birthday")
    end

  end

end