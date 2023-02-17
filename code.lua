function myCodeFunction()
-- Define a table of search suggestions
local searchSuggestions = {"Apple", "Banana", "Cherry", "Grape", "Lemon", "Mango", "Orange", "Pineapple", "Strawberry", "Watermelon"}

-- Create the search bar text field
local searchBar = native.newTextField( display.contentCenterX, 200, 280, 36 )
searchBar.placeholder = "Search for a fruit"

-- Create a group to hold the autocomplete suggestions
local autocompleteGroup = display.newGroup()

-- Function to handle changes to the search bar input
local function onSearchBarInput( event )
  -- Get the search query from the text field
  local searchQuery = event.target.text
  
  -- Clear the autocomplete suggestions
  autocompleteGroup:removeSelf()
  autocompleteGroup = display.newGroup()

  -- If the search query is not empty
  if string.len(searchQuery) > 0 then
    -- Loop through the search suggestions and add relevant suggestions to the autocomplete group
    local numSuggestions = 0
    for i = 1, #searchSuggestions do
      local suggestion = searchSuggestions[i]
      if string.sub(suggestion, 1, string.len(searchQuery)):lower() == searchQuery:lower() then
        numSuggestions = numSuggestions + 1
        if numSuggestions <= 3 then
          local suggestionText = display.newText({
            text = suggestion,
            x = searchBar.x,
            y = searchBar.y + 36 + 14 + 36 * (numSuggestions - 1),
            width = searchBar.width,
            height = 36,
            align = "left",
            font = native.systemFont,
            fontSize = 14
          })
          suggestionText:setFillColor(0.2, 0.2, 0.2)
          autocompleteGroup:insert(suggestionText)
          suggestionText.isSelectable = true
        end
      end
    end
  end
end

-- Function to handle selection of a search suggestion
local function onSuggestionSelected( event )
  -- Set the text field value to the selected suggestion
  searchBar.text = event.target.text

  -- Clear the autocomplete suggestions
  autocompleteGroup:removeSelf()
  autocompleteGroup = display.newGroup()
  
  -- Hide the device keyboard
  native.setKeyboardFocus( nil )
end

-- Add event listeners to the search bar and autocomplete suggestions
searchBar:addEventListener("userInput", onSearchBarInput)
autocompleteGroup:addEventListener("tap", onSuggestionSelected)

  end
return myCodeFunction
