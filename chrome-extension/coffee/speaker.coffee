chrome.runtime.onMessage.addListener (req,sender,res) ->
  say = (author,msg) ->
    chrome.tts.speak("#{author} said", {'enqueue': true})
    chrome.tts.speak(msg, {'enqueue': true})

  console.log req
  say "You got #{req.readThose.length} new tweets,", " "
  for msg in req.readThose 
    say(msg.author, msg.text)
  res({msg:"reading or whatever"})