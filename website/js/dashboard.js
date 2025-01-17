var restaurants;

var options = {
    olearys: {
        time: "week", // week, month, year, all
        special: "none", // veg, gluten, none
        group: "all" // te16, te17, ee17, ee18..., all
    },
    greek: {
        time: "week", // week, month, year, all
        special: "none", // veg, gluten, none
        group: "all" // te16, te17, ee17, ee18..., all
    }
};

function selectTime(restaurant, time) {
    options[restaurant].time = time;
    downloadDashboard();
}

function downloadDashboard() {
    showLoadingScreen();
    axios.get("/api/dashboard", { params: { token, options } }).then(res => {
        res = res.data;
        if (!res.success) {
            alert(res.text);
        } else {
            hideLoadingScreen();
            updateDashboard(res.restaurants);
            setTimeout(() => {
                restaurants = res.restaurants;
            });
        }
    });
}

window.onload = () => {
    downloadDashboard();
};

function updateDashboard(hotRestaurants) {
    var range = {
        0: "#eb3434",
        2: "#eb344f",
        3: "#eb6534",
        4: "#eba834",
        5: "#f0c032",
        6: "#e3f032",
        7: "#88db35",
        8: "#53db35",
        9: "#32e33e"
    };

    document.getElementById("restaurants-dash").innerHTML = "";

    for (let key in hotRestaurants) {
        let restaurant = hotRestaurants[key];
        let dropdownOptions = "";
        for (let c of restaurant.classes) {
            dropdownOptions +=
                '<a class="dropdown-item" href="#!">' + c + "</a>";
        }

        var timeText = {
            week: "7 dagar",
            month: "30 dagar",
            threemonths: "90 dagar",
            year: "År",
            all: "Allt"
        };

        var timeSelectors = "";
        var timevalue = timeText[options[restaurant.code_name].time];
        for (key in timeText) {
            timeSelectors += `<a class="dropdown-item" href="javascript:selectTime('${restaurant.code_name}', '${key}')">${timeText[key]}</a>`;
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
	
			<p class="mt-0 mb-1 text-center" style="top:12px;position: relative;">Idag (${restaurant.todays_votes} röster)</p>
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

					<div class="dropdown">
						<button id="${restaurant.code_name}-time-selector" class="diet-selector btn btn-primary dropdown-toggle" type="button"
							id="dropdown-olearys" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="${restaurant.code_name}-time-select">
							${timevalue}
						</button>
						<div class="dropdown-menu" aria-labelledby="dropdown-olearys">
						${timeSelectors}
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
            var cancelCircle = false;
            var cancelGraph = false;

            if (restaurants[restaurant.code_name]) {
                if (
                    restaurants[restaurant.code_name].todays_score ==
                    restaurant.todays_score
                ) {
                    cancelCircle = true;
                }
            }

            var color = range[0];
            for (let key in range) {
                if (key > restaurant.todays_score) break;
                color = range[key];
            }
            let bar = new ProgressBar.Circle(
                document.getElementById(`score-meter-${restaurant.code_name}`),
                {
                    strokeWidth: 10,
                    easing: "easeInOut",
                    duration: cancelCircle ? 0 : 1000,
                    color: color,
                    trailColor: "none",
                    trailWidth: 0
                }
            );

            bar.animate(restaurant.todays_score / 10);

            if (!cancelGraph) drawGraph(restaurant);
        }); // Number from 0.0 to 1.0
    }
}

function drawGraph(restaurant) {
    var ctx = document
        .getElementById("chart-" + restaurant.code_name)
        .getContext("2d");
    new Chart(ctx, {
        type: "line",

        data: {
            labels: restaurant.labels,
            datasets: [
                {
                    data: restaurant.data,
                    label: "Poäng",
                    borderColor: restaurant.color,
                    fill: true,
                    backgroundColor: restaurant.dark_color
                }
            ]
        },
        options: {
            legend: {
                display: false
            },
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                yAxes: [
                    {
                        display: true,
                        ticks: {
                            max: 10,
                            beginAtZero: true
                        }
                    }
                ]
            }
        }
    });
}
