parser grammar HTMLParser;

options { tokenVocab=HTMLLexer; }
htmlFile
   : htmlDocument EOF
   ;

htmlDocument
    : WHITESPACES* XML? WHITESPACES* DTD? WHITESPACES* htmlElements*
    ;

htmlElements
    : htmlMisc* htmlElement htmlMisc*
    ;

htmlElement
    : TAG_OPEN TAG_NAME htmlAttribute*
      (TAG_CLOSE (htmlContent TAG_OPEN TAG_SLASH TAG_NAME TAG_CLOSE)? | TAG_SLASH_CLOSE)
    | script
    | style
    ;

htmlContent
    : htmlChardata? ((htmlElement | CDATA | htmlComment) htmlChardata?)*
    ;

htmlAttribute
    : ATTRIBUTE_NAME (TAG_EQUALS ATTVALUE_VALUE)?
    ;

htmlChardata
    : HTML_TEXT
    | WHITESPACES
    ;

htmlMisc
    : htmlComment
    | WHITESPACES
    ;

htmlComment
    : HTML_COMMENT
    | HTML_CONDITIONAL_COMMENT
    ;

script
    : SCRIPT_OPEN (SCRIPT_BODY | SCRIPT_SHORT_BODY)
    ;

style
    : STYLE_OPEN (STYLE_BODY | STYLE_SHORT_BODY)
    ;