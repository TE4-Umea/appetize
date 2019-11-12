module.exports = class Server {
    constructor(config) {
        const http = require("http");
        const bp = require("body-parser");
        const express = require("express");
        const bcrypt = require("bcrypt");
        const fs = require("file-system");
        const db = new (require("./Database"))(config);

        var app = express();
        app.use(express.static("../website"));
        // Use body-parser to read json/type in post / get requests
        app.use(bp.json());
        app.use(
            bp.urlencoded({
                extended: true
            })
        );

        // Register routes
        new (require("./Routes"))(app);
        // Create the server and start it on the port in config.json
        var server = http.createServer(app).listen(config.port);
    }
};
