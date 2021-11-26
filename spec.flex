// import sekcija

%%

// sekcija opcija i deklaracija
%class MPLexer
%function next_token
%line
%column
%debug
%type Yytoken

%eofval{
return new Yytoken( sym.EOF, null, yyline, yycolumn);
%eofval}

%{
//dodatni clanovi generisane klase
KWTable kwTable = new KWTable();
Yytoken getKW()
{
	return new Yytoken( kwTable.find( yytext() ),
	yytext(), yyline, yycolumn );
}
%}

//stanja
%xstate KOMENTAR
//makroi
slovo = [a-zA-Z]
cifra = [0-9]
hex = [0-9a-fA-F]
%%

// pravila
\(\* { yybegin( KOMENTAR ); }
<KOMENTAR>~"*)" { yybegin( YYINITIAL ); }

[\t\n\r ] { ; }
\( { return new Yytoken( sym.LEFTPAR, yytext(), yyline, yycolumn ); }
\) { return new Yytoken( sym.RIGHTPAR, yytext(), yyline, yycolumn ); }

//operatori
\+ { return new Yytoken( sym.PLUS,yytext(), yyline, yycolumn ); }
\- { return new Yytoken( sym.MINUS,yytext(), yyline, yycolumn ); }

//separatori
; { return new Yytoken( sym.SEMICOLON, yytext(), yyline, yycolumn ); }
: { return new Yytoken( sym.COLON, yytext(), yyline, yycolumn ); }
, { return new Yytoken( sym.COMMA, yytext(), yyline, yycolumn ); }
\. { return new Yytoken( sym.DOT, yytext(), yyline, yycolumn ); }
:=|= { return new Yytoken( sym.ASSIGN, yytext(), yyline, yycolumn ); }


//kljucne reci
{slovo}+ { return getKW(); }

//identifikatori
(({slovo}|[$])({slovo}|{cifra}|[$])*) { return new Yytoken(sym.ID, yytext(), yyline, yycolumn ); }

//konstante
{cifra}+ { return new Yytoken( sym.CONST, yytext(), yyline, yycolumn ); }

//string
\".+?\"|\"\" { return new Yytoken( sym.STRING, yytext(), yyline, yycolumn ); }

//oct ili hex
((([0x]{1}{hex}+)|[0]{1}{cifra}+)|({cifra}+)) {return new Yytoken(sym.INTEGER, yytext(), yyline, yycolumn); }

//char
'[^]' { return new Yytoken( sym.CHAR,yytext(), yyline, yycolumn ); }

//obrada gresaka
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }
