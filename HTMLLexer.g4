lexer grammar  HTMLLexer;

HTML_COMMENT
    : '<!--' .*? '-->'
    ;

HTML_CONDITIONAL_COMMENT
    : '<![' .*? ']>'
    ;

XML
    : '<?xml' .*? '>'
    ;

CDATA
    : '<![CDATA[' .*? ']]>'
    ;

DTD
    : '<!' .*? '>'
    ;

WHITESPACES
    :  (' '|'\t'|'\r'? '\n')+
    ;

SCRIPT_OPEN
    : '<script' .*? '>' ->pushMode(SCRIPT)
    ;

STYLE_OPEN
    : '<style' .*? '>'  ->pushMode(STYLE)
    ;

TAG_OPEN
    : '<' -> pushMode(TAG)
    ;

HTML_TEXT
    : ~'<'+
    ;


// tag declarations

mode TAG;

TAG_NAME
    : 'html'
    | 'head'
    | 'meta'
    
    | 'link'
    | 'base'

    | 'select'
    | 'option'
    | 'form'
    | 'iframe'
    | 'button'
    | 'input'
    | 'label'
    | 'textarea'
    
    | 'body'
    | 'div'
    | 'span'
    | 'nav'
    | 'pre'
    
    | 'ul'
    | 'li'
    | 'table'
    | 'tr'
    | 'td'
    | 'dl'
    | 'dt'
    | 'dd'

    | 'a'
    | 'p'
    | 'hr'
    | 'br'
    | 'img'

    | 'script'
    | 'noscript'
    | 'section'
    | 'article'
    | 'header'
    | 'footer'

    | 'strong'
    | 'font'
    | 'b'
    | 'i'
    | 'small'

    | 'h1'
    | 'h2'
    | 'h3'
    | 'h4'
    | 'h5'
    | 'h6'
    ;

TAG_CLOSE
    : '>' -> popMode
    ;

TAG_SLASH_CLOSE
    : '/>' -> popMode
    ;

TAG_SLASH
    : '/'
    ;


// lexing mode for attribute values

TAG_EQUALS
    : '=' -> pushMode(ATTVALUE)
    ;

ATTRIBUTE_NAME
    : ATTR_NameStartChar ATTR_NameChar*
    ;


fragment
ATTR_NameChar
    : ATTR_NameStartChar
    | '-'
    | '_'
    | '.'
    | DIGIT
    | '\u00B7'
    | '\u0300'..'\u036F'
    | '\u203F'..'\u2040'
    ;

fragment
ATTR_NameStartChar
    : [:a-zA-Z]
    | '\u2070'..'\u218F'
    | '\u2C00'..'\u2FEF'
    | '\u3001'..'\uD7FF'
    | '\uF900'..'\uFDCF'
    | '\uFDF0'..'\uFFFD'
    ;


TAG_WHITESPACE
    : [ \t\r\n] -> channel(HIDDEN)
    ;

fragment
HEXDIGIT
    : [a-fA-F0-9]
    ;

fragment
DIGIT
    : [0-9]
    ;

// <scripts>

mode SCRIPT;

SCRIPT_BODY
    : JAVASCRIPT '</script>' -> popMode
    ;

SCRIPT_SHORT_BODY
    : JAVASCRIPT '</>' -> popMode
    ;

fragment
JAVASCRIPT
    : .*?
    | WHITESPACES
    ;


// <styles>

mode STYLE;

STYLE_BODY
    : .*? '</style>' -> popMode
    ;

STYLE_SHORT_BODY
    : .*? '</>' -> popMode
    ;


// attribute values

mode ATTVALUE;

// an attribute value may have spaces b/t the '=' and the value
ATTVALUE_VALUE
    : ' '* ATTRIBUTE -> popMode
    ;

ATTRIBUTE
    : DOUBLE_QUOTE_STRING
    | SINGLE_QUOTE_STRING
    | ATTCHARS
    | HEXCHARS
    | DECCHARS
    ;

fragment ATTCHARS
    : ATTCHAR+ ' '?
    ;

fragment ATTCHAR
    : '-'
    | '_'
    | '.'
    | '/'
    | '+'
    | ','
    | '?'
    | '='
    | ':'
    | ';'
    | '#'
    | [0-9a-zA-Z]
    ;

fragment HEXCHARS
    : '#' [0-9a-fA-F]+
    ;

fragment DECCHARS
    : [0-9]+ '%'?
    ;

fragment DOUBLE_QUOTE_STRING
    : '"' ~[<"]* '"'
    ;
fragment SINGLE_QUOTE_STRING
    : '\'' ~[<']* '\''
    ;