#!/usr/bin/env bash

#------------------Funciones---------------------

#------------------Funcion Gestion Permisos---------------------

function fpermisos(){
	
#Seleccion archivo

archivo=$(yad --file \
		--title="Proyecto-bash-Oscar" \
		--height=200 \
		--width=100 \
		--center \
		--text="Selecciona un archivo:" \
		--file-filter="scripts | *.sh")
ans=$?
		
if [ $ans -eq 0 ]
	then
		echo "Has elegido este archivo: ${archivo}"
	else
		echo "No has elegido ningún archivo"
fi
	
#Seleccion permisos
	
#Permisos Propietario
	
ppropietario=$(yad --list \
			--title="Proyecto-bash-Oscar" \
			--height=70 \
			--width=35 \
			--center \
			--text="Establece permisos a propietario:" \
			--entry --button=Establecer:0 )
					
while [ $ppropietario -gt 7 ]
	do
		yad --width=400 --height=50 --center --text-align=center --column="" --text="Escriba un número entre el 0 y 7"
		ppropietario=$(yad --width=400 --height=50 --title "Permisos para propietarios" --center --text-align=center \
		--text="Se ha pasado de 7 vuelva a escribir el numero:" --entry --button=Establecer:0 )		
	done
		
#Permisos Grupos
		
pgrupo=$(yad --list \
      --title="Proyecto-bash-Oscar" \
      --height=70 \
      --width=35 \
      --center \
      --text="Establece permisos a grupos:" \
      --entry --button=Establecer:0 )
	
while [ $pgrupo -gt 7 ]
	do
		yad --width=400 --height=50 --center --text-align=center --column="" --text="Escriba un número entre el 0 y 7"
		pgrupo=$(yad --width=400 --height=50 --title "Permisos para grupos" --center --text-align=center \
		--text="Se ha pasado de 7 vuelva a escribir el numero:" --entry --button=Establecer:0 )
	done
	
potros=$(yad --list \
      --title="Proyecto-bash-Oscar" \
      --height=70 \
      --width=35 \
      --center \
      --text="Establece permisos a otros" \
      --entry --button=Establecer:0 )
	
while [ $potros -gt 7 ]
	do
		yad --width=400 --height=50 --center --text-align=center --column="" --text="Escriba un número entre el 0 y 7"
		potros=$(yad --width=400 --height=50 --title "Permisos para otros" --center --text-align=center \
		--text="Se ha pasado de 7 vuelva a escribir el numero:" --entry --button=Establecer:0 )
	done
  
  
permisos="$ppropietario$pgrupo$potros"
	chmod $permisos $archivo
	comls=$(ls -l $archivo)
	echo $comls
	
	resultado=$(yad --width=400 --height=300 --title "Estos son los permisos que has seleccionado" --center --text="${comls}")


}

#------------------Funcion Tareas Programadas---------------------

function ftareas(){
	echo "Tarea"
}

#------------------Funcion Borrar Ficheros---------------------

function fborrar(){
	echo "Borrar Fichero"
	read -p "Que fichero quieres borrar: " borrar
	rm -r $borrar 
	ls -l 
	
	
	
	
}

#------------------Funcion Recuperar Ficheros---------------------

function frecuperar(){
	
	echo "Recuperar"
	
}






#--------------------Menu------------------------- 


opcion1="<span weight=\"bold\" font=\"12\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\">Borrar Ficheros</span>"
opcion4="<span weight=\"bold\" font=\"12\">Recuperar Ficheros</span>"
opcion5="<span weight=\"bold\" font=\"12\">Salir</span>"

op=$(yad --width=300 --height=250 --title "Menu Opciones" --list --column="" --column="" 1 "${opcion1}" 2 "${opcion2}" 3 "${opcion3}" 4 "${opcion4}" 5 "${opcion5}" \
--center) 2> /dev/null

op=`echo $op | cut -f1 -d"|"`

case $op in 
	"1") fpermisos;;
	"2") ftareas;;
	"3") fborrar;;
	"4") frecuperar;;
	"5") fsalir;;
esac


