chrome.webRequest.onBeforeRequest.addListener(
  redirectDailyMail,
  {
    urls: [
      "http://www.dailymail.co.uk/*",
    ],
    types: ['main_frame']
  },
  # extraInfoSpec
  ["blocking"]
)

onRequest = (request, sender, sendResponse) ->
    chrome.pageAction.show(sender.tab.id)
    sendResponse({})

chrome.extension.onRequest.addListener(onRequest)

