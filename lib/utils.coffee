module.exports= (jsfxr)->
  jsfxr.factory 'jsfxrUtils',(Jsfxr,jsfxr)->
    getType= (glyph)->
      return 'default' if typeof glyph isnt 'string'

      return 'space' if glyph.match /[ 　]/
      return 'comma' if glyph.match /[,、?？]/
      return 'period' if glyph.match /[.。!！]/
      return 'default'

    sound= null
    setSound= (data)->
      sound= data
    getSound= ->
      sound or getRandomSound()
    getRandomSound= ->
      new Jsfxr
        waveType:
          0
        sustainTime:
          0.05+0.05*Math.random()
        decayTime:
          0.10+0.10*Math.random()
        startFrequency:
          0.10+0.40*Math.random()
        slide:
          0.10+0.10*Math.random()
        lpFilterCutoff:
          1
        masterVolume:
          jsfxr.getRandomSound.masterVolume

    {getType,setSound,getSound,getRandomSound}