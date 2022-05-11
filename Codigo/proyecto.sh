#!/usr/bin/env bash

#------------------Funciones---------------------

#------------------Funcion Gestion Permisos---------------------

function fpermisos(){
	
#Seleccion archivo

archivo=$(yad --file \
		--title="Proyecto-bash-Oscar" \
		--height=500 \
		--width=300 \
		--center \
		--text="Selecciona un archivo:" \
		--file-filter="scripts | * ")
ans=$?
		
if [ $ans -eq 0 ]
	then
		echo "Has elegido este archivo: ${archivo}"
	else
		echo "No has elegido ningún archivo"
fi
	
#Seleccion permisos
	
#Permisos Propietario
	
permisos=$(yad --form \
			--title="Proyecto-bash-Oscar" \
			--height=300 \
			--width=200 \
			--center \
			--text="Establece permisos:" \
			--button=Establecer:0 --button=Cancelar:1 \
			--column=""\
			--field="Usuario":NUM \
			--field="Grupos":NUM \
			--field="Otros":NUM \
			)
			
			
			ans=$?
	if [ $ans -eq 0 ]
	then
			IFS="|" read -r -a pu <<< "$permisos"
			user=${pu[0]}
			group=${pu[1]}
			other=${pu[2]}
	
		
		permisos="$user$group$other"
		echo ${permisos}
	else
		echo "No has elegido ningún componente"
	fi
    chmod $permisos $archivo
    ls -l $archivo

			
					

#Regresamos al menu


opcion1="<span weight=\"bold\" font=\"12\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\">Borrar Ficheros y Carpetas</span>"
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


}

#------------------Funcion Tareas Programadas---------------------

function ftareas(){
	echo "Tarea"
	

#Regresamos al menu


opcion1="<span weight=\"bold\" font=\"12\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\">Borrar Ficheros y Carpetas</span>"
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
	
	
	
}

#------------------Funcion Borrar Ficheros---------------------

function fborrar(){

	seleccionar=$( yad --list --title "Selecciona lo que quieres borrar" --width=500 --height=50 --center \
	--column="" --column="" --text-align=center \
	--text="Que podemos borrar:
		Para Ficheros = borrartxt
		Para Directorios = borrardir" --entry) 2> /dev/null 


#Para borrar Ficheros 

	if [ $seleccionar = "borrartxt" ]

		then

			borrarfichero=$(yad \
			--width=300 \
			--height=300 \
			--title "Seleccionas el fichero que quieres borrar" \
			--form --center --file  \
			--column="" ) 2> /dev/null 

	if [ -d /home/$USER/papelera ]
	
		then
	
			"La papelera esta creada"
		else
	
			mkdir papelera 
	
	fi

	mv $borrarfichero papelera/
	echo "$borrarfichero" > papelera/ruta.txt
	myfile="$borrarfichero"
	concatenaruta="rutantigua${myfile##*/}"
	mv papelera/ruta.txt papelera/$concatenaruta
	resultadoborrar=$(yad --width=300 --height=100 --title "Archivo borrado" --center --text-align=center --list  \
	--column="" --text="Has borrado el fichero:" ${borrarfichero})


#Para borrar Directorios

	elif [ $seleccionar = "borrardir" ]

		then

			borrardirectorio=$(yad \
			--width=300 \
			--height=300 \
			--title "Seleccionas el fichero que quieres borrar" \
			--form --center --file --directory  \
			--column="" ) 2> /dev/null 

#Crear papelera

	if [ -d /home/$USER/papelera ]

		then
		
			"La papelera esta creada"
	else
	
		mkdir papelera 
	
	fi

	mv $borrardirectorio papelera/
	echo "$borrardirectorio" > papelera/rutadir
	mydirectory="$borrardirectorio"
	concatenaruta="rutantigua${mydirectory##*/}"
	mv papelera/rutadir papelera/$concatenaruta
	resultadoborrar=$(yad --width=300 --height=100 --title "Directorio borrado" --center --text-align=center --list  \
	--column="" --text="Has borrado la carpeta:" ${borrardirectorio})


	else

	yad --width=300 --height=100 --title "Error" --text="Selecciona que quieres borrar correctamente" --form --center --directory --column=""  --image=stop 

	fi

#Regresamos al menu


opcion1="<span weight=\"bold\" font=\"12\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\">Borrar Ficheros y Carpetas</span>"
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
	
	
	
}

#------------------Funcion Recuperar Ficheros---------------------

function frecuperar(){
	
	echo "Recuperar"
	
	
	
#Regresamos al menu


opcion1="<span weight=\"bold\" font=\"12\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\">Borrar Ficheros y Carpetas</span>"
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
	
	
	
}

#------------------Funcion Salir---------------------

function fsalir(){
	
	echo "Has salido del menu"


}


#--------------------Menu------------------------- 


opcion1="<span weight=\"bold\" font=\"12\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\">Borrar Ficheros y Carpetas</span>"
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



