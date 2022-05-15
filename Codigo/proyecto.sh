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
		--file)
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
			--width=300 \
			--center \
			--text="Establece permisos:" \
			--button=Establecer:0 --button=Cancelar:1 \
			--column=""\
			--field="Usuario (0-7)":NUM \
			--field="Grupos (0-7)":NUM \
			--field="Otros (0-7)":NUM \
			)
			
ans=$?

	if [ $ans -eq 0 ]
	
		then
		
			IFS="|" read -r -a parametro <<< "$permisos"
			usuario=${parametro[0]}
			grupos=${parametro[1]}
			otros=${parametro[2]}
	
			permisos="$usuario$grupos$otros"
			echo ${permisos}resultado=$(yad --center --title= "Pemisos" --text="Estos son los permisos que has otorgado ->  ${permisos}")
	else
		echo "No has otorgado ningun permiso"
	fi
		chmod $permisos $archivo
		ls -l $archivo

#Regresamos al menu

opcion1="<span weight=\"bold\" font=\"12\" foreground=\"red\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\" foreground=\"red\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\" foreground=\"red\">Borrar Ficheros y Carpetas</span>"
opcion4="<span weight=\"bold\" font=\"12\" foreground=\"red\">Recuperar Ficheros</span>"
opcion5="<span weight=\"bold\" font=\"12\" foreground=\"red\">Salir</span>"

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

	menutarea=$(yad  --form \
		--width=500 \
		--height=300 \
		--title "Tareas Programadas" \
        --center \
		--field="Minuto (0-59)":NUM --field="Hora (0-23)":NUM --field="Días del mes (1-31)":NUM --field="Mes (1-12)":NUM --field="Dia de la semana (0-6)":NUM --field="Comando" --field="Descripcion comando")   
            
    ans=$?
            
    if [ $ans -eq 0 ]
		then
		
			IFS="|" read -r -a parametro <<< "$menutarea"
			minutos=${parametro[0]}
			hora=${parametro[1]}
			diasmes=${parametro[2]}
			mes=${parametro[3]}
			diasemana=${parametro[4]}
			descripcion=${parametro[5]}
			comando=${parametro[6]}
			agregar=$(echo "$minutos $hora $diasmes $mes $diasemana $USER $comando" >> /etc/crontab )
			aceptar=$(yad --center --info --title= "Tareas programadas" --text="Tarea editada correctamente")
			
		else
					
			error=$(yad --center --info --title="Error" --image="stop" --text="Error al agregar la tarea")
	fi

#Regresamos al menu

opcion1="<span weight=\"bold\" font=\"12\" foreground=\"red\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\" foreground=\"red\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\" foreground=\"red\">Borrar Ficheros y Carpetas</span>"
opcion4="<span weight=\"bold\" font=\"12\" foreground=\"red\">Recuperar Ficheros</span>"
opcion5="<span weight=\"bold\" font=\"12\" foreground=\"red\">Salir</span>"

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
	echo "$borrarfichero" > papelera/rutatxt
	ficheroelegido="$borrarfichero"
	concatenaruta="donde-estaba-${ficheroelegido##*/}"
	mv papelera/rutatxt papelera/$concatenaruta
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
	concatenaruta="donde-estaba-${mydirectory##*/}"
	mv papelera/rutadir papelera/$concatenaruta
	resultadoborrar=$(yad --width=300 --height=100 --title "Directorio borrado" --center --text-align=center --list  \
	--column="" --text="Has borrado la carpeta:" ${borrardirectorio})

	else

	yad --width=300 --height=100 --title "Error" --text="Selecciona que quieres borrar correctamente" --form --center --directory --column=""  --image=stop 

	fi

#Regresamos al menu

opcion1="<span weight=\"bold\" font=\"12\" foreground=\"red\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\" foreground=\"red\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\" foreground=\"red\">Borrar Ficheros y Carpetas</span>"
opcion4="<span weight=\"bold\" font=\"12\" foreground=\"red\">Recuperar Ficheros</span>"
opcion5="<span weight=\"bold\" font=\"12\" foreground=\"red\">Salir</span>"

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

#------------------Funcion Recuperar Ficheros y Carpetas---------------------

