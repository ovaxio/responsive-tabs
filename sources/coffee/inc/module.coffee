do($ = jQuery) ->
  "use_strict"

  class AbstractModule extends MV.Debug

    constructor: (defaults, options, debugTitle)->
      @constructor.name = debugTitle;
      @options = $.extend true, {}, defaults, options

      @log 'load'
      @log 'constructor', 3, @

    setup: ()->
      @log 'setup', 2
      return

    events: ()->
      target = if @options?.target? then @options.target else ''
      $targets = if @$selector?.find(@options.target) then @$selector.find(@options.target) else @$selector
      @log 'events', 2
      @log 'events on', 3, target, $targets

    getTarget: (ev)->
      return $ ev.currentTarget

  window.MV?= {}
  window.MV.AbstractModule = AbstractModule
