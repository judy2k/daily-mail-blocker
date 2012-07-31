chrome.webRequest.onBeforeRequest.addListener(
    (info) ->
        console.log("No!!!: " + info.url);
        return {redirectUrl: 'http://www.theguardian.co.uk'}
  ,
  {
    urls: [
      "http://www.dailymail.co.uk/*",
    ],
    types: ['main_frame']
  },
  # extraInfoSpec
  ["blocking"]);
