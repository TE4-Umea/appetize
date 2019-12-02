window.onload = () => {
    updateDashboard();
};

var restaurantData = {
    restaurants: [
        {
            name: "Greek Grill",
            code_name: "greek",
            classes: ["TE4", "TE17", "TE18"],
            students: 50,
            color: "#5482ff",
            dark_color: "#3b60c4",
            todays_score: 8.5,
            data_class: "",
            data_special: "",
            data: [
                {
                    date: 0,
                    score: 2
                }
            ]
        },
        {
            name: "O'Learys",
            color: "#2d9784",
            dark_color: "#1e695b",
            code_name: "olearys",
            classes: ["ES17", "ES18", "ES19"],
            students: 50,
            todays_score: 3.5,
            data_class: "",
            data_special: "",
            data: [
                {
                    date: 0,
                    score: 2
                }
            ]
        }
    ]
};

function updateDashboard() {
    var range = [
        "#f73939",
        "#f73939",
        "#f7394f",
        "#f78b39",
        "#69c73a",
        "#42eb4a",
        "#42eb4a"
    ];

    for (let restaurant of restaurantData.restaurants) {
        let dropdownOptions = "";
        for (let c of restaurant.classes) {
            dropdownOptions +=
                '<a class="dropdown-item" href="#!">' + c + "</a>";
        }
        document.getElementById(
            "restaurants-dash"
        ).innerHTML += `<div class="row col-12 mt-3">
		<div class="d-flex flex-column mr-3">
			<div id="score-meter-${restaurant.code_name}" style="height: 100;width: 150px;margin-top: -10px;">
				<span class="score"
					style="margin: 0 auto; display: block; position: relative;text-align: center;top:115px;font-size: 60px;">
					${restaurant.todays_score}
			</div>
	
			<p class="mt-0 mb-1 text-center" style="top:12px;position: relative;">Idag (10 röster)</p>
		</div>
		<div class="d-flex flex-column">
			<div class="d-flex flex-row ml-3 mb-0 justify-content-between align-items-start">
				<div>
					<span class="restaurant-tag" style="background: ${restaurant.color};">${restaurant.name}</span>
					<span class="class-statistics">${restaurant.classes.length} Klasser, ${restaurant.students} elever</span>
				</div>
				<button type="button" class="btn btn-primary">Se kommentarer</button>
			</div>
			<div class="chart-placeholder" style="height:200px;display:block;">
				<canvas id="chart-${restaurant.code_name}"></canvas>
			</div>
			<div class="d-flex flex-row">
				<div class="d-flex flex-row" style="margin-top: 20px;">
					<button class="diet-selector btn btn-primary">Alla</button>
					<button class="diet-selector btn btn-outline-primary">Veg</button>
					<button class=" diet-selector btn btn-outline-primary">Gluten</button>
					<button class="diet-selector btn btn-outline-primary">Vanlig</button>
					<span
						style="display: inline-block;position: relative;padding:5px;margin-left: 10px;">Klasser:</span>
					<div class="dropdown">
						<button class="diet-selector btn btn-primary dropdown-toggle" type="button"
							id="dropdown-olearys" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							Alla
						</button>
						<div class="dropdown-menu" aria-labelledby="dropdown-olearys">
							<a class="dropdown-item" href="">Alla klasser</a>
							${dropdownOptions}

						</div>
					</div>
				</div>
				<div class="d-flex flex-row justify-content-center flex-grow-1">
	
				</div>
	
			</div>
		</div>
	</div>
	<div class="separator"></div>`;

        setTimeout(() => {
            let bar = new ProgressBar.Circle(
                document.getElementById(`score-meter-${restaurant.code_name}`),
                {
                    strokeWidth: 10,
                    easing: "easeInOut",
                    duration: 1000,
                    color: range[Math.floor(restaurant.todays_score / 2)],
                    trailColor: "none",
                    trailWidth: 0
                }
            );

            bar.animate(restaurant.todays_score / 10);

            drawGraph(restaurant.code_name);
        }); // Number from 0.0 to 1.0
    }

    /*
     */
}

function drawGraph(restaurant) {
    for (var r of restaurantData.restaurants)
        if (restaurant == r.code_name) restaurant = r;

    var days = restaurant.data;
    /* 
    for (let day of days) {
        row.push([new Date(day.date), day.score]);
    } */

    var ctx = document
        .getElementById("chart-" + restaurant.code_name)
        .getContext("2d");
    new Chart(ctx, {
        type: "line",

        data: {
            labels: [
                "3 Dec",
                "4 Dec",
                "5 Dec",
                "6 Dec",
                "7 Dec",
                "8 Dec",
                "9 Dec",
                "10 Dec",
                "11 Dec",
                "12 Dec",
                "13 Dec",
                "14 Dec",
                "15 Dec",
                "16 Dec",
                "17 Dec",
                "18 Dec",
                "19 Dec",
                "20 Dec",
                "21 Dec",
                "22 Dec",
                "23 Dec",
                "24 Dec",
                "25 Dec",
                "26 Dec",
                "27 Dec",
                "28 Dec",
                "29 Dec",
                "30 Dec",
                "31 Dec",
                "1 Jan",
                "2 Jan",
                "3 Jan",
                "4 Jan",
                "5 Jan",
                "6 Jan",
                "7 Jan",
                "8 Jan",
                "9 Jan",
                "10 Jan",
                "11 Jan",
                "12 Jan",
                "13 Jan",
                "14 Jan",
                "15 Jan",
                "16 Jan",
                "17 Jan",
                "18 Jan",
                "19 Jan",
                "20 Jan",
                "21 Jan"
            ],
            datasets: [
                {
                    data: [
                        "5.99",
                        "6.58",
                        "5.68",
                        "5.70",
                        "5.66",
                        "5.19",
                        "4.66",
                        "5.55",
                        "4.88",
                        "4.28",
                        "4.48",
                        "5.30",
                        "5.86",
                        "6.06",
                        "6.89",
                        "6.16",
                        "7.00",
                        "6.81",
                        "6.85",
                        "6.93",
                        "7.46",
                        "7.51",
                        "7.09",
                        "7.26",
                        "7.78",
                        "7.26",
                        "7.59",
                        "6.66",
                        "6.07",
                        "6.06",
                        "6.49",
                        "7.48",
                        "7.98",
                        "7.82",
                        "7.79",
                        "8.32",
                        "8.75",
                        "9.54",
                        "9.56",
                        "8.92",
                        "8.04",
                        "8.89",
                        "9.56",
                        "9.95",
                        "9.76",
                        "10.00",
                        "9.90",
                        "10.00",
                        "9.02",
                        "9.58"
                    ],
                    label: "Food",
                    borderColor: restaurant.color,
                    fill: true,
                    backgroundColor: restaurant.dark_color
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });
}
