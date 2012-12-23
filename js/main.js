require({
  paths: {
    cs             : 'libs/requirejs/cs',
    'coffee-script': 'libs/coffee-script',
    fastclick      : 'libs/fastclick',
    countdown      : 'libs/countdown'
  },

  shim: {
    'countdown': {
      exports: 'countdown'
    }
  }

}, ['cs!coffee/main']);

