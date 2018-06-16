
modules(L) :- setof(A, B^(dependency(A,B)), L).

dep1(A, D) :- setof((A,B,1), dependency(A,B), D).
dep2(A, D) :- setof((A,C,2), B^(dependency(A,B), dependency(B,C), not(dependency(A,C))), D).

all_deps([]).
all_deps([A|R]) :-
    show_deps(A),
    all_deps(R).

show_deps(A) :-
    dep1(A,D1), prt_deps(D1),
    dep2(A,D2), prt_deps(D2), !.
show_deps(_) :- !,
    true.

prt_deps([]).
prt_deps([(A,B,N)|R]) :-
    atom_codes(A,A2),
    atom_codes(B,B2),
    atom_codes('_', Mid),
    atom_codes(', ', Sep),
    number_codes(N,N2),
    append([A2, Mid, B2, Sep, A2, Sep, B2, Sep, N2], L),
    atom_codes(L2,L),
    writeln(L2),
    prt_deps(R).


go :-
    consult("dependencies.pl"),
    modules(L),
    all_deps(L).

go2 :-
    consult("dependencies.pl"),
    modules(L),
    prt_csv(L).
prt_csv([]).
prt_csv([M|R]) :-
  %atom_codes(M, M2),
    writeln(M),
    prt_csv(R).

