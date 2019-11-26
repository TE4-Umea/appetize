module.exports = class Routes {
    constructor(config) {
        this.db = new (require("./Database"))(config);
        const crypto = require("crypto");
        this.hash = () => {
            return crypto.randomBytes(20).toString("hex");
        };
    }

    async get(appetize_id) {
        var user = await this.db.query_one(
            "SELECT * FROM users WHERE appetize_id = ?",
            appetize_id
        );
        if (user) {
            return user;
        }
        return false;
    }

    async getProfile(appetize_id) {
        var user = await this.get(appetize_id);

        if (!user) return;
        var dbClass = await this.db.query_one(
            "SELECT * FROM classes WHERE id = ?",
            user.class
        );
        if (!dbClass) return;
        user.class = dbClass;
        user.restaurant = user.class.restaurant;
        user.time = user.class.time;
        var lastForm = await this.db.query_one(
            "SELECT * FROM forms where user = ? ORDER BY id DESC",
            user.id
        );

        return user;
    }

    async getAdmin(username, password) {
        var user = await this.db.query_one(
            "SELECT * FROM admins WHERE username = ?",
            username
        );
        if (user && user.password == password) {
            return user;
        }
        return false;
    }

    async getAdminFromToken(token) {
        var token = await this.db.query_one(
            "SELECT * FROM tokens WHERE token = ?",
            token
        );
        if (!token) return false;
        var user = await this.db.query_one(
            "SELECT * FROM admins WHERE id = ?",
            token.user
        );
        return user;
    }

    generateToken() {
        return "APPETIZE_" + this.hash().toUpperCase();
    }

    async saveToken(token, user_id) {
        await this.db.query("INSERT INTO tokens (token, user) VALUES (?, ?)", [
            token,
            user_id
        ]);
    }
};
