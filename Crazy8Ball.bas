'*************************************************************************************
'
' Script Name: Crazy8Ball.bas (The BASIC Crazy 8 Ball Game)
' Version:     1.0
' Author:      Thanh Ngo
' Date:        December 17, 2018
'
' Description: This Just BASIC game imitates a Crazy 8 fortune telling
'              ball
'
'*************************************************************************************

nomainwin 'Suppress the display of the default text window

WindowWidth = 500 'Set the width of all application windows to 500 pixels
WindowHeight = 400

BackgroungColor$ = "Black" 'Set the window's background color to black
ForegroundColor$ = "Blue" 'Set the window's background color to yellow

'Use variables to store text strings displayed in the window
IntroMsg1$ = "WELCOME TO THE CRAZY 8 BALL"
IntroMsg2$ = "FORTUNE TELLING GAME"
IntroMsg3$ = "Copyright 2018"
IntroMsg4$ = "Thanh Ngo"

'Define the format of statictext controls displayed on the window
statictext #main.statictext, IntroMsg1$, 120, 50, 300, 14
statictext #main.statictext, IntroMsg2$, 147, 80, 300, 14
statictext #main.statictext, IntroMsg3$, 210, 160, 300, 14
statictext #main.statictext, IntroMsg4$, 204, 190, 300, 13

'Define the format of button controls displayed on the window
button #main.button " Play ", [PrepareGame], UL, 174, 300
button #main.button " Quit ", [CloseMain], UL, 260, 300

'Open the window with no frame and a handle of #main
open "BASIC Crazy 8 Ball" for window_nf as #main

'Pause the application to wait for the player's instruction
Wait

'This static handle is executed when the player clicks on the button
'control labeled Play located on the #main window. It closes the
'#main window and initiates game play by switching to the [PlayGame}
'static handler
[PrepareGame]

close#main 'Close the #main window
goto [PlayGame] 'Switch to the [PlayGame] static handler

'This static handle is executed when the player clicks on the button
'control labeled Quit. It closes the #main window and then terminates
'the execution of the game
[CloseMain]

close #main
end

'When executed, this static handler displays a window that collectts the
'player's question.
[PlayGame]

BackgroundColor$ = "White" 'Set the window's background color to white
ForegroundColor$ = "Black" 'Set the window's foreground color to black

'Use variables to store text strings displayed in the window
Instructions1$ = "Type your question in the entry field provided below"
Instructions2$ = "and click on the Ask button to have your fortune told!"

'Define the format of statictext controls displayed on the window
statictext #play.statictext, Instructions1$, 120, 50, 300, 14
statictext #play.statictext, Instructions2$, 116, 80, 300, 14

'Define the format of button controls displayed on the window
button #play.button "  Ask  ", [AskQuestion], UL, 174, 300
button #play.button "  Quit  ", [ClosePlay], UL, 260, 300
textbox #play.textbox 30, 140, 430, 25

'Open the window with no frame and a handle of #play
open "BASIC Crazy 8 Ball" for window_nf as #play

'Set focus on the textbox control
print #play.textbox, "!Setfocus"

'Pause the application to wait for the player's instruction
wait

'This static handler is called from the #play window when the player clicks
'on the Ask button. Its job is to process the player's input and respond
'appropriately.
[AskQuestion]

'Retrieve the text string stored in the textbox control
print #play.textbox, "!contents?"
'Assign the text string to a variable named question$
input #play.textbox, question$
close #play 'Close the #play window

'Displays an error message in the event the player did not enter anything
if question$ = "" then

'Display an error message in a popup dialog
notice "BASIC Crazy 8 Ball" + chr$(13) + _
    "Error: You forgot to type a question!"

    'Switch back to the [PlayGame] handle to allow the player to ask a new
    'question
    goto [PlayGame]

else 'Generate a random answer to the player's question

    'Use the rnd() function to retrieve a random number between 1 and 3 and
    'assign the result to a variable named RandomNumber
    RandomNumber = int(rnd(1)*3) + 1

    'Select an answer based on the value assigned to the RandomNumber
    'variable
    if RandomNumber = 1 then answer$ = "YES"
    if RandomNumber = 2 then answer$ = "MAYBE"
    if RandomNumber = 3 then answer$ = "NO"

    'Display the answer to the player's question in a popup dialog
    notice "BASIC Crazy 8 Ball" + chr$(13) + "The answer is " + _
        answer$ + "."

        'Switch back to the [PlayGame] handle to allow the player to ask a new
        'question
        goto [PlayGame]

    end if

'This static handle is executed when the player clicks on the button
'control labeled Quit. It closes the #play window and then terminates
'the execution of the game
[ClosePlay]

close #play
end
