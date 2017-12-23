'**********************************************************************************
'Script Name: KnockKnockJokeGame.bas (The Knock Knock Joke Game)
'Version: 1.0
'Author: Thanh Ngo
'Date: 12/22/2018

'Description: This just BASIC game displays a series of interactiive
'             Knock Knock jokes.
'
'***********************************************************************************
'Disable the default display of the main window
nomainwin

'Begin telling the first knock knock joke
'Define the default response for the opening prompt     
prompt "Knock Knock Joke Game" + chr$(13) + "Knock Knock!"; response$

'Evaluate the player's response
if response$ = "" then 'No data was entered or the player clicked on Cancel

'Display an error message
    notice "Knock Knock Joke Game" + chr$(13) + _
     "Error: You must respond by entering 'Who is there?'"
     
else 'Continue telling the joke
    'Define the default response for the second prompt
    response$ = "Butter who?" 'assigns a text statement to a variable named "response$", and a value is "Butter who?"
    
    'Display the follow-up prompt for the second joke
    prompt "Knock Knock Joke Game" + chr$(13) + "Butter!"; response$

'Evaluate the player's response
    if response$ = "" then 'No data was entered or cancel was clicked
    
        'Display an error message
        notice "Knock Knock Joke Game" + chr$(13) + _
         "Error: You must respond by entering 'Butter who?'"
    else 'Finish telling the joke
    
      'Display the joke's punch line
      notice "Knock Knock Joke Game" + chr$(13) + _
         "You butter move on to the next joke."
    end if
end if
end
