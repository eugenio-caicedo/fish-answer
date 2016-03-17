RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
   config.include Features::WaitForAjax, type: :feature
end

Capybara.add_selector(:title) do
  xpath { |title| XPath.descendant[XPath.attr(:title).contains(title)] }
end