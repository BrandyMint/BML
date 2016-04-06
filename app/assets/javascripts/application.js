import './csrf-token.js'
import './enableWhenChanged'
import './leadsFilter.js'
import './rehover.coffee'
import './better-form.js'

$( () => {
  I18n.defaultLocale = gon.i18n.defaultLocale;
  I18n.locale        = gon.i18n.locale;

  Bugsnag.notifyReleaseStages = ["production"];

  NProgress.configure({
    showSpinner: false,
    ease: 'ease',
    speed: 500,
  });

  $.ajaxSetup({ cache: true });

  // Move modal to body
  // Fix Bootstrap backdrop issu with animation.css
  // $('.modal:not([data-reactid])').appendTo("body")
});

const rebind = () => {
  $('.dropdown-toggle').dropdown();
  $('[tooltip]').tooltip({ container: "body" });
}

$(document).on('ready page:load', rebind);
