#!/usr/bin/env ruby

require_relative 'user'

class UserService

  def initialize(repository)
    @repository = repository
  end

  def register_user(user)
    if @repository.find_by_username(user.username) != nil
      raise("user already exists")
    end
    @repository.save_user(user)
  end
end