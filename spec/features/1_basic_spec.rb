require "rails_helper"

describe "New User record" do
  let(:user) { User.create(username: "alice", email: "alice@example.com", password: "password") }

  it "has a default `likes_count` of 0", points: 1 do
    expect(user.likes_count).to eq(0),
      "Expected a new user to have a default `likes_count` of 0. Did you make the change in your user migration file?"
  end

  it "has a default `comments_count` of 0", points: 1 do
    expect(user.comments_count).to eq(0),
      "Expected a new user to have a default `comments_count` of 0. Did you make the change in your user migration file?"
  end
end

describe "The home page" do
  before do
    sign_in_user if user_model_exists?
  end

  it "has a bootstrap navbar", points: 1 do
    visit "/"

    expect(page).to have_selector("nav[class^='navbar']"),
      "Expected home page to have a bootstrap navbar <nav class='navbar ...'> ."
  end

  it "has a sign out link with a DELETE request for the signed in user", points: 1 do
    visit "/"

    expect(page).to have_selector("a[href='/users/sign_out'][data-method='delete']"),
      "Expected home page to have 'Sign out' link with the proper data-method='delete' if the user is signed in."
  end

  it "does not have a sign in link if the user is already signed in", points: 1 do
    visit "/"

    expect(page).to_not have_selector("a[href='/users/sign_in']"),
      "Expected home page to not have 'Sign in' link if the user is signed in."
  end
end

describe "User authentication with the Devise gem" do
  let(:user) { User.create(username: "alice", email: "alice@example.com", password: "password") }

  it "allows a signed up user to sign in", points: 1 do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page.current_path).to eq("/"),
      "Expected to successfully sign in a signed up user."
  end

  it "requires sign in before any action with the Devise `before_action :authenticate_user!` method", points: 2 do
    visit "/#{user.username}"
    current_url = page.current_path

    expect(current_url).to eq(new_user_session_path),
      "Expected `before_action :authenticate_user!` in `ApplicationController` to redirect guest to /users/sign_in before visiting another page."
  end
end

def sign_in_user
  user = User.create(username: "alice", email: "alice@example.com", password: "password")
  visit new_user_session_path

  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end

def user_model_exists?
  Object.const_defined?("User")
end