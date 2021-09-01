# Colorband Combination Generator

### An R Shiny Electron desktop app

Users are able to generate all possible 4-band combinations using only their available color bands.

![rhwo](/images/rhwo_transparent.png) ![screenshot](/images/app_img_m.png)

*Completed March 11, 2020*

### Setup
You have three avenues of running this app: 

1. Run online: https://lawaltr.shinyapps.io/colorband/
2. Run in R: ```shiny::runApp('colorband/shiny/app.R')```
3. Package and run as a macOS Electron desktop app:
    - Make sure you have all dependencies installed (described in <a href="https://github.com/lawalter/r-shiny-electron-app">my setup guide</a>)
    - In the R terminal, run `cd colorband`
    - Then run `npm install`
    - Run `electron-forge start` to see if the app works
    - And finally, run `electron-forge make` to package the app, now available to you in the out/ folder

### Using the generator
1. Select the colorbands available at your banding station
2. If desired, choose your location from the drop-down
3. Save settings by clicking "Save choices"
    - Your selected colors and location will be remembered if the Shiny app is reloaded or refreshed
    - <b>Note:</b> This doesn't seem to work with the Electron desktop app yet
4. A random band combination will appear in the main panel
    - To generate a new random combination, hit the refresh button
5. To download a complete list of all possible combinations, click the "Download full .csv" button

### References
- This app uses <a href="https://github.com/trestletech/shinyStore">shinyStore</a> to remember your chosen settings
- R Shiny Electron template created by <a href="https://github.com/dirkschumacher/r-shiny-electron">Dirk Shumacher</a>
    - Check out <a href="https://github.com/lawalter/r-shiny-electron-app">my app setup guide</a> using that template
