' ************************************************************************
'
' Script Name: GuessMyNumber.bas (The Guess My Number Game)
' Version:     1.0
' Author:      Thanh Ngo
' Date:        December 25, 2018
'
' Description: This game is a Just BASIC number guessing game that
'              challenges players to guess a number between 1 and 100 in
'              as few guesses as possible.
'
' ************************************************************************

nomainwin 'Suppress the display of the default text window

'Declare global variables used to keep track of game statistics
global secretNumber, avgNoGuesses, noOfGamesPlayed, guessCount, helpOpen$

'Assign default values to global variables
secretNumber = 0 'Keeps track of the game's randomly generated number
guessCount = 0   'Keeps track of the total number of guesses made"
avgNoGuesses = 0 'Stores the calculated average number of moves per game
noOfGamesPlayed = 0 'Keeps track of the total number of games played
helpOpen$ = "False" 'Keeps track of when the #help window is open

WindowWidth = 510 'Set the width of the window to 510 pixels
WindowHeight = 500 'Set the height of the window to 500 pixels

ForegroundColor$ = "Darkblue" 'Set the window font color to dark blue

'Define the format of statictext controls displayed on the window
statictext #play.statictext1, " G U E S S   M Y   N U M B E R", _
    30,50,440,40
statictext #play.statictext2, "Copyright 2018", 395, 90, 80, 20
statictext #play.statictext3, "Game Played:", 40, 400, 80, 20
statictext #play.statictext4, "Avg. No. Guesses:", 265, 400, 90, 20
statictext #play.statictext5, "Enter Your Guesses:", 200, 140, 100, 20
statictext #play.statictext6, "Hint:", 42, 300, 30, 20

'Add button controls to the window
button #play.button1 "Guess", AnalyzeGuess, UL, 210, 225, 80, 30
button #play.button2 "Help", DisplayHelp, UL, 400, 318, 70, 25
button #play.button3 "Start Game", StartGame, UL, 400, 288, 70, 25

'Add three textbox controls and place them inside the groupbox control
textbox #play.textbox1, 200, 160, 100, 50
textbox #play.textbox2, 130, 395, 90, 22
textbox #play.textbox3, 370, 395, 90, 22
textbox #play.textbox4, 40, 320, 340, 22

'Open the window with now frame and a handle of #play
open "Guess My Number" for window_nf as #play

'Set up the trapclose event for the window
print #play, "trapclose ClosePlay"

'Display the appropriate variable values in the following textbox controls
print #play.textbox3, avgNoGuesses
print #play.textbox2, noOfGamesPlayed

'Set the font type, size, and properties for each of the static controls
print #play.statictext1, "!font Arial 24 bold"
print #play.statictext2, "!font Arial 8"
print #play.statictext5, "!font Arial 8 bold"
print #play.statictext6, "!font Arail 8 bold"
print #play.textbox1, "!font Arial 24";

print #play.button3, "!setfocus"; 'Set focus to the Start Game button
print #play.button1, "!disable" 'Disable the Guess button
print #play.textbox1, "!disable" 'Disable the input textbox

'Pause the application to wait for the player's instruction
wait

