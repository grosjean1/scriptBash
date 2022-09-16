#! /bin/bash
# convertir .vtu (sortie FreeFem++/python en vtk entree FreeFem++)
nev=7
for (( c=0; c<=19; c++ ))
do  
    meshio-convert NIRB_approximation_${c}_${nev}.vtu NIRB_approximation_${c}_${nev}.vtk
    meshio-ascii NIRB_approximation_${c}_${nev}.vtk
done

