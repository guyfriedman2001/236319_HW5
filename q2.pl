

:- debug.

fib(0,1).
fib(1,2).
fib(X,Y) :- 
    Y>2,
    Y1 is Y-1,
    Y2 is Y-2,
    fib(Xtemp1,Y1),
    fib(Xtemp2,Y2),
    X is Xtemp1+Xtemp2.
padovan(1,1).
padovan(1,2).
padovan(1,3).
padovan(X,Y) :-
    Y >3,
    Y1 is Y-2,
    Y2 is Y-3,
    padovan(Xtemp1,Y1),
    padovan(Xtemp2,Y2),
    X is Xtemp1+Xtemp2.
factorial(0,1).
factorial(X,Y) :-
    X>0,
    X1 is X-1,
    factorial(X1,Ytemp),
    Y is X*Ytemp.
catalan(X,Y) :-
    Ydub is 2*Y,
    factorial(Ydub,X2),
    Ymin is Y+1,
    factorial(Ymin,X1),
    factorial(Y,Xfac),
    X is (X2)/(X1 *Xfac). 
sumfib(0,0).
sumfib(X,Y) :-
    
    Y1 is Y-1,
    sumfib(Xprev,Y1),
    fib(Curfib,Y),
    X is Curfib+Xprev.
sumpad(1,1).
sumpad(X,Y):-
    Y>1,
    Y1 is Y-1,
    sumpad(Xprev,Y1),
    padovan(Curfib,Y),
    X is Curfib+Xprev.
sumcat(1,1).
sumcat(X,Y) :-
    Y>1,
    Y1 is Y-1,
    sumcat(Xprev,Y1),
    catalan(Curfib,Y),
    X is Curfib+Xprev.
multisum(1,0,1,1).
multisum(N,FIB,PAD,CAT) :-
    N>1,
    sumfib(FIB,N),
    sumpad(PAD,N),
    sumcat(CAT,N).
:- include('q2.in').
