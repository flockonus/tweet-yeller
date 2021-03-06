// Generated by CoffeeScript 1.5.0
(function() {
  var existencialMutex, openingEventHandler, readOutLoud;

  chrome.runtime.onMessage.addListener(function(req, sender, res) {
    console.log("speaker got msg", req);
    if (req.shoutStatus) {
      existencialMutex(sender, res);
    }
    if (req.readThose) {
      return readOutLoud(req.readThose, res);
    }
  });

  existencialMutex = function(sender, res) {
    return chrome.tabs.query({
      url: "*://twitter.com/*"
    }, function(tabs) {
      var calculatedResponse;
      if (tabs.length < 2) {
        chrome.pageAction.show(sender.tab.id);
        calculatedResponse = openingEventHandler();
        chrome.tts.speak("tweet yeller, is " + calculatedResponse.command);
        return res(calculatedResponse);
      } else {
        return res({
          msg: 'off'
        });
      }
    });
  };

  readOutLoud = function(messages, res) {
    var i, isMute, msg, say, _i, _len;
    isMute = localStorage.getItem('mute') === 'yes' ? true : false;
    if (isMute) {
      alert('is mute!');
      return false;
    }
    say = function(author, msg) {
      chrome.tts.speak("" + author + " said", {
        'enqueue': true
      });
      return chrome.tts.speak(msg, {
        'enqueue': true
      });
    };
    chrome.tts.speak("You got " + messages.length + " new tweets,");
    for (i = _i = 0, _len = messages.length; _i < _len; i = ++_i) {
      msg = messages[i];
      say(msg.author, msg.text);
      if (i !== messages.length - 1) {
        chrome.tts.speak('next,', {
          'enqueue': true
        });
      } else {
        chrome.tts.speak('.. the end.', {
          'enqueue': true
        });
      }
    }
    return res({
      msg: "reading or whatever"
    });
  };

  openingEventHandler = function() {
    var mute, reply;
    reply = {};
    mute = localStorage.getItem('mute');
    if (!mute) {
      localStorage.setItem('mute', 'no');
      mute = 'no';
    }
    reply.command = mute === 'no' ? 'on' : 'off';
    return reply;
  };

}).call(this);
