import java.util.*;

public class MapGenerator {
  
  // % de cases d'eau  
  public float waterTilesPercentage;
  
  // % de cases obstacles (pas accessible et ne produit pas de nourriture) parmis le nb de cases terrestres
  public float obstacleTilesPercentage;
  
  // % de cases produisant de la nourriture parmis le nb de cases terrestres restantes
  public float foodTilesPercentage;
  
  // Couleurs représentant les tiles
  color waterTileColor, foodTileColor, emptyTileColor, obstacleTileColor;
  // Valeur utilisée pour le parcours du perlin noise
  float increment = 0.01;
  
  // Stockage des valeurs obtenues avec perlin noise dans des tableaux 1d et 2d
  float[][] noiseValues;
  float[] noiseValuesOneDimension;
  
  // Stockage des valeurs qui seront déterminées pour seuiller les valeurs de noise obtenues
  float waterThreshold;
  
  ArrayList<Float> obstacleTiles, foodTiles;
  
  // Constructeur initialisant les paramètres de la génération
  public MapGenerator(int w, int h, float waterPerc, float obstaclesPerc, float foodPerc) {
    // Init variables utilisateur
    size(w, h);
    waterTilesPercentage = waterPerc;
    foodTilesPercentage = foodPerc;
    obstacleTilesPercentage = obstaclesPerc;
    
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
    
    // eau
    int waterThresholdIndex = (int)(noiseValuesOneDimension.length * waterTilesPercentage); // 2000
    waterThreshold = noiseValuesOneDimension[waterThresholdIndex];
    
    // obstacles
    int amountOfObstacleTiles = (int)((noiseValuesOneDimension.length - waterThresholdIndex) * obstacleTilesPercentage);
    obstacleTiles = new ArrayList<Float>();
    for (int o = 0; o < amountOfObstacleTiles; o++) {
      obstacleTiles.add(noiseValuesOneDimension[(int)random(waterThresholdIndex, noiseValuesOneDimension.length)]); 
    }
    
    // nourriture
    int amountOfFoodTiles = (int)((noiseValuesOneDimension.length - waterThresholdIndex) * foodTilesPercentage);
    foodTiles = new ArrayList<Float>();
    for (int f = 0; f < amountOfFoodTiles; f++) {
      foodTiles.add(noiseValuesOneDimension[(int)random(waterThresholdIndex, noiseValuesOneDimension.length)]);
    }
  }
  
  // Affiche la map à l'écran
  public void displayMap() {
    int count = 0;
    // Enregistrement des nouvelles valeurs des pixels
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (noiseValues[x][y] < waterThreshold) {
          pixels[x+y*width] = waterTileColor;
        } 
        // REMARQUE : il faut répartir aléatoirement les obstacles et la nourriture sur les tiles terrestres, attention à ce qu'il n'y en ait pas qui se répètent!
        else if (obstacleTiles.contains(noiseValues[x][y])) {
          pixels[x+y*width] = obstacleTileColor;
        }
        else if (foodTiles.contains(noiseValues[x][y])) {
          count++;
          pixels[x+y*width] = foodTileColor;
        }
        else {
          pixels[x+y*width] = emptyTileColor;
        }          
      }
    }
    println(count);
    // Affichage des pixels
    updatePixels();
  }
  
}
