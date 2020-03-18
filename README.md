# Colorband Combination Generator

### An R Shiny Electron desktop app

Users are able to generate all possible 4-band combinations using only their available color bands.

![rhwo](/images/rhwo_transparent.png) ![screenshot](/images/app_img_m.png)

*Completed March 11, 2020*

### Setup
- The app is able to run in R or as a macOS desktop app with Electron
    - The R Shiny version: colorband/shiny/app.R
    - To package and run as a macOS R Shiny Electron desktop app:
        - Make sure you have all dependencies installed (described in <a href="https://github.com/lawalter/r-shiny-electron-app">my setup guide</a>)
        - In the R terminal, run `cd colorband`
        - Then run `npm install`
        - Run `electron-forge start` to see if the app works
        - And finally, run `electron-forge make` to package the app, now available to you in the out/ folder

### Usage 
1. Select the colorbands available at your banding station
2. If desired, choose your location from the drop-down
3. Save settings by clicking "Save choices"
    - Your selected colors and location will be remembered if the Shiny app is reloaded or refreshed
4. A random band combination will appear in the main panel
    - To generate a new random combination, hit the refresh button
5. To download a complete list of all possible combinations, click the "Download full .csv" button

### Notes
- R Shiny Electron template created by <a href="https://github.com/dirkschumacher/r-shiny-electron">Dirk Shumacher</a>
    - Check out <a href="https://github.com/lawalter/r-shiny-electron-app">my app setup guide</a> using the above template
- This app uses <a href="https://github.com/trestletech/shinyStore">shinyStore</a> to remember your chosen settings

### Sources
- Flag map state images sourced from Wikimedia Commons. No changes were made.
    - <a href = "https://commons.wikimedia.org/wiki/File:Flag-map_of_Delaware.svg">Delaware</a> <a href="https://creativecommons.org/licenses/by-sa/3.0/deed.en">[license]</a>
    - <a href = "https://commons.wikimedia.org/wiki/File:Flag-map_of_Florida.svg">Florida</a> <a href="https://creativecommons.org/licenses/by-sa/3.0/deed.en">[license]</a>
    - <a href = "https://commons.wikimedia.org/wiki/File:Flag-map_of_Pennsylvania.svg">Pennsylvania</a> <a href="https://creativecommons.org/licenses/by-sa/3.0/deed.en">[license]</a>
    - <a href = "https://commons.wikimedia.org/wiki/File:Flag-map_of_Rhode_Island.svg">Rhode Island</a> <a href="https://creativecommons.org/licenses/by-sa/3.0/deed.en">[license]</a>
    - <a href = "https://commons.wikimedia.org/wiki/File:Flag_map_of_Washington_DC.png">Washington, DC</a> <a href="https://creativecommons.org/licenses/by-sa/3.0/deed.en">[license]</a>
