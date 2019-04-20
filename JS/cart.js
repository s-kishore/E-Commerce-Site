var count = 0;
function changeshipping() {
    var subtotal = Number(document.getElementById("pageContent_subtotamt").innerHTML);
    var choice = document.getElementsByName("shp-mth");
    var shpamt = 0;
    var chosen;
    for (var i = 0 ; i < 4; i++)
    {
        if(choice[i].checked)
        {
            chosen = choice[i].value;
            break;
        }
    }
    switch (chosen)
    {
        case "regular":
            shpamt=10;
            break;
        case "one-day":
            shpamt = 30;
            break;
        case "two-day":
            shpamt = 25;
            break;
    }
    document.getElementById("pageContent_totamt").innerHTML = subtotal + shpamt;
}

function redirect() {
    location.href = 'login.aspx?redirect=cart.aspx';
}
