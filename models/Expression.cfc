component name='Expression' {

    property string expression;
    property boolean caseSensitive;

    public Expression function init() {
        variables.expression = '';
        variables.caseSensitive = true;

        return this;
    }

    public string function toRegex() {
        if (variables.caseSensitive) {
            return variables.expression;
        }

        return variables.expression & '/i';
    }

    public boolean function test(required string value) {
        if (variables.caseSensitive) {
            return REFind(variables.expression, arguments.value) > 0;
        }

        return REFindNoCase(variables.expression, arguments.value) > 0;
    }

    private Expression function add(required string value) {
        variables.expression &= arguments.value;

        return this;
    }

    public Expression function find(required string value) {
        local.value = variables.sanitize(arguments.value);

        return variables.add('#local.value#');
    }

    public Expression function then(required string value) {
        return this.find(argumentCollection = arguments);
    }

    public Expression function and(required string value) {
        return this.find(argumentCollection = arguments);
    }

    public Expression function finally(required string value) {
        return this.find(argumentCollection = arguments);
    }

    public Expression function word() {
        return variables.add('\w+');
    }

    public Expression function anything() {
        return variables.add('.*');
    }

    public Expression function anythingBut(required string value) {
        local.value = variables.sanitize(arguments.value);

        return variables.add('(?!#local.value#).*');
    }

    public Expression function something() {
        return variables.add('.+');
    }

    public Expression function somethingBut(required string value) {
        local.value = variables.sanitize(arguments.value);

        return variables.add('(?!#local.value#).+');
    }

    public Expression function anyOf(required any value) {
        local.value = sanitize(normalizeToList(arguments.value));

        return variables.add('(?:[#local.value#])');
    }

    public Expression function any(required any value) {
        return this.anyOf(argumentCollection = arguments);
    }

    public Expression function maybe(required string value) {
        local.value = variables.sanitize(arguments.value);

        return variables.add('(?:#local.value#)?');
    }

    public Expression function tab() {
        return variables.add('\t');
    }

    public Expression function startOfLine() {
        return variables.add('^');
    }

    public Expression function endOfLine() {
        return variables.add('$');
    }

    public Expression function withAnyCase() {
        variables.caseSensitive = false;

        return this;
    }

    private string function sanitize(required string value) {
        // Escape regex characters
        return rereplace(arguments.value, "(?=[\[\]\\^$.|?*+()])", "\\", "all");
    }

    private string function normalizeToList(required any value) {
        if (isArray(arguments.value)) {
           return arguments.value.toList('');
        }

        return arguments.value;
    }

    function onMissingMethod(string name, struct args) {
        var functionName = trimOptionalWordsFromFunctionName(arguments.name);

        if (functionExists(functionName)) {
            var method = this[functionName];
            return method(argumentCollection = args);
        }
    }

    private string function trimOptionalWordsFromFunctionName(required string functionName) {
        var optionalWords = ['then', 'and'];

        return REReplaceNoCase(arguments.functionName, arrayToRegexList(optionalWords), '', 'all');
    }

    private string function arrayToRegexList(required array values) {
        return arguments.values.map(function(value) {
            return '(#value#)';
        }).toList('|');
    }

    private boolean function functionExists(required string name) {
        var functionNames = getMetadata(this).functions.map(function(functionMD) {
            return functionMD.name;
        });

        return functionNames.containsNoCase(arguments.name) > 0;
    }

}
