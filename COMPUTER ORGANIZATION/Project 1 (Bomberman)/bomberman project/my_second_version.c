#include <stdio.h>

// bomberMan function fills the grid's empty spaces with bombs
void bomberMan(char grid[200][200], int row, int column) {
    printf("BomberMan planting the bombs...\n");
    // Iterate through the grid.
    for(int i = 0; i < row; i++){
        for(int j = 0; j < column; j++){
            // If the current cell is empty, fill it with a bomb.
            if(grid[i][j] == '.') {
                grid[i][j] = 'O';
            }
        }
    }
}
void printGrid(char grid[200][200], int row, int column){
    // Print the grid.
    printf("Grid: \n");
    for(int i = 0; i < row; i++){
        for(int j = 0; j < column; j++){
            printf("%c", grid[i][j]);
        }
        printf("\n");
    }
}
void explodeBombs(char grid1[200][200], char grid2[200][200], int row, int column) {
// grid2 is full of bombs right now
// by looking at the grid1, we will explode the bombs in grid2
// grid1 has only the bombs which are going to explode in grid2 in the next second.

// iterate through to grid1 and when we find the bomb we will explode the bomb in grid2
    for(int i = 0; i < row; i++) {
        for(int j = 0; j < column; j++) {
            if(grid1[i][j] == 'O') {
                // explode the bomb in grid2
                grid2[i][j] = '.';
                if(i > 0) {
                    grid2[i-1][j] = '.';
                }
                if(j > 0) {
                    grid2[i][j-1] = '.';
                }
                if(i < row - 1) {
                    grid2[i+1][j] = '.';
                }
                if(j < column - 1) {
                    grid2[i][j+1] = '.';
                }
            }
        }
    }
}

void copyGrid(char grid1[200][200], char grid2[200][200], int row, int column) {
    // copy grid1 to grid2
    // iterate through grid1 and copy the values to grid2
    for(int i = 0; i < row; i++) {
        for(int j = 0; j < column; j++){
            grid2[i][j] = grid1[i][j];
        }
    }
}

int main() {
    char grid[200][200] = {0};
    // . => empty and O => bomb
    printf("Enter the row and column size: \n");
    int row, column; // grid size
    scanf("%d %d", &row, &column);

    // take seconds from the user
    int seconds;
    printf("Enter the seconds: ");
    scanf("%d", &seconds);

    printf("Enter the grid: \n");
    // Take user input for grid
    for(int i = 0; i < row; i++){
        for(int j = 0; j < column; j++){
            scanf(" %c", &grid[i][j]);
        }
    }

    char grid2[200][200] = {0};


    // copy grid to grid2
    copyGrid(grid, grid2, row, column);


    // Print the grid.
    printf("1. second: \n");
    printGrid(grid2, row, column);


    int counter = 1; // counts the seconds


    while(counter < seconds) {

    // Call the bomberMan function.
    bomberMan(grid2, row, column);

    // Print the grid again.
    printf("%d. second: \n", counter+1);    
    printGrid(grid2, row, column);
    counter++;
    if(counter == seconds) {
        break;
    }

    // Call the explodeBombs function.
    explodeBombs(grid, grid2, row, column);

    // Print the grid again.
    printf("%d. second: \n", counter+1);
    printGrid(grid2, row, column);
    counter++;

    // make grid2 to grid and restart the cycle.
    copyGrid(grid2, grid, row, column);
    }

    return 0;
}