window.TY = {}


TY.lookForNewMessage = () ->
  console.log "tweet yeller checking..."
  areNews = $('.new-tweets-bar:visible')
  return "see ya next loop" if areNews.length < 1
  howMany = $('.new-tweets-bar:visible').data('itemCount')
  areNews.click()
  @collectNewTweets howMany
  

TY.collectNewTweets = (lastN) ->
  lastTweets = $(".stream.home-stream .stream-items li.stream-item:lt(#{lastN})")
  collected = []
  # build a nice readable message
  lastTweets.each (i,el) ->
    msgObj = {}
    jel = $(el)
    msgObj.author = jel.find('.stream-item-header .fullname').text()
    textEl = jel.find('.tweet-text').clone()
    textEl.find('a').each (i,a) ->
      ja = $(a)
      if ja.is ".twitter-timeline-link"
        ja.text( "link to " + ja.find(".js-display-url").text().replace(/\..*/g, "") )
    msgObj.text = textEl.text().replace(/\#/g, 'hashtag ').replace(/\@/g, 'at ')
    collected.push msgObj
  @transmit collected

TY.transmit = (tweetList) ->
  console.log tweetList
  chrome.runtime.sendMessage {readThose:tweetList}, (response)  ->
    console.log(response.msg)

pnt = setInterval TY.lookForNewMessage.bind(TY), 1000

claimTabLife = () ->
  chrome.runtime.sendMessage {shoutStatus:true}, (response)  ->
    console.log "claimTabLife", response
    if response.msg == 'off'
      clearInterval pnt
      console.log "turning off for this tab"

setTimeout ->
  # TY.transmit [{author:"that is me", text: "a very cool one"}]
  # TY.collectNewTweets 1
  # debugger
  1
, 3000

claimTabLife()
