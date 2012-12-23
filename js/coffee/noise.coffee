define () ->

  extend = (obj, mixin) ->
    obj[name] = method for name, method of mixin
    obj


  class Noise
    constructor: (options) ->
      options = extend @defaults, options
      uri = undefined
      localStorageSupported = undefined
      cachedUri = false
      try
        localStorageSupported = true
        cachedUri = localStorage.getItem(window.JSON.stringify(options))
      catch e
        localStorageSupported = false

      # Use localStorage cache if these options have been used before
      if cachedUri
        uri = cachedUri
      else
        canvas = document.createElement("canvas")

        # Use fallback image if canvas isn't supported
        unless canvas.getContext
          uri = options.fallback
        else
          canvas.width = canvas.height = options.size
          ctx = canvas.getContext("2d")
          imgData = ctx.createImageData(canvas.width, canvas.height)
          numPixels = Math.round(options.intensity * Math.pow(options.size, 2))
          maxAlpha = 255 * options.opacity

          # Add color to random pixels in the canvas
          while numPixels-- # Read about the double bitwise NOT trick here: goo.gl/6DPpt
            x = ~~(Math.random() * canvas.width)
            y = ~~(Math.random() * canvas.height)
            index = (x + y * imgData.width) * 4
            colorChannel = numPixels % 255 # This will look random enough
            imgData.data[index] = colorChannel # red
            imgData.data[index + 1] = (if options.monochrome then colorChannel else ~~(Math.random() * 255)) # green
            imgData.data[index + 2] = (if options.monochrome then colorChannel else ~~(Math.random() * 255)) # blue
            imgData.data[index + 3] = ~~(Math.random() * maxAlpha) # alpha
          ctx.putImageData imgData, 0, 0
          uri = canvas.toDataURL("image/png")

        localStorage.setItem window.JSON.stringify(options), uri  if window.JSON and localStorageSupported

      options.elt.style.backgroundImage =  "url('" + uri + "')"

    defaults:

      # How many percent of the image that is filled with noise,
      #   represented by a number between 0 and 1 inclusive
      intensity: 0.9

      # The width and height of the image in pixels
      size: 200

      # The maximum noise particle opacity,
      #   represented by a number between 0 and 1 inclusive
      opacity: 0.08

      # Specifies wheter the particles are grayscale or colorful
      monochrome: false




