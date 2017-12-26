' ***************************************************************************
'
' Script Name:  TicTacToe.bas (The Tic Tac Toe Game)
' Version:      1.0
' Author:       Thanh Ngo
' Date:         December 26, 2018
'
' Description:  This game is a Just BASIC implementation of the classic
'               children's Tic Tac Toe game. This game pits two players
'               against one another to see who can line up three
'               consecutive characters in a row
'
' ***************************************************************************

nomainwin   'Suppress the display of the default text window

'Assign default values to global varaibles
global currentPlayer$, noMoves
global a1$, a2$, a3$, b1$, b2$, b3$, c1$, c2$, c3$

currentPlayer$ = "X"    'Player X always starts off each game
call ManageGamePlay     'Call the subroutine responsible for managing game play

wait                    'Pause the application and wait for the player's instruction

'This subroutine displays the game board and controls interaction  with the
'player
sub ManageGamePlay
    WindowWidth = 400       'Set the width of the window to 500 pixels
    WindowHeight = 500      'Set the height of the window to 500 pixels

    loadbmp "_", "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp"   'Load the specified bitmap
                                                                                          'file into memory
    loadbmp "O", "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\O.bmp"                'Load the specified bitmap
                                                                                          'file into memory
    loadbmp "X", "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\X.bmp"                'Load he specified bitmap
                                                                                          'file into memory

    'Define the format of statictext controls dispalyed on the window
    statictext #play.statictext1, "T I C  T A C  T O E", 45, 20, 440, 30
    statictext #play.statictext2, "Copyright 2018", 265, 55, 80, 20

    'Add nine bmpbutton controls representing the game board to the window

    'First column
    bmpbutton #play.a1, "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp", ProcessMove, UL, 45, 90
    bmpbutton #play.a2, "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp", ProcessMove, UL, 150, 90
    bmpbutton #play.a3, "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp", ProcessMove, UL, 255, 90

    'Second column
    bmpbutton #play.b1, "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp", ProcessMove, UL, 45, 194
    bmpbutton #play.b2, "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp", ProcessMove, UL, 150, 194
    bmpbutton #play.b3, "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp", ProcessMove, UL, 255, 194

    'Third column
    bmpbutton #play.c1, "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp", ProcessMove, UL, 45, 298
    bmpbutton #play.c2, "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp", ProcessMove, UL, 150, 298
    bmpbutton #play.c3, "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\_.bmp", ProcessMove, UL, 255, 298

    'Add the game's button control to the window
    button #play.button1 "Start New Game", ResetGameBoard, UL, _
        147, 420, 100, 30

    'Open the window with no frame and a handle of #play
    open "Tic Tac Toe" for window_nf as #play

    'Set up the trapclose event for the window
    print #play, "trapclose ClosePlay"

    'Set the font type, size and attributes
    print #play.statictext1, "!font Arial 24 bold"

    print #play.button1, "!setfocus";   'Set focus to the button control

    wait        'Pause the application and wait for the player's instruction
end sub

'This subroutine processes player moves, deciding when moves are
'valid and invalid and assigning game board squares accordingly
sub ProcessMove handle$
    'Set up a select case code block to process player moves
    select case handle$
        case "#play.a1"          'The player selects the 1st square on the 1st row
            if a1$ = "" then     'Let the player have the square if its available
                a1$ = currentPlayer$    'Assign the squre to the current player
                print #play.a1, "bitmap " + currentPlayer$  'Display bitmap image
             else
                notice "Sorry, but this square if alreadly assigned. Try again!"
                exit sub     'There is no need to keep going so exit the subroutine
             end if
        case "#play.a2"     'The player selects the 2nd square on the 1st row
            if a2$ = "" then 'Let the player have the square if its availale
                a2$ = currentPlayer$    'Assign the square to the current player
                print #play.a2, "bitmap" + currentPlayer$   'Display bitmap image
            else
                notice "Sorry, but this square is already assigned. Try again!"
                exit sub    'There is no need to keep going so exit the subroutine
            end if

        case "#play.a3"     'The player selects the 3rd square on the 1st row
            if a3$ = "" then 'Let the player have the square if its available
                a3$ = currentPlayer$    'Assign the square to the current player
                print #play.a3, "bitmap " + currentPlayer$  'Display bitmap image
            else
                notice "Sorry, but this square is already assigned. Try again!"
                exit sub    'There is no need to keep going so exit the subroutine
            end if
        case "#play.b1" 'The player selects the 1st square on the 2nd row
            if b1$ = "" then 'Let the player have the square if its available
                b1$ = currentPlayer$ 'Assign the square to the current player
                print #play.b1, "bitmap " + currentPlayer$  'Display bitmap image
            else
                notice "Sorry, but this square is already assigned. Try again!"
                exit sub      'There is no need to keep going so exit the subroutine
            end if
        case "#play.b2" 'The player selects the 2nd square on the 2nd row
            if b2$ = "" then 'Let the player have the square if its available
                b2$ = currentPlayer$ 'Assign the square to the current player
                print #play.b2, "bitmap " + currentPlayer$  'Display bitmap image
            else
                notice "Sorry, but this square is already assigned. Try again!"
                exit sub      'There is no need to keep going so exit the subroutine
            end if
        case "#play.b3" 'The player selects the 3rd square on the 2nd row
            if b3$ = "" then 'Let the player have the square if its available
                b3$ = currentPlayer$ 'Assign the square to the current player
                print #play.b3, "bitmap " + currentPlayer$  'Display bitmap image
            else
                notice "Sorry, but this square is already assigned. Try again!"
                exit sub      'There is no need to keep going so exit the subroutine
            end if
        case "#play.c1" 'The player selects the 1st square on the 3rd row
            if c1$ = "" then 'Let the player have the square if its available
                c1$ = currentPlayer$ 'Assign the square to the current player
                print #play.c1, "bitmap " + currentPlayer$  'Display bitmap image
            else
                notice "Sorry, but this square is already assigned. Try again!"
                exit sub      'There is no need to keep going so exit the subroutine
            end if
        case "#play.c2" 'The player selects the 2nd square on the 3rd row
            if c2$ = "" then 'Let the player have the square if its available
                c2$ = currentPlayer$ 'Assign the square to the current player
                print #play.c2, "bitmap " + currentPlayer$  'Display bitmap image
            else
                notice "Sorry, but this square is already assigned. Try again!"
                exit sub      'There is no need to keep going so exit the subroutine
            end if
        case "#play.c3" 'The player selects the 3rd square on the 3rd row
            if c3$ = "" then 'Let the player have the square if its available
                c3$ = currentPlayer$ 'Assign the square to the current player
                print #play.c3, "bitmap " + currentPlayer$  'Display bitmap image
            else
                notice "Sorry, but this square is already assigned. Try again!"
                exit sub      'There is no need to keep going so exit the subroutine
            end if
    end select
    noMoves = noMoves + 1   'Increment the variable representing the number of
                            'moves made so far in this game
    'Call the subroutine responsible for determining when the game is over
    call LookForEndOfGame
    'Call the subroutine responsible for controlling whose turn it is
    call SwitchPlayerTurn
