//önce kullanıcıdan r,c,n inputlarını al.
//Sonra başlangıç tablosunu oluştur. Rastgele yerlerde O olsun. Peki bu O random mu olsun yoksa ben mi belirleyeceğim? Her oyunda aynı mı olsun?

//baştaki ilk durumu kullanıcı elle girecek

#include <stdio.h>

void print_grid(char *grid, int row, int column){

    // int i,j;
    // for(i=0 ; i<row ; i++){
        
    //     for(j=0 ; j<column; j++){
    //         //printf("\nindex: %d  : ", i*column + j );
    //         int index = i*column + j;
    //         printf("%c", grid[index]);
    //     }
    //     printf("\n");
    // }

    //İç içe for kullannmak assembly'de bizi zorlar.
    
    printf("\nGrid bastırılıyor:\n");

    int i;
    int size = row*column;
    for(i=0 ; i<size ; i++){

        if(i % column == 0){
            printf("\n");
        }
        printf("%c", grid[i]);
        
    }

     printf("\n");


}


//Bomba olmayan her yere bomba koyar
void plant_bombs(char *grid, int row, int column){

    
    int size=row*column;
    int i = 0;
    while(i<size){

        if(grid[i] == '.'){
            grid[i] = 'O';
        }
        i++;
    }
    
}

//3 saniye önce koyulmuş bombaları patlatır.
void detonate_bombs(char *grid, char *temp_grid, int row, int column){

    int size = row*column;
    int i=0;
    while(i<size){


        if(temp_grid[i] == 'O'){
            grid[i] = '.';
            
            //eğer i satırın sonunda değilse i+1 de . yapılır.
            if((i+1) % column != 0){
                grid[i+1] = '.';
            }

            //eğer i satırın başında değilse i-1 de . yapılır.
            if(i % column != 0){
                grid[i-1] = '.';
            }

            //eğer i'nin değeri column değerinden küçük ise i ilk satırda demektir. Eğer ilk satırsa onun üstündeki eleman . yapılmaz. 
            if(i >= column){
            //if(i / column != 0){
                grid[i-column] = '.';
            }

            //eğer i'nin değeri size-column'dan küçük ise i son satırda değil demektir. Son satırda değilse bir altı kontrol edilebilir.
            if(i < size-column){
                grid[i+column] = '.';
            }

        }

        i++;
    }
}







//Sadece ileriye dönük kontroller yapmalı
void detonate_bombs2(char *grid, char *temp_grid, int row, int column){

    int size = row*column;
    int i=0;
    while(i<size){

        //temp'de ben O isem beni . yap
        if(temp_grid[i] == 'O'){
            grid[i] = '.';

            if((i+1) % column != 0){
                grid[i+1] = '.';
            }

            if(i < size-column){
                grid[i+column] = '.';
            }
        }

        //eğer i satırın sonunda değilse:
        if((i+1) % column != 0){
            //temp'de benden sonraki O ise beni . yap
            if(temp_grid[i+1] == 'O'){
                grid[i] = '.';
            }
        }

        if(i < size-column){
            //temp'te benim altımdaki O ise beni . yap.
            if(temp_grid[i+column] == 'O'){
                grid[i] = '.';
            }
        }


        i++;

        
    }
}








int main(){
    
    //asssembly'de tek seferde değil ayrı ayrı alabiliriz.
    int row, column, n;
    printf("\nEnter the row, column and n: ");
    scanf("%d %d %d", &row, &column, &n);
    
    //assembly'de işimiz kolay olsun diye tek boyutlu array oluşturuyorum
    char grid[40000];
    
    //Kullanıcıdan input alarak ilk grid oluşturuldu.
    printf("\nEnter the initial grid: ");
    scanf("%s", &grid);
    
    printf("You entered: %s\n", grid);
    

    //Buradan sonra döngüye girecek. 
    int count = 0;
    while(count != n){
        
        printf("\n\n\n\nWhile başındaki grid: \n\n");
        print_grid(grid, row, column);
        //buradaki arrayi tutmak gerek çünkü buradaki O'ları detone'te patlatacağız
        char temp_grid[40000];
        int i=0;
        while(i<40000){
            temp_grid[i] = grid[i];
            i++;
        }

        plant_bombs(grid, row, column);

        printf("\nBoş yerlere bomba yerleşiminden sonra grid: \n");

        print_grid(grid, row, column);

        detonate_bombs2(grid, temp_grid, row, column);

        printf("\nEski bombalar patladıktan sonra grid: \n");

        print_grid(grid, row, column);

        count += 1;

    }

    return 0;
    
    
}