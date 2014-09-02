Given(/^the date is "(.*?)"$/) do |date|
  Timecop.freeze date
end

Then(/^the response should( not)? contain this text:$/) do |boolean, text|
  if boolean
    page.should_not have_content(text)
  else
    page.should have_content(text)
  end
end
