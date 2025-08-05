ta_slot_assignment([ta(N,Nu)|T],RemTAs,N):-
     Nu_New is Nu-1,
     RemTAs = [ta(N,Nu_New)|T].
ta_slot_assignment([ta(Na,Nu)|T1],[H|T2],N):-
     Na\=N,
	 H=ta(Na,Nu),
	 ta_slot_assignment(T1,T2,N).

slot_assignment(LabsNum,TAs,RemTAs,Assignment):-
	 setof(Assignment,(slot_assignment_h(LabsNum,TAs,RemTAs,Assignment,[])),L),
	 member(Assignment,L).
slot_assignment_h(0,R,R,[],_).
slot_assignment_h(LabsNum,TAs,RemTAs,Assignment,FullAssignment):-
	 member(Res,TAs),
	 Res=ta(Na,Nu),
	 Nu >=1,
	 \+member(Na,FullAssignment),
	 ta_slot_assignment(TAs,New_RemTAs,Na),
	 Assignment=[Na|T3],
	 append(FullAssignment,[Na],A),
	 LabsNum_New is LabsNum-1,
	 slot_assignment_h(LabsNum_New,New_RemTAs,RemTAs,T3,A).
	 
max_slots_per_day(DaySched,Max):-
     list_ta(DaySched,Max,[]),!.
list_ta([],_,_).
list_ta([H|T],Max,L):-
     list_ta_help(H,Max,L,FL),
	 list_ta(T,Max,FL).
list_ta_help([],_,NL,NL).
list_ta_help([H|T],Max,L,FL):-
     search_increment_check(H,L,NL,Max),
	 list_ta_help(T,Max,NL,FL).
search_increment_check(N,M,R,_):-
     M=[],R=[ta(N,1)],!.
search_increment_check(N,[ta(N,Num)|Q],NL,Max):-
     Num_new is Num+1,
	 Num_new =< Max,
	 NL =[ta(N,Num_new)|Q],!.
search_increment_check(N,[H|T],[H|T1],Max):-
     H=ta(Na,_),
	 N\=Na,
	 search_increment_check(N,T,T1,Max).

day_schedule([],RemTAs,RemTAs,[]).
day_schedule([H1|T1],TAs,RemTAs,[H2|T2]):-
     slot_assignment(H1,TAs,R,H2),
	 day_schedule(T1,R,RemTAs,T2).
	 
week_schedule([],_,_,[]).
week_schedule([H1|T1],TAs,DayMax,[H2|T2]):-
     day_schedule(H1,TAs,RemTAs,H2),
	 max_slots_per_day(H2,DayMax),
	 week_schedule(T1,RemTAs,DayMax,T2).