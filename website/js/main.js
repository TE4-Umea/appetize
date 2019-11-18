var classes;
var token = localStorage.getItem("token");
var restaurants = {
    greek: "Greek grill",
    olearys: "Oleary's"
};

var colors = {
    greek: "rgb(84, 130, 255)",
    olearys: "rgb(45, 151, 132)"
};

window.onload = () => {
    if (token) {
        if (location.pathname == "/manage") loadManeageBoard();
    }
};

function add_class() {
    var name = prompt("Enge namn för nya klassen");
    if (name) {
        axios
            .post("/api/new_class", {
                name,
                token
            })
            .then(res => {
                if (res.data.success) {
                    location.reload();
                } else {
                    alert(res.data.text);
                }
            });
    }
}

function remove_class(id) {
    if (
        confirm(
            "Är du säker på att du vill radera klassen? Alla elever kopplade till klassen kommer termineras och behöva logga in igen med en ny kod!"
        )
    ) {
        axios
            .post("api/delete", {
                token,
                id
            })
            .then(res => {
                if (res.data.success) location.reload();
            });
    }
}

function loadManeageBoard() {
    axios
        .get("/api/manage", {
            params: { token }
        })
        .then(res => {
            var data = res.data;
            classes = data.classes;
            for (let entry of classes) {
                document.getElementById("classes").innerHTML += `
                <div class="class"><b>${entry.name}</b> - ${
                    entry.time
                } - <div class="restaurant" style="background:${
                    colors[entry.restaurant]
                }">${restaurants[entry.restaurant]}</div><br>
                <button onclick="generate_code(${
                    entry.id
                })">GENERERA KOD</button><br>
                <input type="text" placeholder="TID" oninput="change_time(${
                    entry.id
                }, this.value)" value="${entry.time}"><br>
                <input type="radio" oninput="change_restaurant(${
                    entry.id
                }, this.value)" name="restaurant_${entry.name}" value="greek" ${
                    entry.restaurant == "greek" ? "checked" : ""
                }>Greek grill<br>
                <input type="radio" oninput="change_restaurant(${
                    entry.id
                }, this.value)" name="restaurant_${
                    entry.name
                }" value="olearys" ${
                    entry.restaurant != "greek" ? "checked" : ""
                }> Oleary's<br>
                <button onclick="remove_class(${entry.id})">RADERA</button>
                </div>`;
            }
        });
}

function change_time(id, value) {
    axios.post("/api/time", {
        token,
        id,
        value
    });
}

function generate_code(class_id) {
    axios
        .get("/api/code", {
            params: { token, class_id }
        })
        .then(res => {
            if (res.data.success) {
                window.open(res.data.link);
            }
        });
}

function change_restaurant(id, value) {
    axios
        .post("/api/restaurant", {
            token,
            id,
            value
        })
        .then(res => {
            if (res.data.success) location.reload();
        });
}

function login() {
    axios
        .post("/api/login", {
            username: document.getElementById("username").value,
            password: document.getElementById("password").value
        })
        .then(res => {
            var data = res.data;
            if (data.success) {
                localStorage.setItem("token", data.token);
                location.href = "/manage";
            } else {
                document.getElementById("error-message").innerText = data.text;
            }
        });
}
