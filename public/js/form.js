$(document).ready(function() {
  var max_fields      = 50; //maximum input boxes allowed
  var wrapper         = $(".input_fields_wrap"); //Fields wrapper
  var add_button      = $(".add_field_button"); //Add button ID

  var x = 1; //initlal text box count
  $(add_button).click(function(e){ //on add input button click
    e.preventDefault();
    if(x < max_fields){ //max input box allowed
      x++; //text box increment
      $(wrapper).append('<div class="jk-ingredients"><input type="text" name="amounts[]" placeholder="Amount" class="form-control jk-amount"><input class="form-control jk-ingredient" type="text" name="ingredients[]" placeholder="Ingredient"/><a href="#" class="remove_field">Remove</a></div>'); //add input box
    }
  });

  $(wrapper).on("click",".remove_field", function(e){ //user click on remove text
    e.preventDefault(); $(this).parent('div').remove(); x--;
  })
});
