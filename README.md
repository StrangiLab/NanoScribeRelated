# NanoScribeRelated
**All numbers have unit of micron!!!**
All the files are related to NanoScribe, including GWL scripts auto-generation pipeline(Matlab), past printing scripts(.gwl), and jobhelper files(.gwl)
## PrintingScriptGenerators:
  ### PillarArray: generate a matrix of pillars of size 100*100 
               adjustable params.: matrix size, 
                                 exposure time (controls pillar radius)
                                 pillar height.
  ### Print_helper_function: generate a group of matrixes
               adjustable params.: emin & emax (to facilitate the parameters sweep of pillars).
  ### archimedian_spiral: generate a matrix of archimedian spirals
               note: a and b are parameters for the archimedian spiral (more see [wiki page](https://en.wikipedia.org/wiki/Archimedean_spiral) for achimedian spiral)
  ### circle Array: a matrix of circles
  ### pillars with pause: It is as it reads (pause for an adjustable amount of time between each each pillar)
               created this file as we once hypothesized that there might be some temperature change during the printing that leads to the inconsistency issue. But it turned out that the temperature barely affects the printing.
 
  
