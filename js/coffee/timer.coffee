define ['fastclick','countdown', 'cs!coffee/beep'], (Fastclick, countdown, Beep) ->

  class Timer
    constructor: (interval, iterationCount) ->
      [].forEach.call document.querySelectorAll('button'), (btn) ->
        new Fastclick(btn)

      @startBtn       = document.getElementById 'start'
      @stopBtn        = document.getElementById 'stop'
      @timer          = document.getElementById 'timer'
      @interval       = document.getElementById 'interval'
      @iterationCount = document.getElementById 'iterationCount'

      @startBtn.addEventListener 'click', @startBtnHandler
      @stopBtn.addEventListener 'click', @stopBtnHandler

      for input in [@interval, @iterationCount]
        input.addEventListener 'keyup', @durationChangeHandler

    updateTimeDisplay: (ts) =>
      @timer.innerHTML = ts.minutes + 'min ' + ts.seconds + 's'
      if @beep and @beep.iterationCount != 0
        if (ts.minutes * 60 + ts.seconds) % @beep.interval == 0
          @beep.play()


    # start button click callback
    startBtnHandler: () =>
      @timerId = countdown new Date(),
                           @updateTimeDisplay,
                           countdown.MINUTES | countdown.SECONDS,
                           2


    # stop button click callback
    stopBtnHandler: () =>
      clearInterval @timerId


    # interval or iteration change callback
    durationChangeHandler: () =>
      @stopBtnHandler()
      iterationCount = @iterationCount.value ? -1
      interval = @interval.value ? 0
      @beep = new Beep({interval: interval, iterationCount: iterationCount})



