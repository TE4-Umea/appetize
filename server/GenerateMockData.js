console.log("Started...");
console.time("Generated in");

var fs = require("file-system");

var sql = `TRUNCATE users;
TRUNCATE forms;
TRUNCATE classes;

ALTER TABLE users
	MODIFY id INT(10) UNSIGNED;
ALTER TABLE classes
	MODIFY id INT(10) UNSIGNED;
`;

var daysBack = 500;
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
var greekStudents = [];
var olearysStudents = [];
var increment = 1;
var olearysConsensus = [];
var greekConsensus = [];

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

increment = 1;
var classID = 1;
for (var c of classes) {
    for (var i = 0; i < studentsPerClass; i++) {
        sql += `INSERT INTO users (id, appetize_id, veg, gluten, class) VALUES (${increment++}, "APPETIZE_GENERATED", ${Math.random() <
            proOfBeingGluten / 100}, ${Math.random() <
            proOfBeingGluten / 100}, "${classID}");\n`;
        if (c.restaurant == "olearys") {
            olearysStudents.push(increment);
        } else {
            greekStudents.push(increment);
        }
    }
    classID++;
}

/* generateConsensus(greekConsensus);
generateConsensus(olearysConsensus);

function generateConsensus(consensus) {
    for (var i = 0; i < daysBack; i++) {
        consensus[i] =
            i == 0 ? Math.random() * 4 : consensus[i - 1] + Math.random();
        if (consensus[i] > 3) consensus[i] = 3;
        if (consensus[i] < 0) consensus[i] = 0;
    }
}

insertStudentDatas(olearysStudents, olearysConsensus);
insertStudentDatas(greekStudents, greekConsensus);

function insertStudentDatas(group, consensus) {
    for (var student in group) {
        insertStudentData(student, consensus);
    }
} */

for (var i = 0; i < studentsPerClass * classes.length; i++) {
    insertStudentData(i);
}

function insertStudentData(student_id, consensus) {
    var date = new Date();
    for (var i = 0; i < daysBack; i++) {
        if (date.getDay() > 0 && date.getDay() < 6) {
            var comments = [];
            while (Math.random() > 0.5 && comments.length < 5) {
                comments.push(
                    complaints[Math.floor(Math.random() * complaints.length)]
                );
            }

            /* var rating = consensus[i]; */
            var rating = Math.floor(Math.random() * 3) + 1;

            sql += `INSERT INTO forms (day, rating, notified_staff, comments, user) VALUES ("${date.getFullYear()}-${date.getMonth() +
                1}-${date.getDate()}", ${rating}, ${Math.random() >
                0.7}, '${JSON.stringify(comments)}', ${student_id});\n`;
        }
        date.setDate(date.getDate() - 1);
    }
}

sql += `ALTER TABLE users
	MODIFY id INT(10) UNSIGNED AUTO_INCREMENT;
ALTER TABLE classes
	MODIFY id INT(10) UNSIGNED AUTO_INCREMENT;`;

console.timeEnd("Generated in");
fs.writeFileSync("MockData.sql", sql);
console.log("Saved to MockData.sql");
