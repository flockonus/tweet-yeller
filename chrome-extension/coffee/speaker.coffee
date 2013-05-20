chrome.runtime.onMessage.addListener (req,sender,res) ->
  console.log "speaker got msg", req

  if req.shoutStatus
    existencialMutex sender, res

  if req.readThose
    readOutLoud req.readThose, res


existencialMutex = (sender,res) ->
  chrome.tabs.query {url:"*://twitter.com/*"}, (tabs) ->
    if tabs.length < 2
      chrome.pageAction.show( sender.tab.id )
      calculatedResponse = openingEventHandler()
      chrome.tts.speak "tweet yeller, is #{ calculatedResponse.command }"
      res calculatedResponse
    else
      res(msg:'off')


readOutLoud = (messages, res) ->
  
  isMute = if localStorage.getItem('mute') == 'yes' then true else false
  if isMute
    alert('is mute!')
    return false 

  say = (author,msg) ->
    chrome.tts.speak("#{author} said", {'enqueue': true})
    chrome.tts.speak(msg, {'enqueue': true})

  chrome.tts.speak "You got #{messages.length} new tweets,"
  for msg,i in  messages
    say(msg.author, msg.text)
    if i != messages.length - 1
      chrome.tts.speak('next,' , {'enqueue': true})
    else
      chrome.tts.speak('.. the end.' , {'enqueue': true})
  res({msg:"reading or whatever"})


#
openingEventHandler = () ->
  reply = {}

  mute = localStorage.getItem 'mute'
  unless mute
    localStorage.setItem 'mute', 'no'
    mute = 'no'

  reply.command = if mute == 'no' then 'on' else 'off'

  # deal with runNumber
  #runNumber = localStorage.getItem 'runNumber'

  reply
