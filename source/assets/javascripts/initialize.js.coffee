(($) ->
  'use strict'
  $body = $('html, body')
  content = $('#js-main').smoothState(
    prefetch: true,
    pageCacheSize: 4,
    onStart:
      duration: 200
      render: (url, $container) ->
        content.toggleAnimationClass 'is-exiting'
        $body.animate scrollTop: 0
        return
  ).data('smoothState')
  return
) jQuery
