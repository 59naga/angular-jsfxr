module.exports= (jsfxr)->
  jsfxr.directive 'jsfxr',(jsfxr,jsfxrUtils)->
    restrict: 'A'
    scope:
      jsfxr:'='
      jsfxrDisabled:'='
    link: (scope,element)->
      text= scope.jsfxr
      return element.text text if scope.jsfxrDisabled

      sound= jsfxrUtils.getSound()

      i= 0
      setTimeout -> type()
      type= ->
        return if text.length < i

        glyph= text[i-1]
        glyphType= jsfxrUtils.getType glyph

        element.text text.slice 0,i++
        sound.play() if glyphType isnt 'space'

        setTimeout type,jsfxr.delay[glyphType]