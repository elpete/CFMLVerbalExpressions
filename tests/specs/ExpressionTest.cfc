/**
* My BDD Test
*/
component extends='testbox.system.BaseSpec' {

	function run() {
		describe('Verbal Expressions', function() {
            beforeEach(function() {
                variables.expression = new models.Expression();
            });

            it('can return a regex string', function() {
                var regex = variables.expression.find('www').toRegex();

                expect('www').toMatch(regex);
            });

            it('finds a string', function() {
                var regex = variables.expression.find('www');

                expect(regex.test('www')).toBeTrue();
            });

            it('finds a string using `then`', function() {
                var regex = variables.expression.then('www');

                expect(regex.test('www')).toBeTrue();
            });

            it('checks for anything', function() {
                var regex = variables.expression.anything();

                expect(regex.test('foo')).toBeTrue();
            });

            it('checks for anything but', function() {
                var regex = variables.expression
                    .find('foo')
                    .anythingBut('bar')
                    .then('biz');

                expect(regex.test('foobazbiz')).toBeTrue();
                expect(regex.test('foobarbiz')).toBeFalse();
            });

            it('checks for something', function() {
                var regex = variables.expression.something();

                expect(regex.test('hi')).toBeTrue();
                expect(regex.test('')).toBeFalse();
            });

            it('checks for something but', function() {
                var regex = variables.expression
                    .find('foo')
                    .somethingBut('bar');

                expect(regex.test('foobiz')).toBeTrue();
                expect(regex.test('foobar')).toBeFalse();
                expect(regex.test('foo')).toBeFalse();
            });

            it('maybe has a value', function() {
                var regex = variables.expression.maybe('http').toRegex();

                expect('http').toMatch(regex);
                expect('').toMatch(regex);
            });

            it('can define the beginning of the line', function() {
                var regex = variables.expression
                    .startOfLine()
                    .then('www');

                expect(regex.test('www.example.com')).toBeTrue();
                expect(regex.test('http://www.example.com')).toBeFalse();
            });

            it('can define the end of the line', function() {
                var regex = variables.expression
                    .find('com')
                    .endOfLine();

                expect(regex.test('www.example.com')).toBeTrue();
                expect(regex.test('www.example.com/endpoint')).toBeFalse();
            });

            it('finds a string using `and`', function() {
                var regex = variables.expression.and('www').toRegex();

                expect('www').toMatch(regex);
            });

            it('finds a string using `finally`', function() {
                var regex = variables.expression.finally('www').toRegex();

                expect('www').toMatch(regex);
            });

            it('allows all the methods to be called prepending `then` or `and`', function() {
                var regex = variables.expression
                    .startOfLine()
                    .find('foo')
                    .and('bar')
                    .thenMaybe('bar')
                    .then('fizz')
                    .thenAnythingBut('baz')
                    .finally('bleh')
                    .andEndOfLine();

                expect(regex.test('foobarfizzbleh')).toBeTrue();
                expect(regex.test('foobarbarfizzbleh')).toBeTrue();

                expect(regex.test('foobarfizzbleheck')).toBeFalse();
                expect(regex.test('foobarfizzbazbleh')).toBeFalse();
            });

            it('can chain method calls', function() {
                var regex = variables.expression
                    .find('foo')
                    .maybe('bar')
                    .then('biz')
                    .toRegex();

                expect('foobarbiz').toMatch(regex);
                expect('foobiz').toMatch(regex);
                expect('foobar').notToMatch(regex);
            });

            it('can test values against itself', function() {
                var regex = variables.expression
                    .find('foo')
                    .maybe('bar')
                    .then('biz');

                expect(regex.test('foobarbiz')).toBeTrue();
                expect(regex.test('foobiz')).toBeTrue();
                expect(regex.test('foobar')).toBeFalse();
            });

            it('properly escapes regex characters', function() {
                var regex = variables.expression
                    .find('www')
                    .maybe('.')
                    .then('example');

                    expect(regex.test('wwwXexample')).toBeFalse()
            });

            it('can match a tab character', function() {
                var regex = variables.expression
                    .find('one')
                    .thenTab()
                    .finally('two');

                expect(regex.test('one	two')).toBeTrue();
                expect(regex.test('one two')).toBeFalse();
            });

            it('can match one or more words', function() {
                var regex = variables.expression.word();

                expect(regex.test('hello')).toBeTrue();
                expect(regex.test('123')).toBeTrue();
                expect(regex.test('(*)')).toBeFalse();
            });

            it('can match any characters provided', function() {
                var regex = variables.expression.anyOf('aeiou');

                expect(regex.test('a')).toBeTrue();
                expect(regex.test('q')).toBeFalse();
            });

            it('can accept an array of any characters provided', function() {
                var regex = variables.expression.anyOf(['a','e','i','o','u']);

                expect(regex.test('a')).toBeTrue();
                expect(regex.test('q')).toBeFalse();
            });

            it('uses `any` as an alias to `anyOf`', function() {
                var regex = variables.expression.any(['a','e','i','o','u']);

                expect(regex.test('a')).toBeTrue();
                expect(regex.test('q')).toBeFalse();
            });

            it('is case sensitive by default', function() {
                var regex = variables.expression.find('Hello');

                expect(regex.test('Hello')).toBeTrue();
                expect(regex.test('hello')).toBeFalse();
            });

            it('can be set to be case insensitive', function() {
                var regex = variables.expression.find('Hello').withAnyCase();

                expect(regex.test('Hello')).toBeTrue();
                expect(regex.test('hello')).toBeTrue();
            });

        });
	}

}
