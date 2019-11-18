module.exports = class Routes {
    constructor(config) {
        this.db = new (require("./Database"))(config);
        const crypto = require("crypto");
        this.hash = () => {
            return crypto.randomBytes(20).toString("hex");
        };
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
