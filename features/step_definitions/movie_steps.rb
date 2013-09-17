# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  aString = page.body.to_s
    if aString.index(e1) != nil && aString.index(e2) != nil
      if aString.index(e1) < aString.index(e2)
      else
        assert false, "jr_fail"
      end
    else
      assert false, "jr_fail"
    end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(",")
  ratings.each do |rating|
   if uncheck
     uncheck "ratings_#{rating}"
   else
     check "ratings_#{rating}"
   end
  end 
end

def table_cell(content)
  /.*<td>#{content}<\/td>.*/m
end
Then /I should see ratings: (.*)/ do |rating_list|
  ratings = rating_list.split(",")
  ratings.each do |rating|
    page.body.should match table_cell(rating)
  end
end

Then /I should not see ratings: (.*)/ do |rating_list|
  ratings = rating_list.split(",")
  ratings.each do |rating|
    page.body.should_not match table_cell(rating)
  end
end

Then /I should see all of the movies/ do
  Movie.all.each do |movie|
    page.body.should match table_cell(movie.title)
  end
end

Then /I shoud not see all of the movies/ do
  Movie.all.each do |movie|
    page.body.should_not match table_cell(movie.title)
  end
end


