$ (e)->

  $('#mute-ckb').click ->
    isChecked = $(this).is(':checked')
    if isChecked
      localStorage.setItem 'mute', 'yes'
    else
      localStorage.setItem 'mute', 'no'
    chrome.tabs.reload()
  
  isMute = if localStorage.getItem('mute') == 'yes' then true else false

  # alert(isOn+localStorage.getItem('mute'))
  $('#mute-ckb').prop('checked', isMute );
