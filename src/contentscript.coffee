regex = /dailymail.co.uk/;

dailyMailLinkTest = ->
    for anchor in document.getElementsByTagName('a')
        if regex.test(anchor['href'])
            return true
    return false

if dailyMailLinkTest()
    chrome.extension.sendRequest({}, ((response)->));
