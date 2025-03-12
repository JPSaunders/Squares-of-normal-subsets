# This file verifies that for all almost simple groups with socle 2E6(2) and for all conjugacy classes C in said group, there exists a class D of involutions such that CD contains an element of order 4.

Groupnames := ["2E6(2)", "2E6(2).2", "2E6(2).3", "2E6(2).3.2"];

InvolutionTest := function(G)
	local ans, CC, CT, Fours, i, Invs, n, ord, tmp;
	if IsCharacterTable(G) then CT := G;
		else CT := CharacterTable(G);
	fi;
	ans := [];
	n := NrConjugacyClasses(CT);
	ord := OrdersClassRepresentatives(CT);
	CC := Filtered([2..n], x -> IsOddInt(ord[x]));
	Invs := Filtered([2..n], x -> ord[x] = 2);
	Fours := Filtered([2..n], x -> ord[x] mod 4 = 0);
	for i in CC do
		for j in Invs do
			tmp := Filtered(Fours, y -> ClassMultiplicationCoefficient(CT, i, j, y) = 0);
		od;
		if tmp = Fours then
			Add(ans,i);
		fi;
	od;
	if ans = [] then return true;
		else Print(ans,"\n"); return false;
	fi;
end;

for G in Groupnames do Print(InvolutionTest(G), "\n"); od;
