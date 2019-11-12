module.exports = class Routes {
    constructor(app) {
        app.get("/", (req, res) => {
            res.end("<h1>Website is working!</h1>");
        });
    }
};
