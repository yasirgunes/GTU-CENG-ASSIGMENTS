cls :- write('\33\[2J').
% clear screen and move cursor to top left


% declaring location
location('Admin Office').
location('Engineering Bld.').
location('Lecture Hall A').
location('Institute Y').
location('Library').
location('Cafeteria').
location('Social Sciences Bld.').
location('Institute X').

% declaring objects
obj(1, weight(40), pickup('Admin Office'), dropof('Social Sciences Bld.'), urgency('low'), delivery_person_id(none)).
obj(2, weight(80), pickup('Engineering Bld.'), dropof('Lecture Hall A'), urgency('low'), delivery_person_id(none)).
obj(3, weight(60), pickup('Lecture Hall A'), dropof('Cafeteria'), urgency('high'), delivery_person_id(none)).
obj(4, weight(90), pickup('Library'), dropof('Institute X'), urgency('medium'), delivery_person_id(none)).
obj(5, weight(70), pickup('Institute X'), dropof('Admin Office'), urgency('medium'), delivery_person_id(1)).

% declaring paths
path('Admin Office', 'Engineering Bld.', 3).
path('Engineering Bld.', 'Admin Office', 3).

path('Lecture Hall A', 'Engineering Bld.', 2).
path('Engineering Bld.', 'Lecture Hall A', 2).

path('Lecture Hall A', 'Institute Y', 3).
path('Institute Y', 'Lecture Hall A', 3).

path('Library', 'Engineering Bld.', 5).
path('Engineering Bld.', 'Library', 5).

path('Admin Office', 'Cafeteria', 4).
path('Cafeteria', 'Admin Office', 4).

path('Admin Office', 'Library', 1).
path('Library', 'Admin Office', 1).

path('Institute Y', 'Library', 3).
path('Library', 'Institute Y', 3).

path('Library', 'Cafeteria', 5).
path('Cafeteria', 'Library', 5).

path('Library', 'Social Sciences Bld.', 2).
path('Social Sciences Bld.', 'Library', 2).

path('Social Sciences Bld.', 'Cafeteria', 2).
path('Cafeteria', 'Social Sciences Bld.', 2).

path('Social Sciences Bld.', 'Institute X', 8).
path('Institute X', 'Social Sciences Bld.', 8).

% declaring delivery personel 
:- dynamic delivery_personel/5.
delivery_personel(1, capacity(100), work_hours([0, 24]), current_job(5), location('Institute X')).

delivery_personel(2, capacity(70), work_hours([0, 24]), current_job(none), location('Cafeteria')).

delivery_personel(3, capacity(120), work_hours([0, 24]), current_job(none), location('Library')).

update_delivery_personel(ID, NewJob, NewLocation) :-
    delivery_personel(ID, Capacity, WorkHours, _, _),
    retract(delivery_personel(ID, _, _, _, _)),
    assert(delivery_personel(ID, Capacity, WorkHours, NewJob, NewLocation)).


list_delivery_personels :-
    delivery_personel(ID, capacity(Capacity), work_hours(WorkHours), current_job(ObjectID), location(CurrentLocation)),
    write('ID: '), write(ID), nl,
    write('Capacity: '), write(Capacity), nl,
    write('WorkHours: '), write(WorkHours), nl,
    write('CurrentJob: '), write(ObjectID), nl,
    write('CurrentLocation: '), write(CurrentLocation), nl, nl,
    fail.

% functionalities.

/*

Bir obje alacağız kullanıcıdan query olarak.

Bu objeyi alıp teslim edebilecek delivery personelleri bastıracağız.

Aynı zamanda objeyi alıp teslim edene kadar geçen süreyi de bastıracağız.

Objeyi alıp teslim edene kadar geçen süre delivery personelin mesai saatlerini aşıyorsa, o delivery personeli bastırmayacağız.

Objenin ağrılığı delivery personelin kapasitesini aşıyorsa, o delivery personeli bastırmayacağız.

*/

% get_object(+ObjectID, -Object)
get_object(ObjectID, Object) :-
    obj(ObjectID, weight(Weight), pickup(Pickup), dropof(Dropof), urgency(Urgency), delivery_person_id(DeliveryPersonID)),
    Object = object(ObjectID, weight(Weight), pickup(Pickup), dropof(Dropof), urgency(Urgency), delivery_person_id(DeliveryPersonID)).

% get_delivery_personel(+DeliveryPersonID, -DeliveryPersonel)
get_delivery_personel(DeliveryPersonID, DeliveryPersonel) :-
    delivery_personel(DeliveryPersonID, capacity(Capacity), work_hours(WorkHours), current_job(CurrentJob), location(CurrentLocation)),
    DeliveryPersonel = delivery_personel(DeliveryPersonID, capacity(Capacity), work_hours(WorkHours), current_job(CurrentJob), location(CurrentLocation)).

