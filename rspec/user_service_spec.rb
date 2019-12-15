#!/usr/bin/env ruby

require 'rspec/autorun'
require 'date'
require_relative 'user'
require_relative 'user_service'

describe UserService do

  subject { described_class.new(repository_mock) }
  
  let(:some_user) { User.new("suser", "Some", "User", Date.new(1982, 2, 19)) }
  let(:repository_mock) {
    # tag::instance_double[]
    double("UserRepository")
    # end::instance_double[]
  }

  it "persists the user data via UserRepository" do
    # tag::expect_mock_to_receive_and_return[]
    expect(repository_mock).to receive(:find_by_username)
      .with(some_user.username)
      .and_return(nil)
    # end::expect_mock_to_receive_and_return[]
    # tag::expect_mock_to_receive[]
    expect(repository_mock).to receive(:save_user)
      .with(some_user)
    # end::expect_mock_to_receive[]

    subject.register_user(some_user)
  end

  context "already registered" do

    it "does not persist user data if the username was registered before" do
    # tag::allow_stub_to_receive[]
    allow(repository_mock).to receive(:find_by_username).with(some_user.username) { some_user }
    # end::allow_stub_to_receive[]
    expect(repository_mock).not_to receive(:save_user)
        .with(some_user)

      expect { subject.register_user(some_user) }.to raise_error("user already exists")
    end
  end
end