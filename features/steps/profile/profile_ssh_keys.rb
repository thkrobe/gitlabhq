class ProfileSshKeys < Spinach::FeatureSteps
  include SharedAuthentication

  Then 'I should see my ssh keys' do
    @user.keys.each do |key|
      page.should have_content(key.title)
    end
  end

  Given 'I click link "Add new"' do
    click_link "Add new"
  end

  And 'I submit new ssh key "Laptop"' do
    fill_in "key_title", :with => "Laptop"
    fill_in "key_key", :with => "ssh-rsa publickey234="
    click_button "Save"
  end

  Then 'I should see new ssh key "Laptop"' do
    key = Key.find_by_title("Laptop")
    page.should have_content(key.title)
    page.should have_content(key.key)
    current_path.should == key_path(key)
  end

  Given 'I click link "Work"' do
    click_link "Work"
  end

  And 'I click link "Remove"' do
    click_link "Remove"
  end

  Then 'I visit profile keys page' do
    visit keys_path
  end

  And 'I should not see "Work" ssh key' do
    within "#keys-table" do
      page.should_not have_content "Work"
    end
  end

  And 'I have ssh key "ssh-rsa Work"' do
    Factory :key, :user => @user, :title => "ssh-rsa Work", :key => "jfKLJDFKSFJSHFJssh-rsa Work"
  end
end
