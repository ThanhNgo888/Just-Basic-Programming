' *************************************************************************
'
' Script Name: BlackJack.bas (The BASIC BlackJack Game)
' Version:     1.0
' Author:      Thanh Ngo
' Date:        December 25, 2018
'
' Description: This game is a Just BASIC implementation of the BlackJack
'              casino card game which pits the player against the
'              computer (dealer)
'
' *************************************************************************

nomainwin 'Suppress the display of the default text window

global dealerCard, playerCard  'Assign default values to global variables
call DisplaySplash             'Call on the subroutine that displays the game's
                               'splash screen

wait 'Pause the application and wait for the player's instruction

'This subroutine displays a splash screen at game start-up
sub DisplaySplash

    loadbmp "AceImage", "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\Ace.bmp"   'Load the specified bitmap
                                                                                      'file into memory
    loadbmp "JackImage", "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\Jack.bmp" 'Load the specified bitmap
                                                                                      'file into memory

    'Define the format of statictext controls displayed on the window
    statictext #splash.statictext1, "B A S I C  B L A C K J A C K", _
        30, 30, 440,20
    statictext #splash.statictext2, "Copyright 2018", 210, 60, 80, 20

    'Add two graphicbox controls to the #splash window
    graphicbox #splash.gboxAce, 65, 120, 77, 116
    graphicbox #splash.gboxJack, 175, 120, 77, 116

    'Open the window with no frame and a handle of #splash
    open "BASIC BlackJack" for window_nf as #splash

    'Set the font type, size, and attributes
    print #splash.statictext1, "!font Arial 14 bold"

    'Use the flush command to prevent the contents of the graphicbox control
    'from being overwritten when the window is first generated
    print #splash.gboxAce, "flush"
    print #splash.gboxJack, "flush"

    'Display the pre-loaded bitmap images in the graphicbox control
    print #splash.gboxAce, "drawbmp AceImage 1 1"
    print #splash.gboxJack, "drawbmp JackImage 1 1"

    'Use the flush command to prevent the contents of the graphicbox controls
    'from begin overwritten if the user opens or moves another window on top
    'of the #splash window
    print #splash.gboxAce, "flush"
    print #splash.gboxJack, "flush"

    'Wait 4 thousand milliseconds (4 seconds) and then call upon the
    'subroutine that closes the game's splash screen
    timer 4000, CloseSplashWindow

end sub

'This subroutine closes the game's splash screen window
sub CloseSplashWindow
    timer 0        'Turn the timer off
    close #splash  'Close the #splash window
    call ManageGamePlay   'Call on the subroutine that manages game play
end sub

'This subroutine displays the game board and controls interaction with the
'player
sub ManageGamePlay

    WindowWidth = 400  'Set the width of the window to 500 pixels
    WindowHeight = 400 'Set the height of the window to 500 pixels

    'Define the format of statictext controls displayed on the window
    statictext #play.statictext1, " B A S I C  B L A C K J A C K",  _
        30,20,440,30
    statictext #play.statictext2, "Copyright 2018", 285, 50, 80, 20
    statictext #play.statictext3, "Players's Hand", 50, 110, 70, 20
    statictext #play.statictext4, "Dealer's Hand", 270, 110, 70, 20

    'Define textbox control that will be used to display data
    textbox #play.textbox1, 50, 140, 70, 50
    textbox #play.textbox2, 270, 140, 70, 50
    textbox #play.textbox3, 50, 280, 290, 50

    'Add button controls to the window
    button #play.button1 "Hit Me!", DealCard, UL, 30, 210, 50, 30
    button #play.button2 "Stay!", DealerTurn, UL, 90, 210, 50, 30
    button #play.button3 "Play Again", RestartGame, UL, 270, 210, 70, 30

    'Open the window with no frame and a handle of #play
    open "BASIC BlackJack" for window_nf as #play

    'Set up the trapclose event for the window
    print #play, "trapclose ClosePlay"

    Call DealOpeningHand 'Call the subroutine that deals the player's and
                         'dealer's initial hands

    'Set the font type, size, and attributes
    print #play.statictext1, "!font Arial 18 bold"
    print #play.textbox1, "!font Arial 24 bold"
    print #play.textbox2, "!font Arial 24 bold"
    print #play.textbox3, "!font Arial 24 bold"

    print #play.button1, "!setfocus"; 'Set focus to the Hit Me! button
    print #play.button3, "!disable" 'Disable the Play Again button

    'Pause the application and wait for the player's instruction
    wait
