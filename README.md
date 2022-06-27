# PP-antlr-html

## Naziv projekta
 Skener i parser za HTML upotrebom ANTLR alata.

## Opis
U ovom projektu implementirana je gramatika za markup jezik HTML. 
Za samu leksičku i sintaksnu analizu korišćena je defaultna implementcaija ANTLR alata (Another tool for language recognition).
Obezbeđeni su i test primeri za validne i nevalidne HTML fajlove u folderu tests.


## Instalacija
- Kako bi se projekat uspešno pokrenuo, neophodno je preuzeti JAR fajl sa sledećeg [linka](https://github.com/antlr/website-antlr4/tree/gh-pages/download) 
i to konkretno verziju 4.7
- Takođe potrebno je imati instaliranu JAVA 8
- (Ukoliko imate JAVA 11, odgovarajuća JAR verzija je 4.10)


- Preuzeti JAR fajl sačuvati u folder za 3rd party bibliotke npr: C:\ProgramFiles\Javalib i dodati ga kao CLASSPATH varijablu
- U odabrani folder gde se sada nalazi JAR, potrebno je kreirati sledeĆa 2 Batch fajla
    1. antlr4.bat --> u kom se nalazi ``` java org.antlr.v4.Tool %* ```
    2. grun.bat --> u kom se nalazi  ``` java org.antlr.v4.gui.TestRing ```


## Pokretanje i Korišćenje
Kreirana je .exe shell skirpta koja ima mogućnost izbora željenog test fajla sa diska, koja zatim pokreće sintaksnu i leksičku analize, i na kraju otvara lep GUI prikaz stabla parsiranja gde će se takođe posebnom bojom prikazati i sintaksne greške (ukoliko postoje).

Sve što je potrebno uraditi je pokrenuti startAnalisys.exe i iskočiće prozor za izbor test fajla koji mora imati ekstenziju html.


Za veću kontrolu moguće je i ručno pokretati svaku celinu posebno, prateći sledeće korake:
```
antlr4 HTMLLexer.g4
antlr4 HTMLParser.g4
javac HTML*.java
grun HTML htmlDocument testFilePath
```
gde je testFilePath npr ./tests/valid/abc_com.html    ./tests/invalid/aljazeera_com.html

*Napomena: ovo se odnosi samo za Window 10 OS, međutim sličan postupak bi bio i za Linux/Unix OS*

## Autor
Katarina Komad SW28/2019

Link do relevantnog Gitlab-a: https://gitlab.com/KatarinaKomad/ppantlrhtml/-/tree/Develop