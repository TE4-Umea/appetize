// Run this with node

var days = 50;
var change = 1;

var day = new Date();

var max = 10;
var min = 0;
var val = 5;

var labels = [];
var data = [];

var months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
];

for (var i = 0; i < days; i++) {
    val += Number(Math.random() * change * 2 - change);
    if (val > 10) val = 10;
    if (val < 0) val = 0;
    day.setDate(day.getDate() + 1);
    data.push(val.toFixed(2));
    labels.push(day.getDate() + " " + months[day.getMonth()].substr(0, 3));
}

console.log(`
LABELS: ${JSON.stringify(labels)}
 - - - - - - - 
DATA: ${JSON.stringify(data)}
`);
