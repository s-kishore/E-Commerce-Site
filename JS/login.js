function checkPassword()
{
    pass1 = document.getElementById("pageContent_regis_password");
    pass2 = document.getElementById("pageContent_regis_confirmpass");
    passmatchbox = document.getElementById("pageContent_diff_user");
    submitbtn = document.getElementById("pageContent_regis_submit");

    if(pass1.value == pass2.value)
    {
        submitbtn.disabled = false;
        passmatchbox.setAttribute("class", "alert alert-info info-box hide-elements");
    }
    else
    {
        submitbtn.disabled = true;
        passmatchbox.innerText = "Passwords do not match";
        passmatchbox.setAttribute("class", "alert alert-info info-box show-elements");
    }
}