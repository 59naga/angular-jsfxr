jsfxr= angular.module 'jsfxr',[]
jsfxr.provider '$jsfxr',->
  $get: ->
    require 'jsfxr/jsfxr'
    window.jsfxr

jsfxr.constant 'jsfxr',
  delay:
    default: 50
    space:   50* 1
    comma:   50* 5
    period:  50* 10

  getRandomSound:
    masterVolume:
      0.25

require('./lib/classes') jsfxr
require('./lib/directive') jsfxr
require('./lib/utils') jsfxr