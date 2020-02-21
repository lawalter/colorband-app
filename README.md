# Making an R Shiny Electron App using macOS via npx

*In progress*

A setup guide by L. Abigail Walter
<br>Instructions adapted from <a href="https://www.travishinkelman.com/post/deploy-shiny-electron/">Travis Hinkelman</a> 
<br>R Shiny Electron template created by <a href="https://github.com/dirkschumacher/r-shiny-electron">Dirk Shumacher</a>

<b>Motivation:</b> In February 2020, I was unable to create an app using an R Shiny Electron template via Dirk Shumaker's <a href="https://github.com/dirkschumacher/r-shiny-electron">original repo</a> or Travis Hinkelman's <a href="https://github.com/hinkelman/r-shiny-electron">fork</a>. I bypassed this issue of ```npm``` reporting dozens of warnings ond vulnerabilities by installing elecron locally with ```npx```.

<b>Objective:</b> Write a comprehensive guide for anyone interested in creating an R Shiny Electron app. This guide assumes the user has intermediate R coding skills, intermediate ability to use the terminal, and little to no experience with JavaScript. 

## Getting started

### Steps to get your computer ready:

1. Install Node: https://nodejs.org/en/
2. Install Electron and Electron Forge using npm (npm is installed with Node)
- In the terminal, type ```install -g electron-forge``` 
- If that didn't work, try ```npm i -g @electron-forge/cli```
- If there's a permission error, run ```sudo npm i -g @electron-forge/cli```
3. Check your versions of node ```node -v``` and npm ```npm -v```. For this guide, I will be using node v13.9.0 and npm v6.13.7. If your installations are ahead and you experience problems with these steps, try downgrading (see [Troubleshooting](#troubleshooting) section below).
4. Open an existing R project or create a new one.
5. Make sure your directory is in R project folder you're ready to turn into an app. Run ```pwd``` on the command line to check what directory you are in. If you're not in the right folder, change your directory using ```cd```
  
## Advanced steps
  
### Start here if you already have node, npm, and electron installed:

6. In your project directory, install electron locally by running: ```npx create-electron-app appNameHere```. Replace appNameHere with whatever you want to name your app.
7. Move or add files to your new app folder, including:
- add-cran-binary-pkgs.R
- get-r-mac.sh
- start-shiny.R
- Make new folder 'shiny' for: 
    - shiny/app.R 
- Delete auto-created contents of folder 'src', and replace with:
    - src/failed.html
    - src/helpers.js
    - src/index.css
    - src/index.js
    - src/loading.css
    - src/loading.html
    - src/main.js
8. Change your directory to your new app folder ```cd appNameHere```
9. Install R locally:
- First, check the version of R on your machine. In the R console, run ```version``` 
- Edit get-r-mac.sh, replacing version numbers in the link ```https://cloud.r-project.org/bin/macosx/R-3.4.2.pkg``` with the version you are running. 
- <b>Important:</b> The R version used to make the shiny app and the version installed locally must match.
- Once you save the file, run the shell script in the terminal ```sh ./get-r-mac.sh``` 
10. Get packages for R that are used in the shiny app by running ```Rscript add-cran-binary-pkgs.R```
11. Add additional dependencies to package.json. Replace the dependencies listed at the end of the script with the following. Take care not to paste over the final ending bracket ```}``` of the .json file.
```      
      "dependencies": {
        "axios": "^0.19.2",
        "electron-squirrel-startup": "^1.0.0",
        "execa": "^4.0.0"
      },
      "devDependencies": {
        "@babel/core": "^7.8.4",
        "@babel/plugin-transform-async-to-generator": "^7.8.3",
        "@babel/preset-env": "^7.8.4",
        "@babel/preset-react": "^7.8.3",
        "@electron-forge/cli": "^6.0.0-beta.49",
        "@electron-forge/maker-deb": "^6.0.0-beta.49",
        "@electron-forge/maker-rpm": "^6.0.0-beta.49",
        "@electron-forge/maker-squirrel": "^6.0.0-beta.49",
        "@electron-forge/maker-zip": "^6.0.0-beta.49",
        "electron": "8.0.1",
        "eslint": "^6.8.0",
        "eslint-config-airbnb": "^18.0.1",
        "eslint-plugin-import": "^2.20.1",
        "eslint-plugin-jsx-a11y": "^6.2.3",
        "eslint-plugin-react": "^7.18.3",
        "eslint-plugin-react-hooks": "^2.4.0",
        "esm": "^3.2.25",
        "fs-extra": "^8.1.0"
      }
```
<b>Note:</b> Modules are updated frequently and as such are subject to changing version numbers. It is important to double-check that these dependencies are up-to-date by replacing their version numbers with any newer version numbers by manually searching the module names on https://www.npmjs.com/

12. Specify the ```"lint": "echo \"No linting configured\""``` line in package.json with ```"lint": "eslint src --color"```
13. Run ```npm install``` to add new dependencies you listed in package.json to the node_modules folder
14. Test to see if your app works by running ```electron-forge start```
15. If it runs, package and create the .exe on the command line with ```electron-forge make```. Your app can be found in the /out folder.

## Troubleshooting {#troubleshooting}

- To change your version of node (i.e. downgrade), install program 'n'. This program will let us downgrade node if there is an issue running it at the most up-to-date version. In the terminal, run ```sudo npm install -g n``` to install and then ```sudo n stable``` to upgrade to the latest version of n. For example, to change to node v10.16.3 run: ```sudo n 13.9.0```


 
