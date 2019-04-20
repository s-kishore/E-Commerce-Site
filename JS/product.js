var count = 0;
function addtocart()
{
    if (navigator.cookieEnabled)
    {
        var url = document.URL.split("x=", 8)
        var pid = url[1];
        addtocookie(pid);
        showAddedTocart();
    }
    else{alert("This site requires cookies. Please Enable cookies and try again")}
}

function addtocookie(pid)
{
    var prevdata = getcookie();
    var cval =["data"];
    var data;
    var date = new Date();
    date.setTime(date.getTime() + (365 * 24 * 60 * 60 * 1000));

    if (prevdata != null) {
        cval = prevdata;
        cval[cval.length] = pid;
        data = cval.join("*");
    }
    else data = pid;
    
    var expiry = "expires=" + date.toUTCString();
    document.cookie = "prodid=" + data + ";" + expiry + "; path=/";
}

function getcookie()
{
    var cval = ["data"];
    var name = "prodid=";
    var csplit = document.cookie.split(';');
    if (csplit[0] != "")
    {
        cval[0] = csplit[0].substring(7, csplit[0].length);
        return cval;
    }
    else return null;
}

function mouseonstar(starno)
{
    for(var i=1; i <= starno; i++)
    {
        document.getElementById("pageContent_star" + i).className = "star-highlighted";
    }
}

function mouseoutof(starno)
{
    for(var i=starno; i < 6; i++)
    {
        document.getElementById("pageContent_star" + i).className = "star-blank";
    }
}
function resetstars()
{
    var ratingf = document.getElementById('pageContent_avgrating').value;
    var usrrating = document.getElementById('pageContent_usrrating').value;
    var rating = Math.floor(ratingf);
    var ratingdec = Math.abs(ratingf) - rating;
    for (var i = 1; i <= rating; i++) {
        document.getElementById("pageContent_star" + i).className = "rated-star";
    }
    if (ratingdec != 0) {
        document.getElementById("pageContent_star" + (rating + 1)).className = "half-rated-star";
    }
    if (usrrating != 0 && usrrating != 9) 
    {
        for (i = 1; i <= usrrating; i++) {
            document.getElementById("pageContent_star" + i).className = "star-highlighted";
        }
    }
}
function mouseoverlike()
{
    var button = document.getElementById("pageContent_likebtn");
    var btnclass = button.className;
    if (btnclass == "btn btn-info")
        button.className = "btn btn-default";
    else
        button.className = "btn btn-info";
}
function mouseoutlike() {
    var button = document.getElementById("pageContent_likebtn");
    var btnclass = button.className;
    if (btnclass == "btn btn-info")
        button.className = "btn btn-default";
    else
        button.className = "btn btn-info";
}

function showAddedTocart()
{
    $("#infobox").removeClass("hide-elements")
                 .addClass("alert alert-success show-elements center-block")
                 .delay(5000)
                 .queue(function () {
                     $(this).removeClass("alert alert-success show-elements center-block");
                     $(this).addClass("hide-elements");
                 });

}

function showNeedLogin()
{
    $("#loginND").removeClass("hide-elements")
             .addClass("alert alert-danger alert-dismissible fade-in")
             .delay(10000)
             .queue(function () {
                 $(this).removeClass("alert alert-info alert-dismissible fade-in");
                 $(this).addClass("hide-elements");
             });
}