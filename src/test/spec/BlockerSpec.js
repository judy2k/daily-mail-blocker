describe('blocker', function() {
    var chrome;
    beforeEach(function () {
    });

    describe('getTitle', function() {
        it('should get the correct title for a URL', function () {
            // expect(getTitle("http://www.dailymail.co.uk/home/index.html")).toBe("Home");
            expect(getTitle("http://www.dailymail.co.uk/news/article-2331598/War-memorial-defaced-EDL-prepare-march-Downing-Street-tensions-rise-country.html"))
                .toBe("War memorial vandalised mosque firebombed ugly clashes street Tensions rise slaughter British soldier Lee Rigby");
        });
    });

    describe('extractTitle', function() {
        it('should extract the title from static text', function () {
            expect(extractTitle('<meta name="keywords" content="War memorial defaced as EDL prepare to march on Downing Street while tensions rise across the country  | Mail Online</title></head></html>")).toBe("War memorial defaced as EDL prepare to march on Downing Street while tensions rise across the country"/>'));
            expect(extractTitle('<html><body><meta name="keywords" content="War memorial defaced as EDL prepare to march on Downing Street while tensions rise across the country  | Mail Online</title></head></html>")).toBe("War memorial defaced as EDL prepare to march on Downing Street while tensions rise across the country"/></body></html>'));
        });
    });
});
