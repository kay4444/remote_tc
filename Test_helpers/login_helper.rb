# require "../rails_helper"
module LoginHelper
  def login (email, password)
    fill_in("Email", :with => email)
    fill_in("Password", :with => password)
    click_button('user_login')
  end
end