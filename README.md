# CFMLVerbalExpressions

* Ported from [VerbalExpressions](https://github.com/VerbalExpressions/JSVerbalExpressions)

CFMLVerbalExpressions is a CFML library that helps to construct hard regular expressions;

```cfscript
var regex = new VerbalExpression();

regex.startOfLine()
     .then('http')
     .maybe('s')
     .then('://')
     .maybe('www.')
     .anythingBut(' ')
     .endOfLine();

if (regex.test('https://github.com/')) {
    writeOutput('Valid URL');
} else {
    writeOutput('Invalid URL');
}

if (REFindNoCase(regex.toRegex(), 'https://github.com/') > 0) {
    writeOutput('Valid URL');
} else {
    writeOutput('Invalid URL');
}
```

## Other Implementations

You can see other ports on [VerbalExpressions.github.io](http://verbalexpressions.github.io/).

## Installation

Easiest way to install is through CommandBox:

```bash
box install VerbalExpressions
```

## Tests

Run the tests by starting up a server and navigating to `/tests/runner.cfm`.

```bash
box server start port=9999
open http://localhost:9999/tests/runner.cfm
```

## Contributing
This port of Verbal Expressions is not feature complete.  Please [see here](https://github.com/VerbalExpressions/implementation/wiki/List-of-methods-to-implement) for the list of required methods and submit pull requests (with tests) to add additional functionality.
