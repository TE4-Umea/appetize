module.exports = class Routes {
    constructor(app) {
        app.get("/admin", (req, res) => {
            res.sendFile("admin.html", { root: "../website" });
        });

        app.get("/dashboard", (req, res) => {
            res.sendFile("dashboard.html", { root: "../website" });
        });

        app.get("/manage", (req, res) => {
            res.sendFile("manage.html", { root: "../website" });
        });

        app.get("/code", (req, res) => {
            res.sendFile("code.html", { root: "../website" });
        });
    }
};
