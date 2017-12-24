' *********************************************************************************************
'
' Script Name: AskMustafa.bas (The Ask Mustafa Game)
' Version:     1.0
' Author:      Thanh Ngo
' Date:        December 23, 2018
'
' Description: In this Just BASIC game the player is challenged to
'              interrogate Doctor Evil's evil assistant Mustafa in order to
'              determine the location of the doctor.
'
' *********************************************************************************************

nomainwin 'Suppress the display of the default text window

'Define two global variables to keep track of player guesses
global previousSelection$, consecutiveGuesses

WindowWidth = 600 'Set the width of the application windows to 600 pixels
WindowHeight = 480 'Set the height of the application windows to 480 pixels

BackgroundColor$ = "white" 'Set the window's background color to white
ForegroundColor$ = "black" 'Set the window's foreground color to black

'Use variables to store text strings displayed in the window

IntroMsg1$ = "A S K   M U S T A F A"
IntroMsg2$ = "Copyright 2018"
IntroMsg3$ = "Welcome to the Ask Mustafa game. In this game, you play" _
    + "the role of a secret agent who has captured Mustafa, an evil doer " _
    + "employed by Doctor Evil for the purpose of taking over and ruling " _
    + "the world. Your task is to interrogate Mustafa and get him to tell " _
    + "you where Doctor Evil is hiding."

'Define the format of statictext controls displayed on the window
statictext #main.statictext1, IntroMsg1$, 135, 50, 330, 21
statictext #main.statictext2, IntroMsg2$, 380, 90, 300, 14
statictext #main.statictext3, IntroMsg3$, 100, 180, 400, 100

'Define the format of button controls displayed on the window
button #main.button " Play ", PrepareGame, UL, 220, 360
button #main.button " Quit ", CloseMain, UL, 305, 360

'Open the window with no frame and handle of #main
open "Ask Mustafa" for window_nf as #main

'Set the font type, Size, and properties for each of the static controls
print #main.statictext1, "!font Arial 24 bold"
print #main.statictext2, "!font Arial 8"
print #main.statictext3, "!font Arial 12"

'Pause the application to wait for the player's instruction
wait

'This subroutine is called when the Play button is clicked and is
'responsible for starting gameplay
sub PrepareGame handle$
    close #main 'Close the #main window
    call PlayGame 'Switch to the [PlayGame] static handle
end sub

'When called, this subroutine closes the application's #main window
sub CloseMain handle$
    close #main
end sub

