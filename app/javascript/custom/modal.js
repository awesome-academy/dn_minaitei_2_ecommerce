$(document).on('click', '.open-modal', function (event) {
  event.preventDefault();

  var userUrl = $(this).attr('href');

  $.ajax({
    url: userUrl,
    method: "GET",
    dataType: "html",
    success: function (response) {
      $(".modal-body").html(response);
    },
    error: function () {
      alert("Error occurred. Please try again later.");
    }
  });

});


$(document).on('click', '#accept-button', function (event) {
  event.preventDefault();
  var modalSubmitButton = document.querySelector("#modal-submit-button");
  modalSubmitButton.addEventListener("click", function () {
    var modalValue = document.getElementById("modal-text-area").value;
    var form_comment = document.getElementById("order-form-comment");
    form_comment.value = modalValue;
    var form = document.getElementById("order-form-accept");
    form.submit();
  });
});

$(document).on('click', '#refuse-button', function (event) {
  event.preventDefault();
  var modalSubmitButton = document.querySelector("#modal-submit-button");
  modalSubmitButton.addEventListener("click", function () {

    var modalValue = document.getElementById("modal-text-area").value;
    var form_comment = document.getElementById("order-form-comment-refuse");
    form_comment.value = modalValue;
    var form = document.getElementById("order-form-refuse");
    form.submit();
  });
});
