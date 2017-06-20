# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  current_value = null
  pay_ids = {}
  $('.ui.modal').modal({
      closable: false
      onApprove: (el) ->
        label = $(".ui.label[data-value=#{current_value}]").last()
        value = parseInt($('input[name=amount]')[0].value)
        if value > 0 && value < 1000000
          html = label.html()
          html = html.replace(/(.*)(<i\.*)/, (m, a, b) ->
              "#{a} (#{value})#{b}"
            )
          label.html(html)
          pay_ids[current_value] = value
        else
          $('.ui.dropdown.to').dropdown('remove selected', current_value);
          $('input[name=amount]').val(0)
        current_value = null
      onDeny: (el) ->
        cancel_select()
    })
  $('.ui.dropdown.from').dropdown();
  $('.ui.dropdown.to').dropdown({
      onLabelCreate: (value, text) ->
        $('.ui.modal').modal('show')
        current_value = value
        $(this)
    });
  cancel_select = () ->
    $('input[name=amount]').val(0)
    $('.ui.dropdown.to').dropdown('remove selected', current_value);
    current_value = null

  $('form').submit ->
    valuesToSubmit = {
      from_ids: ($('.ui.dropdown.from > select').val() || [])
      to_ids: ($('.ui.dropdown.to > select').val() || []).map((val) ->
        "#{val},#{pay_ids[parseInt(val)]}"
      )
      name: $('#name').val()
      utf8: '✓'
      authenticity_token: $('[name=authenticity_token]').val()
    }
    $.ajax(
      type: 'POST'
      url: $(this).attr('action')
      data: valuesToSubmit
      dataType: 'JSON'
    ).success (resp) ->
      console.log 'success', json
      return
    .error (resp) ->
      console.log 'error', resp
    false
  return
