require 'rails_helper'

feature "User Story" do
  background do
    User.create(username: 'somoye')
    Group.create(name: 'Electronics', author_id: 1)
    Expense.create(name: 'Phone', amount: 500, author_id: 1)
    Expense.create(name: 'Laptop', amount: 2000, author_id: 1)
    ExpenseGroup.create(expense_id:1, group_id:1)
  end
  
  scenario "Signing in with correct credentials" do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    expect(page).to have_content 'Successfully logged in.'
    expect(page).to have_current_path(root_path)
  end

  scenario "User can't Sign in with wrong credentials" do
    visit '/login'
    fill_in 'Username', with: 'somoney'
    click_button 'Log in'
    expect(page).to have_content 'Error logging in.'
    expect(page).to have_current_path('/login')
  end

  scenario "user is presented with a profile page" do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    expect(page).to have_content 'My Groups'
    expect(page).to have_content 'My Expenses'
    expect(page).to have_content 'My External expenses'
  end

  scenario "user opens My Expenses page" do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    click_link 'My Expenses'
    expect(page).to have_content '500'
    expect(page).to have_content 'Phone'
    expect(page).to have_content 'ADD NEW EXPENSE'
  end

  scenario "user opens My External expenses page" do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    click_link 'My External expenses'
    expect(page).to have_content '2000'
    expect(page).to have_content 'Laptop'
    expect(page).to have_content 'ADD NEW EXPENSE'
  end

  scenario "user opens My Groups page" do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    click_link 'My Groups'
    expect(page).to have_content 'Electronics'
    expect(page).to have_content 'CREATE A NEW GROUP'
    click_link 'Electronics'
    expect(page).to have_current_path('/groups/1')
  end

  scenario "user opens Group page" do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    click_link 'My Groups'
    click_link 'Electronics'
    expect(page).to have_content 'Phone'
    expect(page).to have_content 'somoye'
  end
  
  scenario "user opens Create New Group page" do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    click_link 'My Groups'
    click_link 'CREATE A NEW GROUP'
    expect(page).to have_current_path('/groups/new')
    expect(page).to have_content 'Create Transactions Group'
    click_button 'CREATE GROUP'
    expect(page).to have_current_path('/groups')
  end

  scenario "user opens Create New Expense page" do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    click_link 'My Expenses'
    click_link 'ADD NEW EXPENSE'
    expect(page).to have_current_path('/expenses/new')
    expect(page).to have_content 'Create An Expense'
    click_button 'Add new expense'
    expect(page).to have_current_path('/expenses')
  end
end