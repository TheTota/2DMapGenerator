/*
  Programme réalisé par Thomas CIANFARANI.
  
  Objectifs : - mieux comprendre le perlin noise en le mettant en application
              - prototyper la génération de map pour le projet ECOSIM
              
  Détails sur la génération : 
 
  Une map ne peut être composée que de 4 type de cases : 
    - Case d'eau
    - Case terrestre produisant de la nourriture
    - Case terrestre ne produisant pas de nourriture
    - Case terrestre présentant un obstacle (inaccessible et pas de nourriture)
  
  L'utilisateur est libre de choisir certains paramètres influant sur la génération :
    - La taille de la map
    - Le % de case d'eau
    - Le % de cases terrestres produisant de la nourriture parmis le nombre de cases terrestres
*/

MapGenerator mg;

void setup() { 
  mg = new MapGenerator(100, 100, .2, .1, .2);
  mg.generateMap();
  mg.displayMap();
}

void draw() {
}

void mousePressed(){
  noiseSeed((int)random(999999));  
  mg.generateMap();
  mg.displayMap();
}
