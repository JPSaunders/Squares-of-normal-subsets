SquareCheck := function(G)	
	local ans, CC, Cosets, CT, CTQ, fus, i, n, N, NC, Out, t, tmp;
	if IsCharacterTable(G) then CT := G;
		else CT := CharacterTable(G);
	fi;
	ans := [];
	n := NrConjugacyClasses(CT);
	CC := [1..n];
	NC := ClassPositionsOfNormalSubgroups(CT)[2];
	N := Length(NC);
	CTQ := CT/NC;
	fus := FusionConjugacyClasses(CT,CTQ);
	t := Maximum(fus);
	Cosets := List([1..t], x -> Filtered(CC, y -> fus[y] = x));
	if N = n then return fail; fi; 		
	Out := [N+1 .. n];
	for i in Out do
		tmp := Filtered(CC, y -> ClassMultiplicationCoefficient(CT,i,i,y) <> 0);
		if tmp in Cosets then
			Add(ans,i);
		fi;
	od;
	return ans;
end;

ASSporadicNames := ["M12.2", "M22.2", "HS.2", "HJ.2", "McL.2", "Suz.2", "He.2", "HN.2", "Fi22.2", "Fi24", "ON.2", "J3.2"];

AlternatingNames := ["A5.2", "A6.2_1", "A6.2_2", "A6.2_3", "A6.2^2", "A7.2", "A8.2", "A9.2", "A10.2", "A11.2", "A12.2", "A13.2" ];

PSL2Names := ["L2(7).2", "L2(8).3", "L2(11).2", "L2(13).2", "L2(16).2", "L2(16).4", "L2(17).2", "L2(19).2", "L2(23).2", "L2(25).2_1", "L2(25).2_2", "L2(25).2_3", "L2(27).2", "L2(27).3", "L2(27).6", "L2(29).2", "L2(31).2", "L2(32).5"];

PSL3Names := ["L3(3).2", "L3(4).2_1", "L3(4).2_2", "L3(4).2_3", "L3(4).3", "L3(4).6", "L3(5).2", "L3(7).2", "L3(7).3", "L3(8).2", "L3(8).3", "L3(8).6"];	# L3(11).2 is missing.

PSLnNames := ["L4(3).2_1", "L4(3).2_2", "L4(3).2_3", "L5(2).2"];	# L4(2).2 is listed as A8.2 instead.

SpNames := ["S4(4).2", "S4(4).4", "S4(5).2", "S6(3).2"];	# S4(3).2 is listed as U4(2).2 instead.

U3Names := ["U3(3).2", "U3(4).2", "U3(4).4", "U3(5).2", "U3(5).3", "U3(8).2", "U3(8).3_1", "U3(8).3_2", "U3(8).3_3", "U3(8).6", "U3(7).2", "U5(2).2", "U3(9).2", "U3(9).4", "U3(11).2", "U3(11).3"];

UnNames := ["U4(2).2", "U4(3).2_1", "U4(3).2_2", "U4(3).2_3", "U4(3).4", "U6(2).2", "U6(2).3"];	

ONames := ["O8+(2).2", "O8+(2).3", "O8-(2).2", "O7(3).2", "O8-(3).2_1", "O8-(3).2_2", "O8-(3).2_3", "O10+(2).2", "O10-(2).2"];

TrialityNames := ["O8+(3).2_1", "O8+(3).2_1'", "O8+(3).2_1''", "O8+(3).2_2", "O8+(3).2_2'", "O8+(3).3", "O8+(3).4"];

TwistNames := ["Sz(8).3", "2F4(2)", "3D4(2).3", "2E6(2).2", "2E6(2).3"];	# yes 2F4(2) gives 2F4(2)'.2

ExceptionalNames := ["G2(3).2", "G2(4).2", "F4(2).2"];		# E6(2).2 is missing.

MagmaNames := ["E6(2).2", "L3(11).2"]; 	#	These are some groups which, for whatever reason, do not have character tables included in my version of GAP. To compute with these tables, we use the function GAPTableOfMagmaFile to import some which were computed via magma and written to files with the names listed here.

ASNames := Union([ASSporadicNames,AlternatingNames,PSL2Names,PSL3Names,PSLnNames,SpNames,U3Names,UnNames,ONames,TrialityNames,TwistNames,ExceptionalNames]);

for G in ASNames do if SquareCheck(G) = [] then Print(G, " may not work", "\n"); fi; od;

workdir := Directory("/workdir/magmatables");	# set the directory containing the character tables computed by magma.

for G in MagmaNames do 
	file := Filename(workdir, G);
	CT := GAPTableOfMagmaFile(file, "MagmaTable");
	if SquareCheck(CT) = [] then Print(G, "may not work", "\n"); fi;
od;

Print("Done. Any possible counterexamples are listed above.");