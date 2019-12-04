var commentsWrap = document.getElementById("comments-wrap");
var filter = "all";

window.onload = loadComments;

function loadComments() {
    const sentiments = [
        "sentiment_dissatisfied",
        "sentiment_neutral",
        "sentiment_satisfied",
        "sentiment_very_satisfied"
    ];

    axios.get("/api/comments", { params: { token, filter } }).then(res => {
        res = res.data;
        if (res.success) {
            // Load comments
            commentsWrap.innerHTML = "";
            for (var comment of res.comments) {
                var commentTags = "";
                for (var tag of comment.text) {
                    commentTags += `<span class="user-comment">${tag}</span>`;
                }
                commentsWrap.innerHTML += `
<div class="d-flex flex-row comment border border-dark rounded px-3 py-3 mt-5 justify-content-between">
	<div class="emoji-holder d-flex align-items-center">
		<i class="material-icons md-96">${sentiments[comment.rating]}</i>
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
    });
}

function changeDiet(diet) {
    filter = diet;
    loadComments();
}
