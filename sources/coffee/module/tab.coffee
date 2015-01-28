do($ = jQuery) ->
  "use_strict"

  class Tab extends MV.AbstractModule
    defaults = 
      debug: 0

    constructor: (@selector, options = {})->
      super defaults, options, @constructor.name

      @$selector = $ @selector
      return @log("no selector") && false if @$selector.length == 0 

      @setup()
      @events()

    getWidth : ()->
      @log 'getWidth', 2
      return @$selector.outerWidth true

    getHeight : ()->
      @log 'getHeight', 2
      return @$selector.outerHeight true

  window.MV?= {}
  window.MV.Tab = Tab