end sub

'This subroutine is called when the player clicks on the Hit Me! button
sub DealCard handle$
    'Add another card to the player's hand
    playerCard = playerCard + GetRandomNumber()

    'The player busts if his hand exceeds 21
    if playerCard > 21 then
        print #play.textbox1, playerCard          'Display the player's card
        print #play.textbox3, "You have busted!"  'Display a summary of the
                                                  'results

        print #play.button1, "!disable"     'Disable the Hit Me! button
        print #play.button2, "!disable"     'Disable the Stay! button
        print #play.button3, "!enable"      'Disable the New Game button
    else
        print #play.textbox1, playerCard    'Display the player's card
    end if
end sub

'This subroutine manages the dealer's turn
sub DealerTurn handle$
    print #play.button1, "!disable"     'Disable the Hit Me! button
    print #play.button2, "!disable"     'Disable the Stay! button
    print #play.button3, "!enable"      'Disable the New Game button

do

    'Add another card to the dealer's hand
    dealerCard = dealerCard + GetRandomNumber()

    print #play.textbox2, dealerCard 'Display the player's card

    'The dealer busts if its hand exceeds 21
    if dealerCard > 21 then

        print #play.textbox3, "The dealer busts!" 'Display a summary of the
                                                  'results

        exit sub 'Exit out of the subroutine
    end if

    loop while dealerCard < 17 'Keep looping as long as the dealer's hand
                               'is less than 17

    'Analyze the results of the game once both the player and dealer have
    'rested
    if playCard = dealerCard then 'Check for a tie
        print #play.textbox3, "Tie!"
    end if

    if playCard < dealerCard then 'See if the dealer has won
        print #play.textbox3, "You lose!"
    end if

    if playerCard > dealerCard then 'See if the player has won
        print #play.textbox3, "You win!"
    end if
end sub

'This subroutine gets the game ready to play a new hand
sub RestartGame handle$
    call ResetGame 'call on the subroutine that resets the game

    print #play.button1, "!enable"  'Disable the Hit Me! button
    print #play.button2, "!enable"  'Disable the Stay! button
    print #play.button3, "!disable" 'Disable the New Game button

    call DealOpeningHand            'Call on the subroutine that deals the player's
                                    'and dealer's opening hand
end sub

'This subroutine deals the player's and dealer's opening hand
sub DealOpeningHand

    playerCard = GetRandomNumber()  'Retrieve the player's first card
    dealerCard = GetRandomNumber()   'Retrieve the dealer's first card

    print #play.textbox1, playerCard  'Display the player's card
    print #play.textbox2, dealerCard  'Display the dealer's card
end sub

'This function generates and returns cards
function GetRandomNumber()

    RandomNumber = int(rnd(1)*13) + 1  'Retrieve a number between 1 and 13

    if RandomNumber = 1 then RandomNumber = 11  'A 1 is converted to 11 (ace)
    if RandomNumber > 10 then RandomNumber = 10 '11, 12, and 13 are equivalent
                                                'to Jacks, Queens, and Kings
                                                'which have a value of 10

    GetRandomNumber = RandomNumber  'Return the selected card
end function

'This subroutine resets the player's and dealer's hand and clears out
'the game board
sub ResetGame
    dealerCard = 0    'Reset the dealer's hand to zero
    playerCard = 0    'Reset the player's hand to zero

    'Clear out the textbox controls on the game board
    print #play.textbox1, ""
    print #play.textbox2, ""
    print #play.textbox3, ""
 end sub

'This subroutine is called when the player closes the #play window
'and is responsible for ending the game
sub ClosePlay handle$
    'Get confirmation before terminating program execution
    confirm "Are you sure you want to quit?"; answer$

    if answer$ = "yes" then     'The player clicked on Yes
        close #play             'Close the #play window
        end                     'Terminate the game
    end if
end sub



