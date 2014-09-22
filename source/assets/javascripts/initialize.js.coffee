(($) ->
  "use strict"
  $body = $("html, body")
  content = $("#main").smoothState(
    prefetch: true,
    pageCacheSize: 4,
    onStart:
      duration: 250
      render: (url, $container) ->
        content.toggleAnimationClass "is-exiting"
        $body.animate scrollTop: 0
        return
  ).data("smoothState")
  return
) jQuery
