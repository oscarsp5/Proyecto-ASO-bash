#!/usr/bin/env bash

#------------------Funciones---------------------

#------------------Funcion Gestion Permisos---------------------

function fpermisos(){
	
rutafichero=$(yad --width=400 --height=350 --title "Selecciona el fichero" --form --center --field=fichero:FL --column="") 2> /dev/null

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


