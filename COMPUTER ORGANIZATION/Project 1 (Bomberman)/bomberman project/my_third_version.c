#include <stdio.h>


// bomberMan function fills the grid's empty spaces with bombs
void bomberMan(char grid[40000], int row, int column) {
    printf("BomberMan planting the bombs...\n");
    
    // Use a single loop to iterate through the grid.
    for (int i = 0; i < row * column; i++) {
        // If the current cell is empty, fill it with a bomb.
        if (grid[i] == '.') {
            grid[i] = 'O';
        }
    }
}

void printGrid(char grid[40000], int row, int column){
    // Print the grid.
    printf("Grid: \n");
    for(int index = 0; index < row * column; index++){
        printf("%c", grid[index]);
        if ((index + 1) % column == 0) {
            printf("\n");
        }
    }
}

void explodeBombs(char grid1[40000], char grid2[40000], int row, int column) {
    int totalCells = row * column;  // Calculate total number of cells in the grid
    for(int index = 0; index < totalCells; index++) {  // Loop through each cell
        int i = index / column;  // Calculate the row index of the current cell
        int j = index % column;  // Calculate the column index of the current cell
        if(grid1[index] == 'O') {  // If the current cell in grid1 contains a bomb
            grid2[index] = '.';  // Explode the bomb in the current cell in grid2
            if(i > 0) {  // If the current cell is not in the first row
                grid2[index - column] = '.';  // Explode the bomb in the cell above
            }
            if(j > 0) {  // If the current cell is not in the first column
                grid2[index - 1] = '.';  // Explode the bomb in the cell to the left
            }
            if(i < row - 1) {  // If the current cell is not in the last row
                grid2[index + column] = '.';  // Explode the bomb in the cell below
            }
            if(j < column - 1) {  // If the current cell is not in the last column
                grid2[index + 1] = '.';  // Explode the bomb in the cell to the right
            }
        }
    }
}


void copyGrid(char grid1[40000], char grid2[40000], int row, int column) {
    // copy grid1 to grid2
    // iterate through grid1 and copy the values to grid2
    for(int i = 0; i < row; i++) {
        for(int j = 0; j < column; j++){
            grid2[i*column + j] = grid1[i*column + j];
        }
    }
}

int main() {
    char grid[40000] = {0};
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
            scanf(" %c", &grid[i*column + j]);
        }
    }

    char grid2[40000] = {0};


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