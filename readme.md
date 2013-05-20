# hipaw chrome extension

## manifest.json
This is the equipvalent of package.json, which specify how to bootstrap the extension and various configs

## /coffee && /stylus
Once you run `make` in the repo's root, Grunt will be started as a background process. Grunt will watch `../coffee` and `/stylus` and auto-compile into ``../package/js` and `/package/css` appropriately.

Sometime, Grunt process will crash due to unbarable bad syntax in the stylus file you're working on. In that case, you can start grunt again by itself by running `grunt` in `/app`