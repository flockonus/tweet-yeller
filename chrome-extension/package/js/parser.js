// Generated by CoffeeScript 1.5.0
(function() {

  window.TY = {};

  TY.lookForNewMessage = function() {
    var areNews, howMany;
    console.log("tweet yeller checking...");
    areNews = $('.new-tweets-bar:visible');
    if (areNews.length < 1) {
      return "see ya next loop";
    }
    howMany = $('.new-tweets-bar:visible').data('itemCount');
    areNews.click();
    return this.collectNewTweets(howMany);
  };

  TY.collectNewTweets = function(lastN) {
    var collected, lastTweets;
    lastTweets = $(".stream.home-stream ol li:lt(" + lastN + ")");
    collected = [];
    lastTweets.each(function(i, el) {
      var jel, msgObj;
      msgObj = {};
      jel = $(el);
      msgObj.author = jel.find('.stream-item-header .fullname').text();
      msgObj.text = jel.find('.tweet-text').text();
      return collected.push(msgObj);
    });
    return this.transmit(collected);
  };

  TY.transmit = function(tweetList) {
    console.log(tweetList);
    return chrome.runtime.sendMessage({
      readThose: tweetList
    }, function(response) {
      return console.log(response.msg);
    });
  };

  setInterval(TY.lookForNewMessage.bind(TY), 1000);

}).call(this);
