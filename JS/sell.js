
$(document).ready(function () {
    $("#imgbtn").click(function () {
        var url = $("#ursimgurl").val();
        $("<img>", {
            src: url,
            error: function ()
            {
                $("#usrmsg").removeClass("usrmsg-hide");
                $("#usrmsg").addClass("usrmsg-show");
            },
            load: function ()
            {
                $("#usrmsg").removeClass("usrmsg-show");
                $("#usrmsg").addClass("usrmsg-hide");
                $("#pageContent_imgurl").val($("#ursimgurl").val());
                $('#pageContent_prodimg').attr('src', $("#ursimgurl").val());
            }
        });
    });

    var counter = $('#speccount').val();
 
    $("#addButton").click(function () {

        if (counter > 10) {
            alert("Only 10 textboxes allow");
            return false;
        }

        var newTextBoxDiv = $(document.createElement('div'))
             .attr("id", 'TextBoxDiv' + counter);

        newTextBoxDiv.after().html('<label>Textbox #' + counter + ' : </label>' +
              '<input type="text" name="textbox' + counter +
              '" id="textbox' + counter + '" value="" >');

        newTextBoxDiv.appendTo("#TextBoxesGroup");


        counter++;
    });
});


function createNewField() {
    var text = '<input runat="server" type="text" id="spectitle#"> </input><br/>';
    var count = $('#speccount').val();
    count = count + 1;
    $('#speccount').val = count;
    $('#specsbox').append(text.replace('#', count));
}
