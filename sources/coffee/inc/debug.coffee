do($ = jQuery) ->
  "use_strict"

  class Debug
    defaults =
      level: 1
      titleCSS: 'color: #8f0000; font-weight: bold'

    log: (msg, level, data...)->
      title = '%c '+@constructor.name+' >>'
      if typeof level == "undefined"
        level = defaults.level
      else if isNaN(level) and data.length == 0
        data = [level]
        level = defaults.level 

      if @options.debug >= level
        if data.length == 0
          data = ''
        else if data.length == 1
          data = data[0]
          
        console.log title, defaults.titleCSS, level, msg, data 
      return

    error: (msg)->
      console.error title, defaults.titleCSS, level, msg
      return

  window.MV?= {}
  window.MV.Debug = Debug