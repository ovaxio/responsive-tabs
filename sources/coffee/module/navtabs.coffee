do($ = jQuery) ->
  "use_strict"

  class Navtabs extends MV.AbstractModule
    # PRIVATE
    ################################
    defaults = 
      debug: 0
      target: '>li>a'

    bodyWidth = $ 'body'
      .width()

    onTabTouchstart = (ev)->
      @log 'onTabTouchstart()', 2
      target = @getTarget ev
      target.addClass 'touch'
      return

    onTabTouchend = (ev)->
      @log 'onTabTouchend()', 2
      target = @getTarget ev
      target.removeClass 'touch'
      return

    # UTILS
    #--------------

    getTabSlider = ()->
      @log 'getTabSlider()', 2
      el = @$selector[0]
      @log '  > el = ', 3, el
      selector = new MV.TabSlider(el)
      return selector

    createWrapper = ()->
      @log 'createWrapper()', 2
      wrapper = $ '<div>',
        'class': 'nav-tabs--wrap'

      return wrapper

    createListWrapper = ()->
      @log 'createListWrapper()', 2
      wrapper = $ '<div>',
        'class': 'nav-tabs--list-wrap'
      .css 
        'overflow': 'hidden'

      return wrapper

    createArrow = (type)->
      @log 'createArrow()', 2
      @log '  > type', 3, type
      arrow = $ '<div>',
        'class': 'nav-tabs--arrow'

      switch type
        when 'prev'
          arrow.addClass 'nav-tabs--arrow__prev'
            .append $('<span>', 
              'class' :"glyphicon glyphicon-chevron-left", 'aria-hidden':"true"
            )
        when  'next'
          arrow.addClass 'nav-tabs--arrow__next'
            .append $('<span>', 
              'class' :"glyphicon glyphicon-chevron-right", 'aria-hidden':"true"
            )
      return arrow

    getDisplay = ()->
      return @$selector.css 'display'


    # PUBLIC
    ################################
    constructor: (@selector, options = {})->
      super defaults, options, @constructor.name

      @$selector = $ @selector
      return @log("no selector") && false if @$selector.length == 0 

      @setup()
      @events()

    setup: ()->
      super

      if 'none' != getDisplay.call(@)
        wrapper     = createWrapper.call @
        listWrapper = createListWrapper.call @

        @$selector.wrap listWrapper
        listWrapper = @$selector.parent()
        listWrapper.wrap wrapper

        prev = createArrow.call @, 'prev'
        next = createArrow.call @, 'next'

        listWrapper.after next
        listWrapper.before prev
        
        @tabSlider  = getTabSlider.call @
      return

    events: ()->
      super
      @$selector
        .closest '.nav-tabs--wrap'
          .on 'touchstart', @options.target, onTabTouchstart.bind(@)
          .on 'touchend', @options.target, onTabTouchend.bind(@)
          .on 'touchleave', @options.target, onTabTouchend.bind(@)
          .on 'touchcancel', @options.target, onTabTouchend.bind(@)
      return

  window.MV?= {}
  window.MV.Navtabs = Navtabs
