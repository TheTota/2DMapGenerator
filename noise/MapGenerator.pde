import java.util.Arrays;

public class MapGenerator {
  
  // % de cases d'eau  
  public float waterTilesPercentage;
  
  // % de cases produisant de la nourriture parmis le nb de cases terrestres  
  public float foodTilesPercentage;
  
  // Couleurs représentant les tiles
  color waterTileColor, foodTileColor, emptyTileColor, obstacleTileColor;
  // Valeur utilisée pour le parcours du perlin noise
  float increment = 0.01;
  
  float[][] noiseValues;
  float[] noiseValuesOneDimension;
  float waterThreshold;
  
  // Constructeur initialisant les paramètres de la génération
  public MapGenerator(int w, int h, float waterPerc, float foodPerc) {
    // Init variables utilisateur
    size(w, h);
    waterTilesPercentage = waterPerc;
    foodTilesPercentage = foodPerc;
    
    // Init variables génération
    noiseValues = new float[w][h];
    noiseValuesOneDimension = new float[w * h];
    waterTileColor = color(52, 207, 235);
    foodTileColor = color(229, 235, 52);
    emptyTileColor = color(156, 114, 9);
    obstacleTileColor = color(125, 125, 125);
  }
  
  // Génère la map à partir des paramètres initialisés
  public void generateMap() {    
    // Init génération
    loadPixels();
    float xoff = 0.0;
    int i = 0;
    
    // Parcours horizontal
    for (int x = 0; x < width; x++) {
      xoff += increment;   // Increment xoff 
      float yoff = 0.0;   // For every xoff, start yoff at 0
      
      // Parcours vertical
      for (int y = 0; y < height; y++) {
        yoff += increment; // Increment yoff           
        float noiseVal = noise(xoff, yoff);
        
        noiseValues[x][y] = noiseVal;
        noiseValuesOneDimension[i] = noiseVal;
        i++;
      }
    }
    
    // Determine thresholds : on trie le tableau à une dimension puis on sélectionne la valeur 
    // à l'index associé au pourcentage de tile de type eau par exemple
    Arrays.sort(noiseValuesOneDimension);
    waterThreshold = noiseValuesOneDimension[(int)(noiseValuesOneDimension.length * waterTilesPercentage)];
   // for (int j = 0; j < noiseValuesOneDimension.length; j++) {
      //println(noiseValuesOneDimension[j]);  
  //  }
  }
  
  // Affiche la map à l'écran
  public void displayMap() {
    // Enregistrement des nouvelles valeurs des pixels
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (noiseValues[x][y] < waterThreshold) {
          pixels[x+y*width] = waterTileColor;
        } 
        else {
          pixels[x+y*width] = emptyTileColor;
        }
          
      }
    }
    
     /*   if (noiseVal < waterTilesPercentage) {
          pixels[x+y*width] = waterTileColor;
        } 
        else if (noiseVal < waterTilesPercentage + .10) {
          pixels[x+y*width] = obstacleTileColor;
        } 
        else if (noiseVal < waterTilesPercentage + .10 + (1 - (waterTilesPercentage + .10)) * foodTilesPercentage) {
          pixels[x+y*width] = foodTileColor;
        }        
        else {
          pixels[x+y*width] = emptyTileColor;
        }*/
    
    // Affichage des pixels
    updatePixels();
  }
  
}
