do($ = jQuery) ->
  "use_strict"

  transitionEndEventName = ()->
    el = document.createElement('div')
    transitions = 
      'OTransition':'otransitionend'
      'MozTransition':'transitionend'
      'WebkitTransition':'webkitTransitionEnd'
      'transition':'transitionend'

    for key,val of transitions
      if transitions.hasOwnProperty(key) && el.style[key] != undefined
        return transitions[key]

    return false


  window.MV?= {}
  window.MV.utils= {}
  window.MV.utils.transitionEndEventName = transitionEndEventName