grammar gramatica;

options {
	language=Java;
}

program: statement+; //espera-se um ou mais statements

statement: flow | attribution SEMICOLON; //no momento somente atribuição é esperada para variables-example.cc

attribution: ID ASSIGN expression; // a :=
flow: flowTerm term comparisonTerm term THEN program (END | elseFlow);
elseFlow: ELSE program END;

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
flowTerm: IF | ELSE | WHILE;
comparisonTerm: EQUAL | DIFFERENT | SMALLER | BIGGER | SMALLER_EQUAL | BIGGER_EQUAL;


PLUS_OPERATOR: '+';
MINUS_OPERATOR: '-';
MULT_OPERATOR: '*';
DIV_OPERATOR: '/';

ASSIGN: ':=';
SEMICOLON: ';';

//flow control
IF: 'if';
ELSE: 'else';
WHILE: 'while';

THEN: 'then'; //sucede if, else
DO: 'do'; // sucede while
END: 'end'; //termina if, else

ID: [a-zA-Z]+;
INT: [0-9]+;

//comparison
EQUAL: '=';
DIFFERENT: '<>';
SMALLER: '<';
BIGGER: '>';
SMALLER_EQUAL: '<=';
BIGGER_EQUAL: '>=';

WS: [ \t\r\n]+ -> skip;
