void explodeBombs(char grid1[40000], char grid2[40000], int row, int column) {
    int totalCells = row * column;
    for(int index = 0; index < totalCells; index++) {
        int i = index / column;
        int j = index % column;
        if(grid1[index] == 'O') {
            grid2[index] = '.';
            if(i > 0) {
                grid2[index - column] = '.';
            }
            if(j > 0) {
                grid2[index - 1] = '.';
            }
            if(i < row - 1) {
                grid2[index + column] = '.';
            }
            if(j < column - 1) {
                grid2[index + 1] = '.';
            }
        }
    }
}