'This subroutine accepts player guesses and displays Mustafa's answers
sub PlayGame
    WindowWidth = 600 'Set the width of the window to 600 pixels
    WindowHight = 480 'Set the height of the window to 480 pixels

    BackgroundColor$ = "White" 'Set the window's background color to white
    ForegroundColor$ = "Black" 'Set the window's foreground color to black

    'The following array contains a list of questions that the player can ask
    'Mustafa to answer
    questions$(0) = "Where is Dr. Evil?"
    questions$(1) = "Can you give me directions to Dr. Evil's lair?"
    questions$(2) = "So, have you seen Mini-Me lately?"
    questions$(3) = "I want to build an evil headquarters. Where's a " _
        + "good spot?"
    questions$(4) = "I found Dr. Evil's wallet. What address should I " _
        + "mail it to?"
    questions$(5) = "Dr. Evil ordered a pizza. Where should I deliver it?"

    loadbmp "copyimage", "C:\Users\Thanh Ngo\Desktop\Just Basic Programming\hat.bmp" 'Load the specified bitmap
                                             'file into memory

    'Add a graphicbox control to the #play window
    graphicbox #play.gbox, 340, 20, 216, 216

    'Use variables to store text strings displayed in the window
    Instructions1$ = chr$(34) + "It does not matter what you ask me! I " _
        + "will tell you nothing, you impudent son of a goat!" + chr$(13) _
        + chr$(13) + "I can withstand hours of interrogation without" _
        + " breaking a sweat." + chr$(13) + chr$(13) + "Go ahead, ask me" _
        + " your questions, you won't get any information from me." + chr$(34)
    Instructions2$ = "Select a question:"
    Instructions3$ = "Mustafa's Answer:"

    'Define the format of statictext controls displayed on the window
    statictext #play.statictext4 Instructions1$, 20, 40, 280, 170
    statictext #play.staictext5 Instructions2$, 20, 260, 280, 14
    statictext #play.statictext6 Instructions3$, 330, 260, 280, 14

    'Add a listbox control to the #play windows and load the contents of
    'the questions$() array into it
    listbox #play.listbox, questions$(), doubleClick, 20, 280, 300, 80

    'Define the format of button controls displayed on the window
    button #play.button1 " Hint ", GetHint, UL 220, 380
    button #play.button2 " Quit ", ClosePlay, UL, 305, 380

    'Add a texteditor control to the #play window (used to display Mustafa's
    'answers)
    texteditor #play.texteditor, 330, 280, 240, 80

    'Open the window with no frame and a handle of #play
    open "Ask Mustafa" for window_nf as #play

    'Set the font type and size for the specified statictext control
    print #play.statictext4, "!font Arial 12"

    'Use the flush command to prevent the contents of the graphicbox control
    'from being overwritten when the window is first generated
    print #play.gbox, "flush"

    'Display the pre-loaded bitmap image in the graphicbox control
    print #play.gbox, "drawbmp copyimage 1 1"

    'Use the flush command to prevent the contents of the graphicbox control
    'from being overwritten if the user opens or moves another window on top
    'of the #play window
    print #play.gbox, "flush"

    'Pause the application to wait for the player's instruction
    wait
end sub

'This subroutine processes player questions and generates Mustafa's
'answers
sub doubleClick handle$

    'Retrieve the question selected by the player
    #play.listbox "selection? choice$"

    'check to see if this is the first time in a row that this question has
    'been asked
    if previousSelection$ <> choice$ then

        print #play.texteditor, "!cls" 'Clear the texteditor control

        'Display the specified answer
        print #play.texteditor, "Stop asking questions. I don't know anything!"

        consecutiveGuesses = 1 'Reset the variable used to keep track of
                               'consecutively asked questions to 1

    else 'The question has been asked at least twice in a row
        print #play.texteditor, "!cls" 'Clear the texteditor control
        'Display the specified answer

        print #play.texteditor, "Your questions are making my head hurt. " _
            + chr$(13) + "I beg you to stop!"
        consecutiveGuesses = consecutiveGuesses + 1 'Increment the variable
                                                    'used to keep track of
                                                    'consecutively asked
                                                    'questions by 1

    if consecutiveGuesses = 3 then 'The player has asked the same quesstion
                                   '3 times in a row

        print #play.texteditor, "!cls" 'Clear the texteditor control

        'Display the specified answer
        print #play.texteditor, "All right, I can't take it anymore! Dr. " _
        + "Evil " + chr$(13) + "is on Evil Island. 50 miles east of the New " _
        + "Jersey" + chr$(13) + "coast. Please leave me alone with my shame."
    end if
end if

previousSelection$ = choice$ 'Save the player's choice so that it can
                             'be compared against when the player
                             'makes a new guess
wait
end sub

'This subroutine is called when the player clicks on the Hint button
sub GetHint handle$

    'Get confirmation before displaying a hint
    confirm "Hints are for wimps! Are you sure you want one?"; answer$

    if answer$ = "yes" then 'The player clicked on Yes

        'Display the hint
        notice "Ask Mustafa" + chr$(13) + "Mustafa hates repetition. Ask " _
            + "him the same question over again and he'll start giving you " _
            + "the information you want."
    end if
end sub

'This subroutine is called when the Quit button is clicked and is
'responsible for closing the #play window and ending the game
sub ClosePlay handle$
    close #play
    end
end sub
