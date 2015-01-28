do($ = jQuery) ->
  "use_strict"

  class TabSlider extends MV.AbstractModule
    defaults = 
      debug: 0

    # EVENTS
    ##################################
    onArrowClick = (ev)->
      @log 'onArrowClick()', 2
      ev.preventDefault()
      target = @getTarget ev
      @log '  > target = ', 3, target

      if target.hasClass 'nav-tabs--arrow__prev'
        @prev()
      else if target.hasClass 'nav-tabs--arrow__next'
        @next()
      return
    
    onTransitionEnd = (ev)->
      @log 'onTransitionEnd()', 2
      @log '  > ev = ', 3, ev
      ev.stopPropagation()
      if $(ev.target).is(@$selector)
        bindClick.call @
        loadArrows.call @
      return

    unbindClick = ()->
      @log 'unbindClick()', 2
      @$wrapper.off 'click.tabSlider'
      return

    bindClick = ()->
      @log 'bindClick()', 2
      @$wrapper.on 'click.tabSlider', '.nav-tabs--arrow', onArrowClick.bind(@)
      return

    onResize = (ev)->
      resizeTabsList.call @
      loadArrows.call @
      return

    # UTILS
    ##################################
    getTabs = ()->
      @log 'getTabs()', 2
      list = []

      @$selector.children 'li'
        .each (id, el)->
          list.push new MV.Tab(el)
          return

      return list

    checkPosition = (type)->
      @log 'checkPosition()', 2
      @log '  > type = ', 4, type
      position = @getPosition()
      @log '  > position = ', 3, position

      if type == 'prev' and position < 0
        return true
      else if type == 'next'        
        wrapperWidth = @$selector.closest '.nav-tabs--list-wrap'
          .innerWidth()
        @log '  > wrapperWidth = ', 4, wrapperWidth

        listWidth = @$selector.width() - 1 # hack 1px
        @log '  > listWidth = ', 4, listWidth
        maxPosition = listWidth - wrapperWidth
        @log '  > maxPosition = ', 4, maxPosition
        if Math.abs(position) < maxPosition
          return true
      
      return false

    slide = (nb)->
      @log 'slide()', 2
      position = @getPosition()
      @log '  > position = ', 3, position
      order = if nb > 0 then  1 else -1
      nb    = Math.abs nb

      for i in [0..nb-1]
        do ()=>
          position += -order * @tabs[i].getWidth() 
      
      @log '  > new position = ', 3, position

      if @transitionEndEventName
        @$selector.css 'left', position + 'px'
      else 
        @$selector.animate
          'left': position+'px'
        , 400, ()=>
          loadArrows.call @
      return
      
    reorderTabs = (nb)->
      @log 'reorderTabs()', 2
      order = if nb > 0 then  1 else -1
      nb    = Math.abs nb

      for i in [0..nb-1]
        do ()=>
          if order == 1 
            tab = @tabs.shift()
            @tabs.push tab
          else
            tab = @tabs.pop()
            @tabs.unshift tab

      @log '  > tabs = ', 4, @tabs
      return

    hide = (el)->
      el.addClass 'nav-tabs--arrow__hidden'
      return

    show = (el)->
      el.removeClass 'nav-tabs--arrow__hidden'
      return

    loadArrows = ()->
      if !checkPosition.call @, 'prev'
        hide.call @, @$wrapper.children('.nav-tabs--arrow__prev')
      else
        show.call @, @$wrapper.children('.nav-tabs--arrow__prev')


      if !checkPosition.call @, 'next'
        hide.call @, @$wrapper.children('.nav-tabs--arrow__next')
      else
        show.call @, @$wrapper.children('.nav-tabs--arrow__next')

    changePosition = (type)->
      @log 'changePosition()', 2
      unbindClick.call @

      switch type
        when 'prev'
          reorderTabs.call @, -1
          slide.call @, -1
          # show.call @, @$wrapper.children('.nav-tabs--arrow__prev')
        when 'next'
          slide.call @, 1
          reorderTabs.call @, 1
          # show.call @, @$wrapper.children('.nav-tabs--arrow__next')

    resizeTabsList = ()->
      @$selector.css
        "width" : @getWidth()
        "position" : "relative"
        "left": "0px"


    # PUBLIC
    ##################################
    constructor: (@selector, options = {})->
      super defaults, options, @constructor.name

      @$selector = $ @selector
      return @log("no selector") && false if @$selector.length == 0 

      @$wrapper = @$selector.closest '.nav-tabs--wrap'

      @setup()
      @events()

    setup: ()->
      super
      @tabs = getTabs.call @
      @transitionEndEventName = MV.utils.transitionEndEventName()
      resizeTabsList.call @
      loadArrows.call @

    events: ()->
      super

      $ window
        .on 'resize', onResize.bind(@)

      if @transitionEndEventName
        @$selector.on @transitionEndEventName, onTransitionEnd.bind(@)

      bindClick.call @
      return

    getPosition: ()->
      @log 'getPosition()', 2
      parseInt @$selector.css('left'), 10

    getWidth: ()->
      @log 'getWidth()', 2
      fullWidth = 1 #hack 1px more
      $.each @tabs, (id, el)=>
        width = el.getWidth()
        @log '  > Item width = ', 3, width
        fullWidth += width
        return

      @log '  > width = ', 3, fullWidth
      return fullWidth

    prev: ()->
      @log 'prev()', 2
      if checkPosition.call @, 'prev'
        changePosition.call @, 'prev'
      else
        @log('  > (position < minPosition)', 3)
      return

    next: ()->
      @log 'next()', 2
      if checkPosition.call @, 'next'
        changePosition.call @, 'next'
      else
        @log('  > (position > maxPosition)', 3)
      return


  window.MV?= {}
  window.MV.TabSlider = TabSlider