function frecuperar(){
cd papelera/	

recu=$( yad --list --title "Selecciona lo que quieres recuperar" --width=500 --height=50 --center \
	--column="" --column="" --text-align=center \
	--text="Que queremos recuperar:
		Para Ficheros = recutxt
		Para Directorios = recudir" --entry) 2> /dev/null 
	
	
#Para recuperar Ficheros 

	if [ $recu = "recutxt" ]

		then
			
			recufichero=$(yad \
			--width=300 \
			--height=300 \
			--title "Seleccionas el fichero que quieres recuperar" \
			--form --center --file  \
			--column="" ) 2> /dev/null 

	cual=$(yad --width=500 --height=50 --title "¿Que ruta quiere?" --list --center --column="" --column="" --text-align=center  \
						--text="Que ruta queremos recuperar:
		Para la ruta de antes = rutantes 
		Para la ruta actual = rutactual" --entry) 2> /dev/null 

			if [ $cual = "rutantes" ]
				then
					rutantes="${recufichero##*/}"
						cadena=$(cat donde-estaba-$rutantes)
						cadena2="${cadena%/*}"
						cadena3="donde-estaba-$rutantes"
						mv $recufichero $cadena2
						comandolsl=$(ls -l $cadena2)
						cd papelera/
						rm -r $cadena3
						yad --width=550 --height=300 --title "Archivo recuperado con éxito" --center --text="
						Archivo recuperado en directorio antiguo
						${comandolsl}"
						cd ..
		
			elif [ $cual = "rutactual" ]
			
				then
				
				recuactu="$recufichero"
						rutacon="donde-estaba-${recuactu##*/}"
						rm -r $rutacon
						cd ..
						mv $recuactu .
						comandolsactual=$(ls -l)
						yad --width=550 --height=300 --title "Archivo recuperado con éxito" --center --text="
						Archivo recuperado en directorio actual
						${comandolsactual}"	
		
			fi
		
		

#Para recuperar Directorios

	elif [ $recu = "recudir" ]

		then
			
			recudirectorio=$(yad \
			--width=300 \
			--height=300 \
			--title "Seleccionas el directorio que quieres recuperar" \
			--form --center --file --directory  \
			--column="" ) 2> /dev/null 
	
	cual=$(yad --width=500 --height=50 --title "¿Que ruta quiere?" --list --center --column="" --column="" --text-align=center  \
						--text="Que ruta queremos recuperar:
		Para la ruta de antes = rutantes 
		Para la ruta actual = rutactual" --entry) 2> /dev/null 
		
		if [ $cual = "rutantes" ]
				then
					rutantesdir="${recudirectorio##*/}"
						cadena=$(cat donde-estaba-$rutantesdir)
						cadena2="${cadena%/*}"
						cadena3="donde-estaba-$rutantesdir"
						mv $recudirectorio $cadena2
						comandolsl=$(ls -l $cadena2)
						cd papelera/
						rm -r $cadena3
						yad --width=550 --height=300 --title "Archivo recuperado con éxito" --center --text="
						Archivo recuperado en directorio antiguo
						${comandolsl}"
						cd ..
		
			elif [ $cual = "rutactual" ]
			
				then
				
				recuactudir="$recudirectorio"
						rutacon="donde-estaba-${recuactudir##*/}"
						rm -r $rutacon
						cd ..
						mv $recuactudir .
						comandolsactual=$(ls -l)
						yad --width=550 --height=300 --title "Archivo recuperado con éxito" --center --text="
						Archivo recuperado en directorio actual
						${comandolsactual}"	
		
			fi

	
	
	else
		
		yad --width=300 --height=100 --title "Error" --text="Selecciona que quieres recuperar correctamente" --form --center --directory --column=""  --image=stop
	
	
	fi
	
#Regresamos al menu

opcion1="<span weight=\"bold\" font=\"12\" foreground=\"red\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\" foreground=\"red\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\" foreground=\"red\">Borrar Ficheros y Carpetas</span>"
opcion4="<span weight=\"bold\" font=\"12\" foreground=\"red\">Recuperar Ficheros</span>"
opcion5="<span weight=\"bold\" font=\"12\" foreground=\"red\">Salir</span>"

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

opcion1="<span weight=\"bold\" font=\"12\" foreground=\"red\">Gestion de Permisos</span>"
opcion2="<span weight=\"bold\" font=\"12\" foreground=\"red\">Tareas Pogramadas</span>"
opcion3="<span weight=\"bold\" font=\"12\" foreground=\"red\">Borrar Ficheros y Carpetas</span>"
opcion4="<span weight=\"bold\" font=\"12\" foreground=\"red\">Recuperar Ficheros</span>"
opcion5="<span weight=\"bold\" font=\"12\" foreground=\"red\">Salir</span>"

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




	


