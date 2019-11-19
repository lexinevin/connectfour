%Connect Four Game, Lexi Nevin
clear
clc
warning off;

%Main Gameplay Code -------------------------------------------
playGame = input("Do you want to play a new game of Connect Four? Enter 0 for no to close the program, and 1 for yes to start a game. Enter Choice: ")
while playGame == 1
 
    % Initialize scene (Provided Code)
    my_scene = simpleGameEngine('ConnectFour.png',86,101);

    % Set up variables to name the various sprites (Modified Provided Code)
    global empty_sprite;
        empty_sprite = 1;
    global red_sprite;
        red_sprite = 2; %player1
    global black_sprite;
        black_sprite = 3; %player2
    global colExists colOpen;
    global runningGame;
    runningGame = 1;
    global currentPlayer;
    currentPlayer = red_sprite;
    
    %loading sounds
    

    % Display empty board (Provided Code)
    global board_display;
        board_display = empty_sprite * ones(6,7);
    drawScene(my_scene,board_display)
  

 while runningGame == 1 
     
    %Player 1 (red chip) Turn
    currentPlayer = red_sprite;
    userInput = input("Player 1 - enter a column between 1 and 7 inclusive. Column Number: ")
    doesColExist(userInput);
    isColOpen(userInput);
    if colExists && colOpen
        fallingChipRed(userInput);
        drawScene(my_scene,board_display)
    else
        tryAgainRed(userInput);
        drawScene(my_scene,board_display)
    end
    
    %Check all possibilities of wins on the board
    horizontalCheck(currentPlayer);
    verticalCheck(currentPlayer);
    %diagonalUpCheck(currentPlayer);
    %diagonalDownCheck(currentPlayer);
    tieGameCheck(currentPlayer);
    runningGame;
    if runningGame == 0
        break
    end
    
    
    %Player 2 (black chip) Turn
    currentPlayer = black_sprite;
    userInput = input("Player 2 - enter a column between 1 and 7 inclusive. Column Number: ")
    doesColExist(userInput);
    isColOpen(userInput);
    if colExists && colOpen
        fallingChipBlack(userInput);
        drawScene(my_scene,board_display)
    else
        tryAgainBlack(userInput);
        drawScene(my_scene,board_display)
    end
    
   %Check all possibilities of wins on the board
    horizontalCheck(currentPlayer);
    verticalCheck(currentPlayer);
    %diagonalUpCheck(currentPlayer);
    %diagonalDownCheck(currentPlayer);
    tieGameCheck(currentPlayer);
    runningGame;
    if runningGame == 0
        break
    end

 end

playAgain() %ask user if they want to start a new game

end %ends while loop for playGame == 1 and quits program

%Functions ----------------------------------------------------------------

%determines if the column exists in the matrix
function doesColExist(userInput)
    global colExists;
    colExists = 0;
        while colExists == 0
            if userInput > 0 && userInput < 8
                colExists = 1;
            else
                userInput = input("That is not a valid column. Please enter a column between 1 and 7 inclusive. Column Number: ")
            end
        end
end

%determines if column is full or not
function isColOpen(userInput)
    global board_display empty_sprite black_sprite red_sprite;
    global colOpen;
    colOpen = 0;
        if board_display(1,userInput) == empty_sprite;
            colOpen = 1;
        else
            colOpen = 0;
        end
end

%causes red chip to fall to the bottom of the column
function fallingChipRed(userInput)
    global board_display empty_sprite black_sprite red_sprite colOpen;
    for i = 6:-1:1
        if board_display(i,userInput) == empty_sprite
            board_display(i,userInput) = red_sprite;
            break
        end
    end
    isColOpen(userInput);
end

%causes black chip to fall to the bottom of the column
function fallingChipBlack(userInput)
    global board_display empty_sprite black_sprite red_sprite colOpen;
    for i = 6:-1:1
        if board_display(i,userInput) == empty_sprite
            board_display(i,userInput) = black_sprite;
            break
        end
    end
    isColOpen(userInput);
end

%if column is full or doesn't exist, have user choose a new column
function tryAgainRed(userInput)
global board_display empty_sprite black_sprite red_sprite colOpen;
    while colOpen == 0
        userInput = input("This columns is unavailable. Please select a different column. Choice:  ")
        doesColExist(userInput);
        isColOpen(userInput);
    end 
    fallingChipRed(userInput);
