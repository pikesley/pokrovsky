Given(/^the date is "(.*?)"$/) do |date|
  Timecop.freeze date
end

Then(/^the response should contain this text:$/) do |text|
  page.should have_content(text)
end