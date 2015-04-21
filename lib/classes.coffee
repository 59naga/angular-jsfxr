order= [
  'waveType'
  'attackTime'
  'sustainTime'
  'sustainPunch'
  'decayTime'
  'startFrequency'
  'minFrequency'
  'slide'
  'deltaSlide'
  'vibratoDepth'
  'vibratoSpeed'
  'changeAmount'
  'changeSpeed'
  'squareDuty'
  'dutySweep'
  'repeatSpeed'
  'phaserOffset'
  'phaserSweep'
  'lpFilterCutoff'
  'lpFilterCutoffSweep'
  'lpFilterResonance'
  'hpFilterCutoff'
  'hpFilterCutoffSweep'
  'masterVolume'
]

AudioContext= (window.AudioContext or window.webkitAudioContext)
audioContext= new AudioContext

module.exports= (jsfxr)->
  jsfxr.factory 'Jsfxr',(Sound,$jsfxr)->
    generate= (params)->
      values= []
      values.push params[name] for name in order

      $jsfxr values

    class Jsfxr extends Sound
      constructor: (params)->
        @decode generate params if params?
      regenerate: (params)->
        @decode generate params

    Jsfxr

  jsfxr.factory 'Sound',->
    class Sound
      constructor: (datauri)->
        @decode datauri if datauri?

      decode: (datauri)->
        @buffer= null
        @autoplay= off

        binary= atob datauri.slice datauri.indexOf(',')+1

        arrayBuffer= new ArrayBuffer binary.length
        data= new Uint8Array arrayBuffer
        data[i]= binary.charCodeAt i for i in [0..binary.length]

        audioContext.decodeAudioData arrayBuffer,(buffer)=>
          @buffer= buffer
          @play() if @autoplay

      play: ->
        return if @coolTime?
        return @autoplay= on unless @buffer?

        source= audioContext.createBufferSource();
        source.buffer= @buffer
        source.connect audioContext.destination
        source.start 0
    Sound