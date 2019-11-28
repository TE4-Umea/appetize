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

    google.charts.load('current', { packages: ['corechart', 'line'] });
    google.charts.setOnLoadCallback(drawBasic);

    function drawBasic() {

        var data = new google.visualization.DataTable();
        data.addColumn('number', 'Datum');
        data.addColumn('number', 'Betyg');

        data.addRows([
            [0, 0], [1, 10], [2, 23], [3, 17], [4, 18], [5, 9],
            [6, 11], [7, 27], [8, 33], [9, 40], [10, 32], [11, 35],
            [12, 30], [13, 40], [14, 42], [15, 47], [16, 44], [17, 48],
            [18, 52], [19, 54], [20, 42], [21, 55], [22, 56], [23, 57],
            [24, 60], [25, 50], [26, 52], [27, 51], [28, 49], [29, 53],
            [30, 55]
        ]);

        var options = {
            width: 800,
            height: 200,
            tooltip: {
                textStyle: {
                    fontSize: 14
                }
            },
            legend: 'none',
            chartArea: {
                left: '5%',
                top: '5%',
                width: '85%',
                height: '85%',
            }

        };

        let charts = document.getElementsByClassName('googleChart');
        for (let i = 0; i < charts.length; i++) {
            let chart = new google.visualization.LineChart(charts[i]);
            chart.draw(data, options);
        }
    }
}

