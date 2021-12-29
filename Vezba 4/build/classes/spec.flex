// import sekcija
import java_cup.runtime.*;

%%
// sekcija deklaracija
%class MPLexer

%cup

%line
%column

%eofval{
	return new Symbol( sym.EOF );
%eofval}

%{
   public int getLine()
   {
      return yyline;
   }
%}


//stanja
%xstate KOMENTAR
//makroi
slovo = [a-zA-Z]
cifra = [0-9]
hex = [0-9a-fA-F]

%%
// rules section
\(\*			{ yybegin( KOMENTAR ); }
<KOMENTAR>\*\)	{ yybegin( YYINITIAL ); }
<KOMENTAR>~"*)" { yybegin( YYINITIAL ); }


[\t\r\n ]		{ ; }

//operatori
\+				{ return new Symbol( sym.PLUS ); }

//separatori
;				{ return new Symbol( sym.SEMI );	}
:				{ return new Symbol( sym.COLON ); }
=				{ return new Symbol( sym.ASSIGN ); }
\(				{ return new Symbol( sym.LEFTPAR ); }
\)				{ return new Symbol( sym.RIGHTPAR ); }

//kljucne reci
"program"		{ return new Symbol( sym.PROGRAM );	}	
"do"			{ return new Symbol( sym.DO );	}
"integer"		{ return new Symbol( sym.INTEGER );	}
"char"			{ return new Symbol( sym.CHAR );	}
"read"			{ return new Symbol( sym.READ );	}
"begin"			{ return new Symbol( sym.BEGIN );	}
"end"			{ return new Symbol( sym.END );         }
"string"                { return new Symbol( sym.STRING );      }
"return"                { return new Symbol( sym.RETURN );      }
"file"                  { return new Symbol( sym.FILE );        }
"open"                  { return new Symbol( sym.OPEN );        }

//identifikatori
(({slovo}|[$])({slovo}|{cifra}|[$])*)	{ return new Symbol( sym.ID ); }

//konstante
\'[^]\'			{ return new Symbol( sym.CHARCONST, new Character( yytext().charAt(1) ) ); }
{cifra}+		{ return new Symbol( sym.INTCONST, new Integer( yytext() ) ); }

//string
\".+?\"|\"\"            { return new Symbol( sym.STRING ); }

//oct ili hex
((([0x]{1}{hex}+)|[0]{1}{cifra}+)|({cifra}+)) { return new Symbol( sym.INTCONST, new Integer( yytext() ) ); }


//obrada greske
.		{ System.out.println( "ERROR: " + yytext() ); }

