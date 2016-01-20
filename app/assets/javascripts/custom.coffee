$ ->
  console.log 'Start'
  $('.dropdown-toggle').dropdown()

  NProgress.configure
    showSpinner: false
    ease: 'ease'
    speed: 500

$(document).on 'ready page:load', ->
  $('.percentage').easyPieChart()
