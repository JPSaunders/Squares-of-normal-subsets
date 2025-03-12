// This file verifies that for all almost simple groups with socle listed in Groupnames and for all conjugacy classes C in said group, there exists a class D of involutions such that CD contains an element of order 4.

ClassInvolutionTest := function(G);
	CT := CharacterTable(G);
	R := Universe(CT);
	cd := ClassesData(R);
	CC := [i : i in [1..#cd] | IsOdd(cd[i,1]) and cd[i,1] gt 1];
    C2 := [i : i in [1..#cd] | cd[i,1] eq 2];
	Cx := [i : i in [1..#cd] | cd[i,1] mod 4 eq 0]; 
    if #Cx eq 0 then return "no elements of order 4"; end if;
	ans := {i : i in CC | {StructureConstant(R,i,j,k) : j in C2, k in Cx} eq {0}};
	if ans eq {} then return true;
	else
		print ans;
		return false;
	end if;
end function;

Groupnames := [*<"L",3,2>, <"L",3,3>, 
<"L",4,2>, <"L",4,3>, <"U",4,2>, <"U",4,3>, <"U",5,2>,
 <"A",6>, <"S",4,3>, <"S",6,2>, <"O",7,3>, 
 <"O+",8,2>, <"O+",8,3>, <"U",3,3>, <"G2",3>, 
 <"3D4",2>, <"3D4",3>, <"2F4",2>*];
// should be 19 entries.

for t in Groupnames do 
	print t;
	if #t eq 3 then 
		A := AutomorphismGroupSimpleGroup(t[1], t[2], t[3]);
	else
		A := AutomorphismGroupSimpleGroup(t[1],t[2]);
	end if;
	G := Socle(A);
	if Index(A,G) eq 1 or IsPrime(Index(A,G)) then 
		subs := [A,G];
	else
		subs := LowIndexSubgroups(A,Index(A,G));
	end if;
	for H in subs do ClassInvolutionTest(G); end for;
end for;