/*
    find the shortest path from the current location of the delivery personel to the pickup location of the object
    and then to dropof location of the object.
*/

% Predicate to initialize Dijkstra's algorithm
shortest_path(Start, End, Path, Distance) :-
    dijkstra([(0, Start, [Start])], End, PathRev, Distance),
    reverse(PathRev, Path).

% Dijkstra's algorithm
dijkstra(Queue, Destination, Path, Cost) :-
    select((Cost, Destination, Path), Queue, _Rest),
    !.  % If the destination is the first node in the queue, we are done
dijkstra(Queue, Destination, Path, Cost) :-
    select((Dist, Node, PathToNode), Queue, RestQueue),
    findall((NewDist, Adj, [Adj|PathToNode]),
            (path(Node, Adj, StepCost), \+ member(Adj, PathToNode),
             NewDist is Dist + StepCost),
            AdjList),
    append(RestQueue, AdjList, NewQueue),
    sort(1, @=<, NewQueue, SortedQueue),  % Sort by distance, non-decreasing
    dijkstra(SortedQueue, Destination, Path, Cost).



% Selects the element with the smallest distance from the queue
select(Min, [Min|Rest], Rest).
select(Min, [Head|Tail], [Head|Result]) :-
    select(Min, Tail, Result),
    Head @> Min.

% Helper predicate to reverse a list
reverse(List, Rev) :-
    reverse(List, [], Rev).
reverse([], Rev, Rev).
reverse([Head|Tail], SoFar, Rev) :-
    reverse(Tail, [Head|SoFar], Rev).



% Checks if delivery personel is available for a given duration

is_available(DeliveryPersonID, RequiredTime) :-
    delivery_personel(DeliveryPersonID, _, work_hours([Start | End]), _, _),
    End - Start >= RequiredTime.


% Validates if delivery personel can take the job
validate_delivery_personel(DeliveryPersonID, ObjectWeight) :-
    get_delivery_personel(DeliveryPersonID, delivery_personel(_, capacity(Capacity), _, _, _)),
    Capacity >= ObjectWeight.

% Calculates the delivery path and time from the current location of the delivery personel to the dropoff location of the object
calculate_path_and_time(CurrentLocation, Pickup, Dropoff, Path, TotalTime) :-
    shortest_path(CurrentLocation, Pickup, PathToPickup, TimeToPickup),
    shortest_path(Pickup, Dropoff, PathToDropoff, TimeToDropoff),
    append(PathToPickup, PathToDropoff, Path),
    TotalTime is TimeToPickup + TimeToDropoff.

% Gets the delivery time and path for a delivery personel and an object
get_delivery_time(DeliveryPersonID, ObjectID, DeliveryTime, Path) :-
    obj(ObjectID, weight(ObjectWeight), pickup(Pickup), dropof(Dropoff), _, _),
    validate_delivery_personel(DeliveryPersonID, ObjectWeight),
    get_delivery_personel(DeliveryPersonID, delivery_personel(_, _, _, current_job(none), location(CurrentLocation))),
    calculate_path_and_time(CurrentLocation, Pickup, Dropoff, Path, DeliveryTime),
    is_available(DeliveryPersonID, DeliveryTime).

% % Finds all suitable delivery personel for a given object

find_suitable_delivery_personel(ObjectID, SuitablePersonel) :-
    obj(ObjectID, weight(Weight), pickup(Pickup), dropof(Dropoff), _, _),
    findall((PersonelID, TotalTime, Path),
            % Goal: Find suitable delivery personel
            (delivery_personel(PersonelID, capacity(Capacity), _, current_job(none), location(Location)),
             Capacity >= Weight,  % Check capacity
             calculate_path_and_time(Location, Pickup, Dropoff, Path, TotalTime),  % Calculate path and time
             is_available(PersonelID, TotalTime)),  % Check availability
            AllPersonel),
    % Removing duplicates and ensuring no infinite loop
    list_to_set(AllPersonel, SuitablePersonel).



% Query system for getting all available delivery personel for a given object
available_delivery_personel(ObjectID) :-
    obj(ObjectID, _, _, _, _, delivery_person_id(DeliveryPersonID)),
    % Check if the object is already in delivery
    (DeliveryPersonID \= none ->
        format("Object is already in delivery by personel ID ~w.\n", [DeliveryPersonID])
    ;
        % Find all suitable delivery personel
        find_suitable_delivery_personel(ObjectID, SuitablePersonel),
        % Print out each suitable personel with the total time
        print_suitable_personel(SuitablePersonel)
    ).

% Helper predicate to print out each suitable personel and their total time
print_suitable_personel([]) :- format("No other suitable delivery personel found.\n").
print_suitable_personel([(PersonelID, TotalTime, Path)|T]) :-
    format("personel ID: ~w can deliver in ~w units of time. Path: ~w\n", [PersonelID, TotalTime, Path]),
    print_suitable_personel(T).



