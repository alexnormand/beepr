define () ->
  class Beep
    constructor: (options) ->
      @interval  = options.interval
      @iterationCount = options.iterationCount ? -1
      @audio = new Audio

      if @audio.canPlayType 'audio/mp3'
        @file = 'beep.mp3'
      else
        @file = 'beep.ogg'

    play: () ->
      @audio.src = @file
      @audio.load()
      @audio.play()
      @iterationCount--




