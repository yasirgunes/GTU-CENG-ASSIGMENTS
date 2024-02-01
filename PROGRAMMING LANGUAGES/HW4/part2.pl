cls :- write('\33\[2J').
% clear screen and move cursor to top left

classify(SepalLength, _, PetalLength, PetalWidth) :-
    PetalLength =< 2.45,
    writeln('Iris-setosa'), !;
    PetalWidth =< 1.75,
        PetalLength =< 4.95,
            PetalWidth =< 1.65,
                writeln('Iris-versicolor'), !;
                writeln('Iris-virginica'), !;
            PetalWidth =< 1.55,
                writeln('Iris-virginica'), !;
                PetalLength =< 5.45,
                    writeln('Iris-versicolor'), !;
                    writeln('Iris-virginica'), !;
        PetalLength =< 4.85,
            SepalLength =< 5.95,
                writeln('Iris-versicolor'), !;
                writeln('Iris-virginica'), !;
            writeln('Iris-virginica'), !.
    
            