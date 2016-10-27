require_relative '../rails_helper'
require 'capybara'

describe "Login "do
  context "via email " do
    it "successfully.",js: true do
      visit("https://encrypted.google.com")
    end
  end
end