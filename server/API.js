module.exports = class API {
    constructor(app, config) {
        const User = new (require("./User"))(config);
        const db = new (require("./Database"))(config);

        async function getTodaysForm(user_id) {
            var today = new Date();
            var form = await db.query_one(
                "SELECT * FROM forms WHERE day = ? AND user = ?",
                [
                    `${today.getFullYear()}-${today.getMonth() +
                        1}-${today.getDate()}`,
                    user_id
                ]
            );
            form.comments = JSON.parse(form.comments);
            return form;
        }

        // APP API
        app.post("/api/profile", async (req, res) => {
            var req = this.parseRequest(req);
            var user = await User.get(req.id);
            var initialSubmission = false;

            if (!user) {
                this.respond(res, false);
                return;
            }

            // See if form exists today for this user.
            var form = await getTodaysForm(user.id);

            if (!form) {
                initialSubmission = true;
                // Form does not exist so create it and then retreive it.
                await db.query(
                    "INSERT into forms (day, rating, comments, user) VALUES (?, 0, '[]', ?)",
                    [new Date(), user.id]
                );

                form = await getTodaysForm(user.id);
            }

            if (!form) {
                this.respond(res, false);
                return;
            }

            // Validate input
            if ((req.vote > 3 || req.vote < 0) && typeof req.vote == "number") {
                this.respond(res, false);
                return;
            }

            // Ammount of comments can not exceed 5
            if (typeof req.comments == "object" && req.comments.length > 5) {
                this.respond(res, false);
                return;
            }

            if (!req.special) {
                this.respond(res, false);
                return;
            }

            if (typeof req.notified_staff != "boolean") {
                this.respond(res, false);
                return;
            }

            if (
                typeof req.special.gluten != "boolean" &&
                typeof req.special.veg != "boolean"
            ) {
                this.respond(res, false);
                return;
            }

            // Make sure length of each comment is under 25 characters.
            for (var comment of req.comments) {
                if (comment.length > 25) {
                    this.respond(res, false);
                    return;
                }
            }

            await db.query(
                "UPDATE users SET gluten = ?, veg = ? WHERE id = ?",
                [req.special.gluten, req.special.veg, user.id]
            );

            await db.query(
                "UPDATE forms SET rating = ?, comments = ? WHERE id = ?",
                [req.vote, JSON.stringify(req.comments), form.id]
            );

            console.log(req);

            console.log(
                `[${new Date().getHours()}:${new Date().getMinutes()}:${new Date().getSeconds()}] Food rating ${
                    initialSubmission ? "created" : "updated"
                } by student (${req.vote}/3)`
            );
            this.respond(res);
        });

        app.get("/api/profile", async (req, res) => {
            var req = this.parseRequest(req);
            var profile = await User.getProfile(req.id);

            if (!profile) {
                this.respond(res, false, "Invalid id");
                return;
            }

            var form = await getTodaysForm(profile.id);
            profile.hasForm = form ? true : false;
            /* var user = await User.get(req.id); */
            this.respond(res, true, "success", { profile, form });
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