end

%if column is full or doesn't exist, have user choose a new column
function tryAgainBlack(userInput)
global board_display empty_sprite black_sprite red_sprite colOpen;
    while colOpen == 0
        userInput = input("This columns is unavailable. Please select a different column. Choice:  ")
        doesColExist(userInput);
        isColOpen(userInput);
    end 
    fallingChipBlack(userInput);
end

%Ask user if they want to play a new game after a game has been won or tied
function playAgain()
global  empty_sprite black_sprite red_sprite colOpen;
    playGame = input("Do you want to play a new game of Connect Four? Enter 0 for no to close the program, and 1 for yes to start a game. Enter Choice: ")
    if playGame == 0
        quit        
    end
end

%Check if there are four of the same sprite in a row horizontally
function runningGame = horizontalCheck(currentPlayer)
global  empty_sprite black_sprite red_sprite colOpen currentPlayer board_display runningGame;
    count = 0;
    for x = 1:1:6
        for y = 1:1:5
            if board_display(x,y) == currentPlayer
                count = count + 1;
                if count >= 4
                    runningGame = 0;
                    fprintf("\n******** Player %0.0f wins! ********\n", (currentPlayer - 1))
                return
                end
            else 
                count = 0;
            end
        end
    end
end

%Check if there are four of the same sprite in a column vertically 
function runningGame = verticalCheck(currentPlayer)
global  empty_sprite black_sprite red_sprite colOpen currentPlayer board_display runningGame;
    count = 0;
    for x = 1:1:5
        for y = 1:1:6
            if board_display(y,x) == currentPlayer
                count = count + 1;
                if count >= 4
                    runningGame = 0;
                    fprintf("\n******** Player %0.0f wins! ********\n", (currentPlayer - 1))
                return
                end
            else 
                count = 0;
            end
        end
    end
end

%Check if there are four of the same sprite in a diagonal going from bottom
%left to top right 
function runningGame = diagonalUpCheck(currentPlayer)
global  empty_sprite black_sprite red_sprite colOpen currentPlayer board_display runningGame;
for row = 1:1:3
        for col = 3:1:6
            if (board_display(row,col) == red_sprite) && (board_display(row,col) == board_display(row+1,col-1)) && (board_display(row,col) == board_display(row+2,col-2)) && (board_display(row,col) == board_display(row+3,col-3))
                runningGame = 0;
                fprintf("\n******** Player 1 wins! ********\n")
            elseif (board_display(row,col) == black_sprite) && (board_display(row,col) == board_display(row+1,col-1)) && (board_display(row,col) == board_display(row+2,col-2)) && (board_display(row,col) == board_display(row+3,col-3))
                runningGame = 0;
                fprintf("\n******** Player 2 wins! ********\n")   
            end
        end 
    end
end

%Check if there are four of the same sprite in a diagonal going from top
%left to bottom right
function runningGame = diagonalDownCheck(currentPlayer)
global  empty_sprite black_sprite red_sprite colOpen currentPlayer board_display runningGame;
for row = 1:1:3
        for col = 1:1:4
            if (board_display(row,col) == red_sprite) && (board_display(row,col) == board_display(row+1,col+1)) && (board_display(row,col) == board_display(row+2,col+2)) && (board_display(row,col) == board_display(row+3,col+3))
                runningGame = 0;
                fprintf("\n******** Player 1 wins! ********\n")
            elseif (board_display(row,col) == black_sprite) && (board_display(row,col) == board_display(row+1,col+1)) && (board_display(row,col) == board_display(row+2,col+2)) && (board_display(row,col) == board_display(row+3,col+3))
                runningGame = 0;
                fprintf("\n******** Player 2 wins! ********\n")   
            end
        end 
    end
end

%Checks if board is full with no four of the same chips in a
%row/column/diagonal and declares a tie if so
function runningGame = tieGameCheck(currentPlayer)
global  empty_sprite black_sprite red_sprite colOpen currentPlayer board_display runningGame;
count = 0;
for row = 1:1:6
    for col = 1:1:7
        if board_display(row,col) ~= empty_sprite
            count = count + 1;
            if count >= 42
                    runningGame = 0;
                    fprintf("\n******** Tied Game! ********\n")
                return
            end
                else 
                count = 0;
            end
        end
    end
end