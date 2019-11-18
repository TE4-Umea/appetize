var data = JSON.parse(decodeURI(location.search.substr(1)));
document.getElementById("class-title").innerText = data.class;
document.getElementById("code").innerHTML =
    Date.now() - data.created > 1000 * 60 * 60
        ? "<span style='color:#ff1f40;'> Kod har tagit slut</span>"
        : data.code;
