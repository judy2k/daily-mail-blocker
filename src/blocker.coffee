GUARDIAN_MAP =
    'http://www.dailymail.co.uk/': 'http://www.guardian.co.uk/'
    'http://www.dailymail.co.uk/home/index.html': 'http://www.guardian.co.uk/'

@getTitle = (url) ->
    getArticle = new XMLHttpRequest()
    getArticle.open('GET', url, false)
    getArticle.send(null)

    return @extractTitle(getArticle.responseText)

@extractTitle = (htmlSource) ->
    #parser = new DOMParser()
    #xml = parser.parseFromString(htmlSource, "text/xml")
    xml = document.implementation.createHTMLDocument("");
    xml.body.innerHTML = htmlSource;
    console.log("XML: ", xml)
    # debugger
    # titleText = xml.evaluate('/descendant::title[last()]', xml, null, XPathResult.STRING_TYPE, null).stringValue
    titleText = xml.evaluate('//meta[@name="keywords"]/@content', xml, null, XPathResult.STRING_TYPE, null).stringValue
    console.log("Obtained title:", titleText)
    # War memorial defaced as EDL prepare to march on Downing Street while tensions rise across the country  | Mail Online
    return titleText.replace(/\s*\|\s*Mail Online/, "")

@redirectDailyMail = (info) ->
    console.log("No!!!: " + info.url)
    mapped_url = GUARDIAN_MAP[info.url]
    if mapped_url?
        return {redirectUrl: mapped_url}
    else
        title = getTitle(info.url)
        console.log "Title", title
        console.log "Redirecting to:", "http://www.guardian.co.uk/search?q=#{encodeURIComponent(title)}"
        # http://www.guardian.co.uk/search?q=daily+mail&section=
        return {redirectUrl: "http://www.guardian.co.uk/search?q=#{encodeURIComponent(title)}"}