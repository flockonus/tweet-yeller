window.TY = {}

# http://developer.chrome.com/extensions/tabs.html#method-getCurrent
# chrome.tabs.getCurrent ->
# chrome.pageAction.show()


TY.lookForNewMessage = () ->
  console.log "tweet yeller checking..."
  areNews = $('.new-tweets-bar:visible')
  return "see ya next loop" if areNews.length < 1
  howMany = $('.new-tweets-bar:visible').data('itemCount')
  areNews.click()
  @collectNewTweets howMany
  

TY.collectNewTweets = (lastN) ->
  lastTweets = $(".stream.home-stream ol li:lt(#{lastN})")
  collected = []
  lastTweets.each (i,el) ->
    msgObj = {}
    jel = $(el)
    msgObj.author = jel.find('.stream-item-header .fullname').text()
    msgObj.text = jel.find('.tweet-text').text()
    collected.push msgObj
  @transmit collected

TY.transmit = (tweetList) ->
  console.log tweetList
  chrome.runtime.sendMessage {readThose:tweetList}, (response)  ->
    console.log(response.msg)

setInterval TY.lookForNewMessage.bind(TY), 1000


# setTimeout ->
#   TY.transmit [{author:"that is me", text: "a very cool one"}]
# , 3000