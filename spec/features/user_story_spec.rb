require 'rails_helper'

feature 'Accessing Application' do
  background do
    User.create(username: 'somoye')
    Group.create(name: 'Electronics', author_id: 1)
    Expense.create(name: 'Phone', amount: 500, author_id: 1)
    Expense.create(name: 'Laptop', amount: 2000, author_id: 1)
    ExpenseGroup.create(expense_id: 1, group_id: 1)
  end

  scenario 'Signing in with correct credentials' do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    expect(page).to have_content 'Successfully logged in.'
    expect(page).to have_current_path(root_path)
    expect(page).to_not have_current_path('/login')
  end

  scenario "User can't Sign in with wrong credentials" do
    visit '/login'
    fill_in 'Username', with: 'somoney'
    click_button 'Log in'
    expect(page).to have_content 'Error logging in.'
    expect(page).to have_current_path('/login')
    expect(page).to_not have_current_path(root_path)
  end
end

feature 'Navigation through the application pages' do
  background do
    User.create(username: 'somoye')
    Group.create(name: 'Electronics', author_id: 1)
    Expense.create(name: 'Phone', amount: 500, author_id: 1)
    Expense.create(name: 'Laptop', amount: 2000, author_id: 1)
    ExpenseGroup.create(expense_id: 1, group_id: 1)
  end

  scenario 'user is presented with a profile page' do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    expect(page).to have_content 'My Groups'
    expect(page).to have_content 'My Expenses'
    expect(page).to have_content 'My External expenses'
    expect(page).to_not have_content 'log In'
    expect(page).to_not have_content 'Sign Up'
  end

  scenario 'user opens My External expenses page' do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    click_link 'My External expenses'
    expect(page).to have_content '2000'
    expect(page).to have_content 'Laptop'
    expect(page).to have_content 'ADD NEW EXPENSE'
    expect(page).to_not have_current_path('/login')
  end
end

feature 'Creating New groups and expenses' do
  background do
    User.create(username: 'somoye')
  end

  scenario 'user opens Create New Group page' do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    click_link 'My Groups'
    click_link 'CREATE A NEW GROUP'
    expect(page).to have_current_path('/groups/new')
    expect(page).to have_content 'Create Transactions Group'
    click_button 'CREATE GROUP'
    expect(page).to_not have_current_path('/login')
    expect(page).to have_current_path('/groups')
  end

  scenario 'user opens Create New Expense page' do
    visit '/login'
    fill_in 'Username', with: 'somoye'
    click_button 'Log in'
    click_link 'My Expenses'
    click_link 'ADD NEW EXPENSE'
    expect(page).to have_current_path('/expenses/new')
    expect(page).to have_content 'Create An Expense'
    click_button 'Add new expense'
    expect(page).to have_current_path('/expenses')
    expect(page).to_not have_current_path('/login')
  end
end