'This subroutine analyzes player guesses and determines when the game
'has been won
sub AnalyzeGuess handle$

    'Retrieve the player's guess and assign it to a variable
    print #play.textbox1, "!contents? playerGuess"
    'Validate that an acceptable value has been entered
    if playerGuess < 1 or playerGuess > 100 then

        'Inform the user that an invalid guess has been made
        print #play.textbox4, "Your guess must be between 1 and 100. Try again."
        print #play.textbox1, "" 'Clear out the input textbox
        print #play.textbox1, "!setfocus"; 'set focus to the input textbox
        exit sub 'Exit the subroutine without processing any remaining
                 'subroutine statements
    end if

    'Determine if the player's guess is too high
    if playerGuess > secretNumber then

        'Increment the variable that tracks the total number of guesses mad
        guessCount = guessCount + 1

        'Inform the user that the guess was too high
        print #play.textbox4, "Your guess was too high. Try again."
        print #play.textbox1, "" 'Clear out the input textbox
        print #play.textbox1, "!setfocus"; 'set focus to the input textbox
        exit sub 'Exit the subroutine without processing any remaining
    end if

    'Determine if the player's guess was correct
    if playerGuess = secretNumber then

        'Let the player know he has won the game
        notice "Guess My Number" + chr$(13) + "Game over! You win!"

        'Increment the variable that tracks the total number of guesses made
        guessCount = guessCount + 1

        'Increment the variable that tracks the total number of games played
        noOfGamesPlayed = noOfGamesPlayed + 1

        'Calculate the average number of guesses per game
        avgNoGuesses = guessCount / noOfGamesPlayed

        'Display the appropriate variable values in the following textbox
        'controls
        print #play.textbox3, avgNoGuesses
        print #play.textbox2, noOfGamesPlayed

        print #play.textbox1, ""         'Clear out the input textbox
        print #play.button3, "!enable"   'Enable the Start Game button
        print #play.button3, "!setfocus";'Set focus to the Start Game button
        print #play.textbox1, "!disable" 'Disable the input textbox
        print #play.button1, "!disable"  'Disable the Guess button
        print #play.textbox4, ""         'Clear out the Hint textbox control

        exit sub   'Exit the subroutine without processing any remaining
                   'subroutine statements
    end if
end sub

'This subroutine is called when the player clicks on the Start Game button
sub StartGame handle$

    'Generate a new random number for the game
    secretNumber = int(rnd(1)*100) + 1

    print #play.button1, "!enable"      'Enable the Guess button
    print #play.textbox1, "!enable"     'Enable the input textbox
    print #play.button3, "!disable"     'Disable the Start Game button
    print #play.textbox1, "!Setfocus";  'Set focus to the input textbox

end sub

'This subroutine is called when the player clicks on the Help button
sub DisplayHelp handle$

    helpOpen$ = "True"   'Identify the #help window as being open

    WindowWidth = 400  'Set the width of the window to 500 pixels
    WindowHeight = 400 'Set the height of the window to 500 pixels

    'Use variables to store text strings displayed in the window
    HelpHeader$ = "Game Instructions"
    helpText1$ = "The object of this game is to guess a randomly generated" _
        + " number in the range of 1 to 100 in as few guesses as possible. " _
        + "To make a guess, type in a number and click on the Guess button. " _
        + "A hint will be provided after each move to assist you in making " _
        + "your next guess. Once you have correctly guessed the game's secret" _
        + " number, a popup message will be displayed."
    helpText2$ = "At the end of each round of play, game statistics are " _
        + "displayed at the bottom of the game window as an indication of " _
        + "your progress."
    'Define the format of statictext controls displayed on the window
    statictext #help.helptext1, HelpHeader$, 30, 40, 140, 20
    statictext #help.helptext2, helpText1$, 30, 70, 330, 80
    statictext #help.helptext3, helpText2$, 30, 160, 330, 50

    'Add button controls to the window
    button #help.button "Close", CloseHelpWindow, UL, 280, 310, 80, 30

    'Open the window with no frame and a handle of #play
    open "Guess My Number Help" for window_nf as #help

    'Set the font type, size, and properties for specified statictext control
    print #help.helptext1, "!font Arial 12 bold"
end sub

'This subroutine is called when the player closes the #help window
sub CloseHelpWindow handle$

helpOpen$ = "False" 'Identify the #help window as being closed
    close #help 'Close the #help window
end sub

'This subroutine is called when the player closes the #play window
'and is responsible for ending the game
sub ClosePlay handle$

    'Get confirmation before terminating program execution
    confirm "Are you sure you want quit?"; answer$

    if answer$ = "yes" then 'The player clicked on Yes
        close #play 'Close the #play window

        'See if the #help window is open and close it if it is
        if helpOpen$ = "True" then

            call CloseHelpWindow "X" 'Close the #help window
        end if

        end 'Terminate the game
    end if
end sub


