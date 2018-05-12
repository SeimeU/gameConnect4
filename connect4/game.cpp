#include "game.h"

#define ROWS 6
#define COLUMNS 7

game::game()
{
    int col;
    int row;

    for(row = 0; row < ROWS;row++)
    {
        for(col = 0;col < COLUMNS;col++)
        {
            pitch[row][col] = 0;
        }
    }
}

bool game::setStoneGame(int player, char c[])
{
    int col;
    int r;

    col = c[0] - '1';

    for(r = ROWS - 1;r >= 0; r++)
    {
        // "set" the stone in the array
        if(pitch[r][col] == 0)
        {
            // found a free field
            pitch[r][col] = player;
            row = r;
            column = col;

            return true;
        }
    }

    // setting stone not possible
    return false;
}

bool game::won(int player)
{
    int r;
    int c;
    int counter;

    // check the pross
    for(c = 0, counter = 0;c < COLUMNS;c++)
    {
        if(pitch[row][c] == player)
        {
            counter++;

            if(counter == 4)
            {
                return true;
            }
        }
        else
        {
            counter = 0;
        }
    }

    // check the vertical
    for(r = ROWS - 1, counter = 0;r >= 0;r--)
    {
        if(pitch[r][column] == player)
        {
            counter++;

            if(counter == 4)
            {
                return true;
            }
        }
        else
        {
            counter = 0;
        }
    }

    // check the leading diagonal
    for(c = column, r = row;c > 0 && r > 0;c--, r--);

    for(counter = 0; c < COLUMNS && r < ROWS;c++, r++)
    {
        if(pitch[r][c] == player)
        {
            counter++;

            if(counter == 4)
            {
                return true;
            }
        }
        else
        {
            counter = 0;
        }
    }

    // check the minor diagonal
    for(c = column, r = row;c < COLUMNS - 1 && r > 0;c++, r--);

    for(counter = 0; c >= 0 && r < ROWS;c--, r++)
    {
        if(pitch[r][c] == player)
        {
            counter++;

            if(counter == 4)
            {
                return true;
            }
        }
        else
        {
            counter = 0;
        }
    }

    return false;
}

bool game::tied()
{
    int c;

    for(c = 0;c < COLUMNS;c++)
    {
        if(pitch[0][c] == 0)
        {
           return false;
        }
    }

    return true;
}
