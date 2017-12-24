' ************************************************************************************
'
' Script Name: RockPaperScissors.bas (The Rock, Paper, Scissors Game)
' Version:     1.0
' Author:      Thanh Ngo
' Date:        December 23, 2018
'
' Description: This game is a Just BASIC version of the classic children's
'               Rock, Paper, Scissors game.
'
' ************************************************************************************

nomainwin 'Suppress the display of the default text window

'Declare three global variables used to keep track of game statistics
global wins, losses, ties

WindowWidth = 500 'Set the width of the window to 500 pixels
WindowHeight = 480 'Set the height of the window to 480 pixels

'The following array contains a list of valid game moves that will be
'displayed in the game's combobox control
moves$(0) = "Rock"
moves$(1) = "Paper"
moves$(2) = "Scissors"

'Load rock, paper, and scissors bitmap files into memory
loadbmp "rockImage", "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\rock.bmp"
loadbmp "paperImage", "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\paper.bmp"
loadbmp "scissorsImage", "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\scissor.bmp"

'Add a graphicbox controls in order to graphically represent the player's
'and computer's moves
graphicbox #play.gboxPlayer, 45, 70, 144, 144
graphicbox #play.gboxComputer, 300, 70, 144, 144

'Use variables to store text strings displayed in the window
Instructions1$ = "Player:"
Instructions2$ = "Computer:"
Instructions3$ = "Select a Move:"
Instructions4$ = "Computer Move:"

'Define the format of statictext controls displayed on the window
statictext #play.statictext1, Instructions1$, 90, 40, 80, 20
statictext #play.statictext2, Instructions2$, 335, 40, 80, 20
statictext #play.statictext3, Instructions3$, 20, 260, 80, 20
statictext #play.statictext4, Instructions4$, 270, 260, 80, 20

'Add a combobox control to the window and load the contents of the
'moves$() array into it
combobox #play.combobox, moves$(), doubleClick, 20, 280, 200, 80

'Add a button control to the window
button #play.button1 "Go", PlayHand, UL, 70, 345, 100, 50

'Add a textbox control to the window (to display the computer's move)
textbox #play.textbox, 270, 280, 200, 22

'Add a groupbox control to the window (to group a collection of
'textbox controls)
groupbox #play.groupbox, "Game Statistics:", 270, 310, 200, 105

'Define the format of statictext controls displayed inside the groupbox
'control
statictext #play.statictext5, "Player Wins:", 285, 330, 70, 14
statictext #play.statictext6, "Player Losses:", 285, 360, 70, 14
statictext #play.statictext7, "Ties:", 285, 390, 70, 14

'Add three textbox controls and place them inside the groupbox control
textbox #play.textbox2, 365, 325, 90, 22
textbox #play.textbox3, 365, 355, 90, 22
textbox #play.textbox4, 365, 385, 90, 22

'Open the window with no frame and a handle of #play
open "Rock, Paper, Scissors" for window_nf as #play

'Set up the trapclose event for the window
print #play, "trapclose ClosePlay"

'Disable the button control to prevent the player from clicking on it
'until the player has selected a valid move
print #play.button1, "!disable"

'Set the font type and size for the specified statictext controls
print #play.statictext1, "!font Arial 12" 'Player label
print #play.statictext2, "!font Arial 12" 'Computer label

'Pause the application to wait for the player's instruction
wait

'This subroutine enables the button control labeled Go when whenever the
'player selects a valid move
sub doubleClick handle$
    'Enable the game's button control
    print #play.button1, "!enable"
end sub

'This subroutine is called when the player clicks on the Go button
sub PlayHand handle$
    'Retrieve the player's move
    #play.combobox "selection? playerMove$"

    'Use the flush command to prevent graphic images from being overridden
    print #play.gboxPlayer, "flush"
    print #play.gboxComputer, "flush"

    'Display a bitmap image representing the player's move
    if playerMove$ = "Rock" then
        print #play.gboxPlayer, "drawbmp rockImage 1 1"
    end if

    if playerMove$ = "Paper" then
        print #play.gboxPlayer, "drawbmp paperImage 1 1"
    end if

    if playerMove$ = "Scissors" then
        print #play.gboxPlayer, "drawbmp scissorsImage 1 1"
    end if

    'Use the rnd() function to retrieve a random number between 1 and 3 and
    'assign the result to a variable named RandomNumber
    RandomNumber = int(rnd(1)*3) + 1

    'Select the computer's move based on the value assigned to the
    'RandomNumber variable and display the appropriate bitmap image
    if RandomNumber = 1 then
        computerMove$ = "Rock"
        print #play.gboxComputer, "drawbmp rockImage 1 1"
    end if

    if RandomNumber = 2 then
        computerMove$ = "Paper"
        print #play.gboxComputer, "drawbmp paperImage 1 1"
    end if

    if RandomNumber = 3 then
        computerMove$ = "Scissors"
        print #play.gboxComputer, "drawbmp scissorsImage 1 1"
    end if

    'Use the flush command to prevent graphic images from being overridden
    print #play.gboxPlayer, "flush"
    print #play.gboxComputer, "flush"

    'Display a text string identifying the computer's move in the textbox
    'control
    print #play.textbox, computerMove$

    'See who won if the player picked Rock
    if playerMove$ = "Rock" then
        select case
        case computerMove$ = "Rock"
            result$ = "Tie!"
            ties = ties + 1
            print #play.textbox4, ties
        case computerMove$ = "Paper"
            result$ = "The computer wins!"
            losses = losses + 1
            print #play.textbox3, losses
        case computerMove$ = "Scissors"
            result$ = "The player wins!"
            wins = wins + 1
            print #play.textbox2, wins
        end select
    end if

    'See who won if the player picked Paper
    if playerMove$ = "Paper" then
        select case
        case computerMove$ = "Rock"
            result$ = "The player wins!"
            wins = wins + 1
            print #play.textbox2, wins
        case computerMove$ = "Paper"
            result$ = "Tie!"
            ties = ties + 1
            print #play.textbox4, ties
        case computerMove$ = "Scissors"
            result$ = "The computer wins!"
            losses = losses + 1
            print #play.textbox3, losses
        end select
    end if

    'See who won if the player picked Scissors
    if playerMove$ = "Scissors" then
        select case
        case computerMove$ = "Rock"
            result$ = "The computer wins!"
            losses = losses + 1
            print #play.textbox3, losses
        case computerMove$ = "Paper"
            result$ = "The player wins!"
            wins = wins + 1
            print #play.textbox2, wins
        case computerMove$ = "Scissors"
            result$ = "Ties!"
            ties = ties + 1
            print #play.textbox4, ties
        end select
    end if

    'Announce the winner
    notice "Rock, Paper, Scissors" + chr$(13) + result$
    print #play.button1, "!disable" 'Disable the button labeled Go
    print #play.combobox, "selectindex 0" 'Clear out the previous move
end sub

'This subroutine is called when the player closes the #play window
'and is responsible for ending the game
sub ClosePlay handle$
    'Get confirmation before terminating program execution
    confirm "Are you sure you want to quit?"; answer$

    if answer$ = "yes" then 'Then player clicked on Yes
        close #play 'Close the #play window
        end 'Terminate the game
    end if
end sub
