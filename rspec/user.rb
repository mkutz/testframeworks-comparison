#!/usr/bin/env ruby

require 'date'

class User
  attr_reader :username
  attr_reader :firstname
  attr_reader :lastname
  attr_reader :birthday

  def initialize(username, firstname, lastname, birthday)
    raise("future birthday") if birthday > Date.today
    @username = username
    @firstname = firstname
    @lastname = lastname
    @birthday = birthday
  end

  def age
    today = Date.today
    today.year - @birthday.year - ((today.month > @birthday.month || (today.month == @birthday.month && today.day >= @birthday.day)) ? 0 : 1)
  end

  def of_age
    age >= 18
  end
end
