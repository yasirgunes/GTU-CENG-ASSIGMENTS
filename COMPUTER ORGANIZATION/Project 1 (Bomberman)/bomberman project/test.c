#include <stdio.h>

int main()
{
    int n, r, c, i, j;
    char grid0[200][201], grid3[200][200], grid5[200][200];

    scanf("%d %d %d\n", &r, &c, &n);
    for (i = 0; i < r; ++i)
        scanf("%s\n", grid0[i]);

    for (i = 0; i < r; ++i)
    for (j = 0; j < c; ++j)
        if ((grid0[i][j] == 'O') ||
            (i > 0 && grid0[i-1][j] == 'O') ||
            (j > 0 && grid0[i][j-1] == 'O') ||
            (i < r-1 && grid0[i+1][j] == 'O') ||
            (j < c-1 && grid0[i][j+1] == 'O'))
            grid3[i][j] = '.';
        else
            grid3[i][j] = 'O';

    for (i = 0; i < r; ++i)
    for (j = 0; j < c; ++j)
        if ((grid3[i][j] == 'O') ||
            (i > 0 && grid3[i-1][j] == 'O') ||
            (j > 0 && grid3[i][j-1] == 'O') ||
            (i < r-1 && grid3[i+1][j] == 'O') ||
            (j < c-1 && grid3[i][j+1] == 'O'))
            grid5[i][j] = '.';
        else
            grid5[i][j] = 'O';

    for (i = 0; i < r; ++i)
    {
        for (j = 0; j < c; ++j)
            printf("%c", n % 2 == 0 ? 'O' : n == 1 ? grid0[i][j] : n % 4 == 3 ? grid3[i][j] : grid5[i][j]);
        printf("\n");
    }

    return 0;
}