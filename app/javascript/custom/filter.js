$(document).ready(function() {
  $('.category-checkbox').change(function() {
    var selectedCategories = $('.category-checkbox:checked').map(function() {
      return $(this).val();
    }).get();

    $('#q_category_id_in').val(selectedCategories);
  });

  $('#categoryDropdown').on('show.bs.dropdown', function() {
    $(this).data('clicked', false);
  });

  $('#categoryDropdown').on('hide.bs.dropdown', function(e) {
    if ($(this).data('clicked')) {
      e.preventDefault();
    }
  });

  $('#categoryDropdown').on('click', function() {
    $(this).data('clicked', true);
  });

  $(document).on('click', '.remove-category-btn', function() {
    var categoryId = $(this).data('category-id');
    $('#category_' + categoryId).prop('checked', false);
    $('.category-checkbox').change();
  });
});
