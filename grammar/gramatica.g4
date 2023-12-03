grammar gramatica;

options {
	language=Java;
}

@header {
    import java.util.HashMap;
}

@members {
    HashMap<String, Double> attributes = new HashMap<String, Double>();
}

program: statement+; //espera-se um ou mais statements

statement: ifFlow | whileFlow | attribution SEMICOLON; //no momento somente atribuição é esperada para variables-example.cc

attribution:
    ID ASSIGN expression
    { attributes.put($ID.text, new Double($expression.exprValue)); }
    { System.out.println("Processando e salvando variável {" + $ID.text + "} com valor {" + $expression.exprValue + "}"); }
    ;

whileFlow: WHILE relationalExpression DO program;
ifFlow: IF relationalExpression THEN program elseFlow?;
elseFlow: ELSE program;

expression returns [ double exprValue ]:
    expression MULT_OPERATOR expression  { $exprValue *= $expression.exprValue; System.out.println("Resultado Multi:" + $exprValue); }  |
    expression DIV_OPERATOR expression   { $exprValue /= $expression.exprValue; System.out.println("Resultado Div:" + $exprValue);   }  |
    expression PLUS_OPERATOR expression  { $exprValue += $expression.exprValue; System.out.println("Resultado Plus:" + $exprValue);  }  |
    expression MINUS_OPERATOR expression { $exprValue -= $expression.exprValue; System.out.println("Resultado Minus:" + $exprValue); }  |
    term {$exprValue = $term.value;}
    ;

relationalExpression: term comparisonTerm term;

term returns [double value]:
    INT { $value = Double.parseDouble($INT.text);  System.out.println("Retornando valor constante: " + $value); } |
    ID  { $value = attributes.getOrDefault($ID.text, 0.0);  System.out.println("Retornando valor de variavel {" + $ID.text + "}: " + $value); } |
    '(' expression ')'
    ;

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
