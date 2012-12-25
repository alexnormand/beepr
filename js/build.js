({

  baseUrl: "./",
  stubModules: ['cs'],
  //dir: "js",

  paths: {
    cs             : "libs/requirejs/cs",
    "coffee-script": "libs/coffee-script",
    fastclick      : "libs/fastclick",
    countdown      : 'libs/countdown'
  },

  shim: {
    'countdown': {
      exports: 'countdown'
    }
  },

  modules: [
    {
      name: "main",
      exclude: ['coffee-script']
    }
  ]

})