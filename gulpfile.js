const uswds = require("@uswds/compile");

uswds.settings.version = 3;

uswds.paths.dist.css   = "./app/assets/uswds/css";
uswds.paths.dist.js    = "./app/assets/uswds/js";
uswds.paths.dist.fonts = "./app/assets/uswds/fonts";
uswds.paths.dist.img   = "./app/assets/uswds/img";
uswds.paths.dist.theme = "./sass";

exports.init    = uswds.init;
exports.compile = uswds.compile;
exports.watch   = uswds.watch;
