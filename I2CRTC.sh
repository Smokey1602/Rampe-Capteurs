#!/bin/bash

#Commentaires : 
	# la ligne $((variable)) permet de transformer la variable hexadécimale en variable decimale
	# la concaténation `commande` permet de récupérer la valeur retournée par la commande décrite 
seconde=$((`i2cget -y 1 0x32 0x00`))
minute=$((`i2cget -y 1 0x32 0x01`))
heure=$((`i2cget -y 1 0x32 0x02`))
jour=$((`i2cget -y 1 0x32 0x04`))
mois=$((`i2cget -y 1 0x32 0x05`))
annee=$((`i2cget -y 1 0x32 0x06`))

#on va tester chacun des points et convertir sa valeur exadécimale en valeur décimale
#pour les secondes :
if [ $seconde -gt 79 ]
then
Tsec=50
elif [ $seconde -gt 63 ]
then
Tsec=40
elif [ $seconde -gt 47 ]
then
Tsec=30
elif [ $seconde -gt 31 ]
then
Tsec=20
elif [ $seconde -gt 15 ]
then
Tsec=10
fi
Tsec=$(($Tsec+$seconde%16))

#pour les minutes :
if [ $minute -gt 79 ]
then
Tmin=50
elif [ $minute -gt 63 ]
then
Tmin=40
elif [ $minute -gt 47 ]
then
Tmin=30
elif [ $minute -gt 31 ]
then
Tmin=20
elif [ $minute -gt 15 ]
then
Tmin=10
fi
Tmin=$(($Tmin+$minute%16))

#pour les heures :
if [ $heure -gt 31 ]
then
Theure=20
elif [ $heure -gt 15 ]
then
Theure=10
fi
Theure=$(($Theure+$heure%16))

#pour les jours :
if [ $jour -gt 31 ]
then
Tjour=20
elif [ $jour -gt 15 ]
then
Tjour=10
fi
Tjour=$(($Tjour+$jour%16))

#pour les mois :
if [ $mois -gt 15 ]
then
Tmois=10
fi
Tmois=$(($Tmois+$mois%16))

#pour les années :
if [ $annee -gt 143 ]
then
Tannee=90
elif [ $annee -gt 127 ]
then
Tannee=80
elif [ $annee -gt 111 ]
then
Tannee=70
elif [ $annee -gt 95 ]
then
Tannee=60
elif [ $annee -gt 79 ]
then
Tannee=50
elif [ $annee -gt 63 ]
then
Tannee=40
elif [ $annee -gt 47 ]
then
Tannee=30
elif [ $annee -gt 31 ]
then
Tannee=20
elif [ $annee -gt 15 ]
then
Tannee=10
elif [ $annee -gt 31 ]
then
Tannee=10
fi
Tannee=$(($Tannee+$annee%16))

heureout=$(printf '%d:%d:%d' "$Theure" "$Tmin" "$Tsec")



if [ $Tmois -lt 10 ] && [ $Tjour -lt 10 ]
then
	dateout=$(printf '20%d0%d0%d' "$Tannee" "$Tmois" "$Tjour")
elif [ $Tmois -lt 10 ]
then
	dateout=$(printf '20%d0%d%d' "$Tannee" "$Tmois" "$Tjour")
elif [ $Tjour -lt 10 ]
then
	dateout=$(printf '20%d%d0%d' "$Tannee" "$Tmois" "$Tjour")
else
	dateout=$(printf '20%d%d%d' "$Tannee" "$Tmois" "$Tjour")
fi

echo $dateout

date --set=$dateout
date --set=$heureout