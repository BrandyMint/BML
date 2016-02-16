timeout = 0
interval = null

timer = ($pin_alert) ->
  timeout = @data 'timeout'
  timeout--
  @data 'timeout', timeout

  if timeout <=0
    $('[pin-alert-timeout]').hide()
    $('.pin-alert-base').show()

    clearInterval interval
  else
    $('[pin-alert-seconds]').text I18n.t('js.seconds_count', count: timeout)

activate_timeout = ($pin_alert) ->
  timeout = $pin_alert.data 'timeout'
  return unless timeout > 0
  interval = setInterval timer.bind($pin_alert), 1000

$ ->
  $pin_alert = $ '[pin-alert]'
  activate_timeout $pin_alert if $pin_alert.length > 0
