# Prototype de génération de map procédurale pour le projet ECOSIM

Programme réalisé par Thomas CIANFARANI.
  
__Objectifs :__ 
- mieux comprendre le perlin noise en le mettant en application
- prototyper la génération de map pour le projet ECOSIM

__Détails sur la génération :__

Une map ne peut être composée que de 4 type de cases : 
  - Case d'eau
  - Case terrestre produisant de la nourriture
  - Case terrestre ne produisant pas de nourriture
  - Case terrestre présentant un obstacle (inaccessible et pas de nourriture)

L'utilisateur est libre de choisir certains paramètres influant sur la génération :
  - La taille de la map
  - Le % de case d'eau
  - Le % de cases terrestres produisant de la nourriture parmis le nombre de cases terrestres
