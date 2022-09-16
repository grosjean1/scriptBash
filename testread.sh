##Elise Grosjean
#16/09/2022

#! /bin/bash
##create a read.pvd that may be read with paraview for animation

echo "<VTKFile type=\"Collection\" version=\"0.1\" byte_order=\"LittleEndian\">"  >> read.pvd
echo "<Collection>">>read.pvd
cpt=0
for i in {0..250}
do
    cpt=$(($cpt+1))
    
         echo "       <DataSet part=\"0\"  timestep=\""$cpt"\" file=\"NIRB_approximation_"$i"_4.vtu\"/> " >>read.pvd
	 #echo "       <DataSet part=\"0\"  timestep=\""$cpt"\" file=\"Snapshoth_"$i".vtu\"/> " >>read.pvd
done
echo "    ">>read.pvd
echo "</Collection>">>read.pvd
echo "</VTKFile>">>read.pvd
