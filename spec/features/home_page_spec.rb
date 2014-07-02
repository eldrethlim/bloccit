require 'rails_helper'

describe "home page" do
  it "should show Bloccit!" do
    visit '/'
    expect(page).to have_content('Bloccit!')
  end
end