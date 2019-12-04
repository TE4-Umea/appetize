var commentsWrapper = document.getElementById("comments");

var comments = [
    {
        date: Date.now(),
        score: 1,
        notified_staff: false,
        text: ["Kall mat", "Lång kö"]
    },
    {
        date: Date.now(),
        score: 2,
        notified_staff: true,
        text: ["Kall mat", "Lång kö"]
    },
    {
        date: Date.now(),
        score: 3,
        notified_staff: false,
        text: []
    }
];

for (var i = 0; i < comments.length; i++) {

}

axios.get("http://192.168.2.35:5050/api/comments", { params: { token } })
    .then(res => {
        console.log(res.data);
    })