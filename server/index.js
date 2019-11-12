/**
 * ~ Appetizer API ~
 * School food feedback app
 */

const fs = require("file-system");
const mysql = require("mysql");

// Load config
var config = JSON.parse(fs.readFileSync("../config.json", "utf8"));

// Start server
new (require("./Server"))(config);
