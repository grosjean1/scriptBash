#! /bin/bash


finetime="0.01 0.02 0.05 0.1"
finemesh="140 70 30 15"

#grossier
coarsetime="0.02 0.04 0.1 0.2" #hdiv2
coarsemesh="70 36 15 7"


theta=0.5 #Crank
for values in 1 2 3 4
do
    for param in 1 #0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5
    do

	tau=$(echo $coarsetime | cut -d ' ' -f $values)
	echo time $tau
	nnref=$(echo $coarsemesh |cut -d ' ' -f $values)
	echo sizemesh $nnref
	#mkdir -p ~/Codes/Parabolique/parabolique/CoarseSnapshots/hdiv2/$tau/$param/
	FreeFem++-nw Crank_Eulerinit.edp -tau $tau -nnref $nnref -Param $param -theta $theta

	#mv Snapshot* ~/Codes/Parabolique/parabolique/CoarseSnapshots/hdiv2/$tau/$param/
    done
done

coarsetime="0.1 0.1414 0.22 0.32" #sqrth
coarsemesh="15 10 7 5"
    
for values in 1 2 3 4
do
    for param in 1 #0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5
    do	 
	tau=$(echo $coarsetime | cut -d ' ' -f $values)
	echo time $tau
	nnref=$(echo $coarsemesh |cut -d ' ' -f $values)
	echo sizemesh $nnref
	#mkdir -p ~/Codes/Parabolique/parabolique/CoarseSnapshots/sqrth/$tau/$param/
	FreeFem++-nw Crank_Eulerinit.edp -tau $tau -nnref $nnref -Param $param -theta $theta

	#mv Snapshot* ~/Codes/Parabolique/parabolique/CoarseSnapshots/sqrth/$tau/$param/
    done
done


theta=1. #euler

for values in 1 2 3 4
do
    for param in 1 #0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5
    do	 
	tau=$(echo $finetime | cut -d ' ' -f $values)
	echo time $tau
	nnref=$(echo $finemesh |cut -d ' ' -f $values)
	echo sizemesh $nnref
	#mkdir -p ~/Codes/Parabolique/parabolique/FineSnapshots/$tau/$param/
	FreeFem++-nw Crank_Eulerinit.edp -tau $tau -nnref $nnref -Param $param -theta $theta

	#mv Snapshot* ~/Codes/Parabolique/parabolique/FineSnapshots/$tau/$param/
    done
done
# 4. 5. 7. 8.


echo "termine! "
