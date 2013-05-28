describe('blocker', function() {
    var chrome;
    beforeEach(function () {
    });

    describe('getTitle', function() {
        it('should get the correct title for a URL', function () {
            expect(getTitle("http://www.dailymail.co.uk/home/index.html")).toBe("Home");
            expect(getTitle("http://www.dailymail.co.uk/news/article-2331598/War-memorial-defaced-EDL-prepare-march-Downing-Street-tensions-rise-country.html"))
                .toBe("War memorial defaced as EDL prepare to march on Downing Street while tensions rise across the country");
        });
    });

    describe('extractTitle', function() {
        it('should run tests', function () {
            expect(extractTitle("<html><head><title>Home | Mail Online</title></head></html>")).toBe("Home");
            expect(extractTitle("<html><head><title>War memorial defaced as EDL prepare to march on Downing Street while tensions rise across the country  | Mail Online</title></head></html>")).toBe("War memorial defaced as EDL prepare to march on Downing Street while tensions rise across the country");
        });
    });
});
