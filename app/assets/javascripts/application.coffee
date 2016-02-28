# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require tether
#= require nprogress
#= require nprogress-turbolinks
#= require bootstrap-sprockets
#= require turbolinks
#= require react_ujs
#= require i18n
#= require i18n/translations
#= require jquery.easy-pie-chart/dist/jquery.easypiechart.js
#= require better-form
#= require enableWhenChanged
#
# SimpleNavigation
#  require bootstrap_and_overrides
#  require bootstrap_navbar_split_dropdowns


$ ->
  I18n.defaultLocale = gon.i18n.defaultLocale
  I18n.locale        = gon.i18n.locale
  $.ajaxSetup cache: true
