var count = 0;
var mcount = 0;
function slideit() {
    var slideimg = ["IMGs/Banner/3.JPG", "IMGs/Banner/1.JPG", "IMGs/Banner/5.JPG", "IMGs/Banner/2.JPG"];
  //  var slideMimg = ["IMGs/Banner/M1.JPG", "IMGs/Banner/m2.JPG"];
    document.getElementById("sldshw").src = slideimg[count];
  //  document.getElementById("mainbanner").src = slideMimg[mcount];
  /*  if (mcount = 1)
        mcount = 0;
    else
        mcount = 1; */

    if (count < 3)
        count++;
    else
        count = 0;
    setTimeout("slideit()", 4000);

}
function loginbtnclick()
{

}