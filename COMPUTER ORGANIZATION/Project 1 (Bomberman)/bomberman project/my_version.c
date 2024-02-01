#include <stdio.h>

// bomberMan function fills the grid's empty spaces with bombs
void bomberMan(char grid[4][4]) {
    printf("BomberMan planting the bombs...\n");
    // Iterate through the grid.
    for(int i = 0; i < 4; i++){
        for(int j = 0; j < 4; j++){
            // If the current cell is empty, fill it with a bomb.
            if(grid[i][j] == '.') {
                grid[i][j] = 'O';
            }
        }
    }
}
void printGrid(char grid[4][4]){
    // Print the grid.
    printf("Grid: \n");
    for(int i = 0; i < 4; i++){
        for(int j = 0; j < 4; j++){
            printf("%c", grid[i][j]);
        }
        printf("\n");
    }
}
void explodeBombs(char grid1[4][4], char grid2[4][4]) {
// grid2 is full of bombs right now
// by looking at the grid1, we will explode the bombs in grid2
// grid1 has only the bombs which are going to explode in grid2 in the next second.

// iterate through to grid1 and when we find the bomb we will explode the bomb in grid2
    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 4; j++) {
            if(grid1[i][j] == 'O') {
                // explode the bomb in grid2
                grid2[i][j] = '.';
                if(i > 0) {
                    grid2[i-1][j] = '.';
                }
                if(j > 0) {
                    grid2[i][j-1] = '.';
                }
                if(i < 3) {
                    grid2[i+1][j] = '.';
                }
                if(j < 3) {
                    grid2[i][j+1] = '.';
                }
            }
        }
    }
}

void copyGrid(char grid1[4][4], char grid2[4][4]) {
    // copy grid1 to grid2
    // iterate through grid1 and copy the values to grid2
    for(int i = 0; i < 4; i++) {
        for(int j = 0; j < 4; j++){
            grid2[i][j] = grid1[i][j];
        }
    }
}

int main() {
    char grid[4][4] = {0}; // Fixed size grid.
    // . => empty and O => bomb
    printf("Enter the grid (4x4): \n");
    


    // Take user input for grid
    for(int i = 0; i < 4; i++){
        for(int j = 0; j < 4; j++){
            scanf(" %c", &grid[i][j]);
        }
    }

    char grid2[4][4] = {0}; // Fixed size grid.

    // copy grid to grid2
    copyGrid(grid, grid2);

    // Print the grid.
    printf("1st second: \n");
    printGrid(grid2);

    // Call the bomberMan function.
    bomberMan(grid2);

    // Print the grid again.
    printf("2nd second: \n");
    printGrid(grid2);

    // Call the explodeBombs function.
    explodeBombs(grid, grid2);

    // Print the grid again.
    printf("3rd second: \n");
    printGrid(grid2);

    
    return 0;
}