end sub

'This subroutine is responsible for switching between Player X and
'Player O's turns
sub SwitchPlayerTurn
    'If Player X just went then it is Player O's turn
    if currentPlayer$ = "X" then
        currentPlayer$ = "O" 'Make Player O the current player
        exit sub    'There is no need to keep going so exit the subroutine
    end if

    'If Player O just went then it is Player X's turn
    if currentPalyer$ = "O" then
        currentPlayer$ = "X" 'Make Player X the current player
        exit sub    'There is no need to keep going so exit the subroutine
    end if
end sub

'This subroutine is called at the end of each player's turn and is
'responsible for determining if the game is over
sub LookForEndOfGame
    'Look horizontally for a winner
    'Check the first column
    if(a2$ = currentPlayer$) and (a2$ = currentPlayer$) and _
        (a3$ = currentPlayer$) then
        notice "Player " + currentPlayer$ + " has won!"
        exit sub 'There is no need to keep going so exit the subroutine
    end if

    'Check the second column
    if(b1$ = currentPlayer$) and (b2$ = currentPlayer$) and _
        (b3$ = currentPlayer$) then
        notice "Player " + currentPlayer$ + " has won!"
        exit sub    'There is no need to keep going so exit the subroutine
    end if

    'Check the third column
    if(c1$ = currenPlayer$) and (c2$ = currentPlayer$) and _
        (c3$ = currentPlayer$) then
        notice "Player " + currentPlayer$ + " has won!"
        exit sub    'There is no need to keep going so exit the subroutine
    end if

    'Look vertically for a winner
    'Check the first row
    if(a1$ = currentPlayer$) and (b1$ = currentPlayer$) and _
        (c1$ = currentPlayer$) then
        notice "Player " + currentPlayer$ + " has won!"
        exit sub    'There is no need to keep going so exit the subroutine
    end if

    'Check the second row
    if(a2$ = currentPlayer$) and (b2$ = currentPlayer$) and _
        (c2$ = currentPlayer$) then
        notice "Player " + currentPlayer$ + " has won!"
        exit sub    'There is no need to keep going so exit the subroutine
    end if

    'Check the third row
    if(a3$ = currentPlayer$) and (b3$ = currentPlayer$) and _
        (c3$ = currentPlayer$) then
        notice "Player " + currentPlayer$ + " has won!"
        exit sub    'There is no need to keep going so exit the subroutine
    end if

    'Look diagonally for a winner
    'Check from the top-left corner down to the lower-right corner
    if(a1$ = currentPlayer$) and (b2$ = currentPlayer$) and _
        (c3$ = currentPlayer$)then
        notice "Player " + currentPlayer$ + " has won!"
        exit sub 'There is no need to keep going so exit the subroutine
    end if

    'If neither player has won and all squares have been chosen the game
    'ends in a tie
    if noMoves = 9 then
        notice "Tie. There was no winner this time!"
    end if
end sub

'This subroutine resets the game board and global variables in order to
'ready the game for a new round of play
sub ResetGameBoard handle$
    'Display a blank bitmap image in each game board square
    print #play.a1, "bitmap _"
    print #play.a2, "bitmap _"
    print #play.a3, "bitmap _"

    print #play.b1, "bitmap _"
    print #play.b2, "bitmap _"
    print #play.b3, "bitmap _"

    print #play.c1, "bitmap _"
    print #play.c2, "bitmap _"
    print #play.c3, "bitmap _"

    'Clear out any game board square assignments
    a1$ = ""
    a2$ = ""
    a3$ = ""

    b1$ = ""
    b2$ = ""
    b3$ = ""

    c1$ = ""
    c2$ = ""
    c3$ = ""

    noMoves = 0 'Reset the variable used to keep track of the total number
                'of moves made per game to zero

    currentPlayer$ = "X" 'Set Player X as the current player
end sub

'This subroutine is called when the player closes the #play window
'and is responsible for ending the game
sub ClosePlay handle$
    'Get confirmation before terminating program execution
    confirm "Are you sure you want to quit?"; answer$

    if answer$ = "yes" then 'The player clicked on Yes
        close #play 'Close the #play window
        end 'Terminate the game
    end if
end sub
