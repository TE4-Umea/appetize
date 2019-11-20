module.exports = class API {
    constructor(app, config) {
        const User = new (require("./User"))(config);
        const db = new (require("./Database"))(config);

        // APP API
        app.post("/api/profile", async (req, res) => {
            var req = this.parseRequest(req);
            var user = await User.get(req.id);
            this.respond(res);
        });

        app.get("/api/profile", async (req, res) => {
            var req = this.parseRequest(req);
            var profile = await User.getProfile(req.id);

            if (!profile) {
                console.log("Failed login");
                this.respond(res, false, "Invalid id");
                return;
            }
            console.log("Successfull login");
            /* var user = await User.get(req.id); */
            this.respond(res, true, "success", { profile });
        });

        app.post("/api/signup", async (req, res) => {
            var req = this.parseRequest(req);
            var dbCode = await db.query_one(
                "SELECT * FROM codes WHERE code = ?",
                req.code
            );
            if (!dbCode) {
                this.respond(res, false, "Ej giltig kod");
                return;
            }
            var codeAge = Date.now() - new Date(dbCode.created).getTime();
            // If code age is more than one hour, it's not valid.
            if (codeAge > 1000 * 60 * 60) {
                this.respond(res, false, "Koden har gått ut.");
                return;
            } else {
                // Valid code.
                var appetizeID = User.generateToken();
                await db.query(
                    "INSERT INTO users (appetize_id, class) VALUES (?, ?)",
                    [appetizeID, dbCode.class]
                );
                this.respond(res, true, "Success", { id: appetizeID });
                return;
            }
        });

        // ADMIN API

        app.post("/api/login", async (req, res) => {
            var user = await User.getAdmin(
                req.body.username,
                req.body.password
            );

            if (user) {
                var token = User.generateToken();
                await User.saveToken(token, user.id);

                this.respond(res, true, "Success", { token: token });
            } else this.respond(res, false, "Wrong password or username");
        });

        app.get("/api/manage", async (req, res) => {
            var req = this.parseRequest(req);
            var user = await User.getAdminFromToken(req.token);
            if (user) {
                var classes = await db.query("SELECT * FROM classes");

                this.respond(res, true, "Logged in!", {
                    classes
                });
            }
            // TODO add error message to client or redirect
        });

        app.post("/api/new_class", async (req, res) => {
            var req = this.parseRequest(req);
            if (!req.name) return; // TODO add error message to client
            var user = await User.getAdminFromToken(req.token);
            if (!user)
                this.respond(res, false, "Wrong token, go and log in again.");
            else {
                await db.query(
                    'INSERT INTO classes (name, restaurant, time) VALUES (?, "greek", "11:20")',
                    req.name
                );
                this.respond(res); // Success
            }
        });

        app.post("/api/delete", async (req, res) => {
            var req = this.parseRequest(req);
            if (!req.id) return; // TODO add error message to client
            var user = await User.getAdminFromToken(req.token);
            if (!user) return; // TODO add error message to client
            await db.query("DELETE from classes WHERE id = ?", req.id);
            this.respond(res);
        });

        app.post("/api/restaurant", async (req, res) => {
            var req = this.parseRequest(req);
            if (!req.id) return; // TODO add error message to client
            var user = await User.getAdminFromToken(req.token);
            if (!user) return; // TODO add error message to client
            await db.query("UPDATE classes SET restaurant = ? WHERE id = ?", [
                req.value,
                req.id
            ]);
            this.respond(res);
        });

        app.post("/api/time", async (req, res) => {
            var req = this.parseRequest(req);
            if (!req.id) return; // TODO add error message to client
            var user = await User.getAdminFromToken(req.token);
            if (!user) return; // TODO add error message to client
            await db.query("UPDATE classes SET time = ? WHERE id = ?", [
                req.value,
                req.id
            ]);
            this.respond(res);
        });

        app.get("/api/code", async (req, res) => {
            req = this.parseRequest(req);

            var user = await User.getAdminFromToken(req.token);
            if (!user) return; // TODO add error message to client
            var dbClass = await db.query_one(
                "SELECT * FROM classes WHERE id = ?",
                req.class_id
            );
            if (!dbClass) return; // TODO add error message to client
            var code;

            do {
                code = this.generateCode();
            } while (
                await db.query_one("SELECT * FROM codes WHERE code = ?", code)
            );

            await db.query(
                "INSERT into codes (code, creator, class) VALUES (?, ?, ?)",
                [code, user.id, dbClass.id]
            );
            this.respond(res, true, "Created a new code", {
                link:
                    "/code?" +
                    encodeURI(
                        JSON.stringify({
                            code,
                            class: dbClass.name,
                            created: Date.now()
                        })
                    )
            });
        });
    }

    async getClass(id) {
        var dbClass = this.db.query_one(
            "SELECT * FROM classes where id = ?",
            id
        );
        return dbClass;
    }

    generateCode() {
        var code = "";
        for (var i = 0; i < 4; i++) {
            if (Math.random() > 0.5) {
                code += Math.floor(Math.random() * 10).toString();
            } else {
                code += ["A", "B", "C", "D", "E", "F"][
                    Math.floor(Math.random() * 6)
                ];
            }
        }
        return code;
    }

    parseRequest(req) {
        var body = {};
        for (var key in req.query) {
            body[key] = req.query[key];
        }
        for (var key in req.body) {
            body[key] = req.body[key];
        }

        return body;
    }

    respond(res, success = true, text = "", params = {}) {
        var build = {
            success,
            text
        };

        for (let key in params) {
            build[key] = params[key];
        }

        res.json(build);
    }
};
