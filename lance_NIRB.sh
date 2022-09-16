#! /bin/bash

#Elise Grosjean
#lance NIRB + POD Greedy Parabolique avec mu=1,a comparer avec erreur FEM fine,nev=10 (h=H*2 et h=H²) finetime=0.01 0.02 0.05 0.1
#modifier le script  NirbGreedyTestNIRBOKParaboliqueSolREF.py pour mu=1


finetime="0.01 0.02 0.05 0.1"
finemesh="140 70 30 15"

#grossier
coarsetimediv="0.02 0.04 0.1 0.2" #hdiv2

coarsetimesqrt="0.1 0.1414 0.22 0.32" #sqrth

theta=1 #unused
for nev in  1 2 3 5 6 7 8 9 10
do
    
    for values in 1 2 3 4
    do
	#for div2
	tau=$(echo $finetime | cut -d ' ' -f $values)
	echo time $tau
	taucoarse=$(echo $coarsetimediv | cut -d ' ' -f $values)
	python3	NirbGreedyTestNIRBOKParabolique.py $nev $tau hdiv2 $taucoarse
	#python3 NirbParaboliquePODGreedySolREF.py $nev $tau hdiv2 $taucoarse
	FileList=$(ls NIRB_approximation*) #|wc -l)

	nev=$(echo $FileList|cut -d ' ' -f 1|cut -d '_' -f 4|cut -d '.' -f 1)
	echo nev: $nev

	nbFile=$(ls NIRB_approximation*|wc -l)
	for (( c=0; c<$nbFile; c++ ))
	do  
	    echo meshio convert, file number: $c
	    meshio-convert NIRB_approximation_${c}_${nev}.vtu NIRB_approximation_${c}_${nev}.vtk
	    meshio-ascii NIRB_approximation_${c}_${nev}.vtk
	done

	nnref=$(echo $finemesh |cut -d ' ' -f $values)
	echo sizemesh $nnref
	echo "div2" >> erreur.txt
	FreeFem++-nw Crank_Euler.edp -tau $tau -nnref $nnref -Param 1 -nev $nev
	rm NIRB_app*
	echo !!!!!!!!!!!!   hdiv termine pour time $tau !!!!!!!!!!!!!!!!!
	
	## for sqrth 
	taucoarse=$(echo $coarsetimesqrt | cut -d ' ' -f $values)
	#python3 NirbGreedyTestNIRBOKParaboliqueSolREF.py $nev $tau sqrth $taucoarse
	python3	NirbGreedyTestNIRBOKParabolique.py $nev $tau sqrth $taucoarse

	FileList=$(ls NIRB_approximation*) 

	nev=$(echo $FileList|cut -d ' ' -f 1|cut -d '_' -f 4|cut -d '.' -f 1)
	echo nev: $nev

	nbFile=$(ls NIRB_approximation*|wc -l)
	for (( c=0; c<$nbFile; c++ ))
	do  
	    echo meshio convert, file number: $c
	    meshio-convert NIRB_approximation_${c}_${nev}.vtu NIRB_approximation_${c}_${nev}.vtk
	    meshio-ascii NIRB_approximation_${c}_${nev}.vtk
	done

	nnref=$(echo $finemesh |cut -d ' ' -f $values)
	echo sizemesh $nnref
	echo "sqrt" >> erreur.txt
	FreeFem++-nw Crank_Euler.edp -tau $tau -nnref $nnref -Param 1 -nev $nev
	rm NIRB_app*
	echo !!!!!!!!!! sqrt termine pour time $tau !!!!!!!!!!!!!
    done
done



echo "termine! "
