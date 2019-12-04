var fs = require("file-system");

var sql = `TRUNCATE users;
TRUNCATE forms;
TRUNCATE classes;

ALTER TABLE users
	MODIFY id INT(10) UNSIGNED;
ALTER TABLE classes
	MODIFY id INT(10) UNSIGNED;
`;

var daysBack = 30;
var studentsPerClass = 18;
var proOfBeingVeg = 10; // %
var proOfBeingGluten = 3; // %
var complaints = [
    "Kall mat",
    "Dåligt med tillbehör",
    "Lång kö",
    "Slut på mat",
    "Hård potatis",
    "Plastig potatis",
    "Jag gillade inte maten"
];
var olearysClasses = "TE17 TE18 TE19 EE17";
var greekClasses = "EE18 EE19 ES17 EE18 EE19";
var classes = [];
var students = [];
var increment = 0;

parseClass(greekClasses, "greek");
parseClass(olearysClasses, "olearys");

function parseClass(str, restaurant) {
    str = str.split(" ");
    for (c of str) {
        classes.push({
            name: c,
            restaurant,
            id: increment++
        });
    }
}

for (var c of classes) {
    sql += `INSERT INTO classes (time, name, restaurant, id) VALUES ("11:20", "${c.name}", "${c.restaurant}", ${c.id});\n`;
}

increment = 0;
var classID = 0;
for (var c of classes) {
    for (var i = 0; i < studentsPerClass; i++) {
        sql += `INSERT INTO users (id, appetize_id, veg, gluten, class) VALUES (${increment++}, "APPETIZE_GENERATED", ${Math.random() <
            proOfBeingGluten / 100}, ${Math.random() <
            proOfBeingGluten / 100}, "${classID}");\n`;
    }
    classID++;
}

// Insert form data
for (let i = 0; i < classes.length * studentsPerClass; i++) {
    insertStudentData(i);
}

function insertStudentData(student_id) {
    var date = new Date();
    for (var i = 0; i < daysBack; i++) {
        var comments = [];
        while (Math.random() > 0.5 && comments.length < 5) {
            comments.push(
                complaints[Math.floor(Math.random() * complaints.length)]
            );
        }
        sql += `INSERT INTO forms (day, rating, notified_staff, comments, user) VALUES ("${date.getFullYear()}-${date.getMonth() +
            1}-${date.getDate()}", ${Math.floor(
            Math.random() * 4
        )}, ${Math.random() > 0.7}, '${JSON.stringify(
            comments
        )}', ${student_id});\n`;
        date.setDate(date.getDate() - 1);
    }
}

sql += `ALTER TABLE users
	MODIFY id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE classes
	MODIFY id INT(10) UNSIGNED AUTO_INCREMENT PRIMARY KEY;`;

fs.writeFileSync("MockData.sql", sql);
