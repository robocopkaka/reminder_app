def sign_in(user)
  visit sign_in_path
  expect(page.has_selector?(".sign-in")).to be true
  fill_in "Email", with: user.email
  fill_in "Password", with: "password"
  click_on "Sign in"
end