function updateDashboard() {
    var data = {
        restaurants: [
            {
                name: "Greek Grill",
                code_name: "greek",
                classes: 4,
                students: 50,
                todays_score: 5.8,
                data: {
                    all: [
                        {
                            date: "21-12-2019",
                            score: 5.3,
                            food: "Hamgurger"
                        },
                        {
                            date: "22-12-2019",
                            score: 7.3,
                            food: "Pasta"
                        }
                    ],
                    veg: [],
                    gluten: []
                }
            },
            {
                name: "O'Learys",
                code_name: "olearys",
                classes: 4,
                students: 50,
                todays_score: 5.8,
                data: {
                    all: [
                        {
                            date: "21-12-2019",
                            score: 5.3,
                            food: "Hamgurger"
                        },
                        {
                            date: "22-12-2019",
                            score: 7.3,
                            food: "Pasta"
                        }
                    ],
                    veg: [],
                    gluten: []
                }
            }
        ]
    };

    google.charts.load("current", { packages: ["corechart", "line"] });
    google.charts.setOnLoadCallback(drawBasic);

    function drawBasic() {
        var data = new google.visualization.DataTable();
        data.addColumn("number", "Datum");
        data.addColumn("number", "Betyg");

        data.addRows([
            [0, 0],
            [1, 10]
        ]);

        var options = {
            width: 850,
            height: 200,
            tooltip: {
                textStyle: {
                    fontSize: 14
                }
            },

            legend: "none",
            chartArea: {
                left: "5%",
                top: "5%",
                width: "85%",
                height: "85%"
            }
        };

        let charts = document.getElementsByClassName("googleChart");
        for (let i = 0; i < charts.length; i++) {
            let chart = new google.visualization.LineChart(charts[i]);
            chart.draw(data, options);
        }
    }

    var bar = new ProgressBar.Circle(document.getElementById("score-meter"), {
        strokeWidth: 10,
        easing: "easeInOut",
        duration: 1000,
        color: "#29e357",
        trailColor: "none",
        trailWidth: 0
    });

    bar.animate(0.87); // Number from 0.0 to 1.0
}
