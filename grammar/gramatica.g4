grammar gramatica;

options {
	language=Java;
}

program: statement+; //espera-se um ou mais statements

statement: attribution SEMICOLON; //no momento somente atribuição é esperada para variables-example.cc

attribution: ID ASSIGN expression; // a :=

//expression: term ((PLUS_OPERATOR | MINUS_OPERATOR | MULT_OPERATOR | DIV_OPERATOR) term)*;
//expression:
  //  expression ((PLUS_OPERATOR | MINUS_OPERATOR | PLUS_OPERATOR | MINUS_OPERATOR) expression)* |
    //term

expression:
    expression ('*'|'/') expression |
    expression ('+'|'-') expression |
    term
    ;

term: INT | ID | '(' expression ')';

PLUS_OPERATOR: '+';
MINUS_OPERATOR: '-';
MULT_OPERATOR: '*';
DIV_OPERATOR: '/';

ASSIGN: ':=';
SEMICOLON: ';';

ID: [a-zA-Z]+;
INT: [0-9]+;

WS: [ \t\r\n]+ -> skip;
