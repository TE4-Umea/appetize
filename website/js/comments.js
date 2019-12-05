var commentsWrap = document.getElementById("comments-wrap");
var filter = "all";
var amount = 100;

window.onload = loadComments;

function loadComments() {
    showLoadingScreen();
    const sentiments = [
        "sentiment_dissatisfied",
        "sentiment_neutral",
        "sentiment_satisfied",
        "sentiment_very_satisfied"
    ];

    var restaurants = {
        olearys: {
            name: "Oleary's",
            code_name: "olearys",
            color: "#2d9784",
            dark_color: "#1e695b"
        },
        greek: {
            name: "Greek grill",
            code_name: "greek",
            color: "#5482ff",
            dark_color: "#3b60c4"
        }
    };

    axios.get("/api/comments", { params: { token, filter } }).then(res => {
        res = res.data;

        if (res.success) {
            // Load comments
            var commentsText = "";

            for (var comment of res.comments) {
                /* var color = ["#eb3434", "#eb6534", "#f0c032", "#32e33e"][
                    comment.rating
                ]; */

                var commentTags = "";
                for (var tag of comment.text) {
                    commentTags += `<span class="user-comment">${tag}</span>`;
                }
                commentsText += `
<div class="d-flex flex-row comment  px-3 py-3 mt-5 justify-content-between comment-box"">
	<div class="emoji-holder d-flex align-items-center">
		<i class="material-icons md-96 simley" style="color:${
            restaurants[comment.restaurant].color
        };">${sentiments[comment.rating]}</i>
	</div>

	<div class="user-comments d-flex flex-column">
		${commentTags}
	</div>

	<div class="answer">
		<button class="btn btn-primary">Svara</button>
	</div>
</div>`;
            }
        } else {
            // Alert with warning why retrieving comments was unsuccessfull
            alert(res.text);
        }
        commentsWrap.innerHTML = commentsText;
        hideLoadingScreen();
    });
}

function changeDiet(diet) {
    filter = diet;
    loadComments();
}
