chrome.runtime.onMessage.addListener (req,sender,res) ->
  say = (author,msg) ->
    chrome.tts.speak("#{author} said", {'enqueue': true})
    chrome.tts.speak(msg, {'enqueue': true})

  console.log req
  chrome.tts.speak "You got #{req.readThose.length} new tweets,"
  for msg,i in req.readThose 
    say(msg.author, msg.text)
    if i != req.readThose.length - 1
      chrome.tts.speak('next,' , {'enqueue': true})
  res({msg:"reading or whatever"})