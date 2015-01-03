jQuery ->
  money_fields = $('#project_price')
  money_fields.autoNumeric('init');
  money_fields.keydown (event) ->
    if event.keyCode == 13
      $(this).autoNumeric('set', $(this).autoNumeric('get'))