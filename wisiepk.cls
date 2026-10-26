% =========================================================================
%  wisiepk.cls
%  Klasa dokumentu do składu prac dyplomowych (inżynierskich i magisterskich)
%  na Wydziale Inżynierii Środowiska i Energetyki Politechniki Krakowskiej.
%
%  Opcje klasy (podawane w \documentclass[...]{wisiepk}):
%    jednostronnie  – wydruk jednostronny (domyślnie)
%    dwustronnie    – wydruk dwustronny: marginesy lustrzane, rozdziały
%                     od strony nieparzystej, puste strony bez numeru
%    times          – krój Times (domyślnie)
%    arial          – krój bezszeryfowy typu Arial (Helvetica)
%    bibpodzial     – wykaz literatury podzielony na grupy: publikacje,
%                     normy, akty prawne, źródła internetowe
%
%  Pliku zwykle nie trzeba edytować – dane pracy wpisuje się na górze pliku
%  strony/tytulowa.tex.
% =========================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wisiepk}[2026/10/26 v1.0.1 Praca dyplomowa WISiE PK]

% ---------- Opcje -------------------------------------------------------
\newif\ifwisie@dwustronnie
\newif\ifwisie@arial
\newif\ifwisie@bibpodzial
\DeclareOption{jednostronnie}{\wisie@dwustronniefalse}
\DeclareOption{dwustronnie}{\wisie@dwustronnietrue}
\DeclareOption{times}{\wisie@arialfalse}
\DeclareOption{arial}{\wisie@arialtrue}
\DeclareOption{bibpodzial}{\wisie@bibpodzialtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\ifwisie@dwustronnie
  \LoadClass[11pt,a4paper,twoside,openright]{report}
\else
  \LoadClass[11pt,a4paper,oneside,openany]{report}
\fi

% Logo wydziału jest zapisane jako PDF 1.6. Zachowaj też wyższą wersję,
% jeśli została już ustawiona przez użytkownika.
\RequirePackage{iftex}
\ifPDFTeX
  \ifnum\pdfoutput>0
    \ifnum\pdfminorversion<6 \pdfminorversion=6\relax\fi
  \fi
\fi

% ---------- Język, kodowanie, krój pisma ----------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[english,polish]{babel} % ostatni język jest językiem głównym
\ifwisie@arial
  \RequirePackage{newtxtext}
  \RequirePackage{helvet}
  \renewcommand{\familydefault}{\sfdefault}
  \RequirePackage{newtxsf}   % bezszeryfowe wzory pasujące do tekstu
\else
  \RequirePackage{newtxtext}
  \RequirePackage{newtxmath}
\fi
\RequirePackage[varqu,scaled=0.92]{zi4} % krój maszynowy (listingi, adresy URL)
\RequirePackage{icomma}      % przecinek dziesiętny w trybie matematycznym: $3,14$
\RequirePackage{microtype}
\RequirePackage{etoolbox}

% ---------- Układ strony --------------------------------------------------
% Lewy (wewnętrzny) margines 3,5 cm, pozostałe 2,5 cm.
\ifwisie@dwustronnie
  \RequirePackage[a4paper,top=2.5cm,bottom=2.5cm,inner=3.5cm,outer=2.5cm,
                  footskip=1.2cm]{geometry}
\else
  \RequirePackage[a4paper,top=2.5cm,bottom=2.5cm,left=3.5cm,right=2.5cm,
                  footskip=1.2cm]{geometry}
\fi
\RequirePackage{emptypage}   % strony wstawiane przez \cleardoublepage – bez numeru

% Interlinia. W edytorze Word „1,25 wiersza” dla pisma 11 pt to ok. 15,8 pt
% odstępu między liniami bazowymi. Podstawowa linia w LaTeX-u przy 11 pt
% ma 13,6 pt, więc ten sam efekt daje współczynnik ok. 1,16.
\RequirePackage{setspace}
\setstretch{1.16}

\setlength{\parindent}{0.63cm}
\setlength{\parskip}{0pt}
\RequirePackage{indentfirst} % wcięcie także w pierwszym akapicie po tytule
\pagestyle{plain}            % numer strony na dole, wyśrodkowany
\raggedbottom                % bez sztucznego rozciągania odstępów w pionie

% ---------- Nagłówki rozdziałów -------------------------------------------
\RequirePackage{titlesec}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

\titleformat{\chapter}[hang]
  {\normalfont\fontsize{14}{17}\selectfont\bfseries}{\thechapter.}{0.6em}{}
\titlespacing*{\chapter}{0pt}{0pt}{18pt}

\titleformat{\section}
  {\normalfont\fontsize{13}{16}\selectfont\bfseries}{\thesection.}{0.6em}{}
\titlespacing*{\section}{0pt}{16pt plus 4pt minus 2pt}{8pt plus 2pt}

\titleformat{\subsection}
  {\normalfont\fontsize{12}{15}\selectfont\bfseries}{\thesubsection.}{0.6em}{}
\titlespacing*{\subsection}{0pt}{12pt plus 3pt minus 2pt}{6pt plus 2pt}

\titleformat{\subsubsection}
  {\normalfont\normalsize\bfseries\itshape}{\thesubsubsection.}{0.6em}{}
\titlespacing*{\subsubsection}{0pt}{10pt plus 3pt minus 2pt}{4pt}

% Rozdział bez numeru, ale ujęty w spisie treści (Wykaz oznaczeń, Literatura...)
\newcommand{\rozdzialbeznumeru}[1]{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \phantomsection
  \addcontentsline{toc}{chapter}{#1}%
  \chapter*{#1}%
  \markboth{#1}{#1}}

% ---------- Spis treści i spisy ilustracji --------------------------------
\RequirePackage[titles]{tocloft}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftchapaftersnum}{.}
\renewcommand{\cftsecaftersnum}{.}
\renewcommand{\cftsubsecaftersnum}{.}
\renewcommand{\cftfigpresnum}{Rys.~}
\renewcommand{\cftfigaftersnum}{.}
\setlength{\cftfignumwidth}{4.2em}
\renewcommand{\cfttabpresnum}{Tabela~}
\renewcommand{\cfttabaftersnum}{.}
\setlength{\cfttabnumwidth}{5.4em}
\setlength{\cftbeforechapskip}{4pt}

\newcommand{\spisrysunkow}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \phantomsection\addcontentsline{toc}{chapter}{\listfigurename}%
  \listoffigures}
\newcommand{\spistabel}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \phantomsection\addcontentsline{toc}{chapter}{\listtablename}%
  \listoftables}

% ---------- Rysunki, tabele, podpisy --------------------------------------
\RequirePackage{graphicx}
\graphicspath{{rysunki/}}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,positioning,calc}
\RequirePackage{pgfplots}
\RequirePackage{pgfplotstable}
\pgfplotsset{compat=1.18,
  /pgf/number format/use comma,          % przecinek dziesiętny na osiach
  /pgf/number format/1000 sep={\,}}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{multirow}
\RequirePackage[section]{placeins} % obiekty nie „uciekają” do następnego podrozdziału
% Łagodniejsze reguły rozmieszczania obiektów – mniej stron z samymi rysunkami
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.6}
\renewcommand{\textfraction}{0.12}
\renewcommand{\floatpagefraction}{0.75}
\setcounter{topnumber}{3}
\setcounter{totalnumber}{4}

% Podpisy: kursywa, pojedyncza interlinia, kropka po numerze, bez kropki
% na końcu treści. Rysunek – podpis pod spodem, tabela – nad tabelą.
\RequirePackage{caption}
\captionsetup{format=plain, font={it,stretch=1}, labelfont=it,
  labelsep=period, justification=centering, skip=6pt}
\captionsetup[figure]{name=Rys., position=below}
\captionsetup[table]{name=Tabela, position=above}
\RequirePackage{subcaption}
\captionsetup[sub]{font={it,small}, labelformat=parens, labelsep=space}

% ---------- Jednostki i liczby (konwencja polska) -------------------------
\RequirePackage{siunitx}
\sisetup{
  output-decimal-marker = {,},
  group-separator       = {\,},
  group-minimum-digits  = 4,
  exponent-product      = \cdot,
  inter-unit-product    = \ensuremath{{\cdot}},   % W/(m·K) bez odstępów
  per-mode              = symbol,
  range-phrase          = {--},
  range-units           = single,
  list-pair-separator   = {~i~},
  list-final-separator  = {~i~},
}

% ---------- Listingi kodu -------------------------------------------------
\RequirePackage{listings}
\renewcommand{\lstlistingname}{Listing}
\renewcommand{\lstlistlistingname}{Spis listingów}
\lstset{
  basicstyle      = \ttfamily\small\setstretch{1},
  columns         = fullflexible,
  keepspaces      = true,
  numbers         = left,
  numberstyle     = \tiny\color{black!55},
  numbersep       = 8pt,
  frame           = tb,
  framesep        = 4pt,
  keywordstyle    = \bfseries\color{blue!55!black},
  commentstyle    = \color{green!35!black},
  stringstyle     = \color{red!55!black},
  showstringspaces= false,
  breaklines      = true,
  tabsize         = 4,
  captionpos      = t,
  aboveskip       = 10pt,
  belowskip       = 6pt,
  extendedchars   = true,
  literate        = {ą}{{\k{a}}}1 {ć}{{\'c}}1 {ę}{{\k{e}}}1 {ł}{{\l{}}}1
                    {ń}{{\'n}}1 {ó}{{\'o}}1 {ś}{{\'s}}1 {ź}{{\'z}}1
                    {ż}{{\.z}}1 {Ą}{{\k{A}}}1 {Ć}{{\'C}}1 {Ę}{{\k{E}}}1
                    {Ł}{{\L{}}}1 {Ń}{{\'N}}1 {Ó}{{\'O}}1 {Ś}{{\'S}}1
                    {Ź}{{\'Z}}1 {Ż}{{\.Z}}1 {°}{{\textdegree}}1,
}

% ---------- Listy, przypisy, różne ----------------------------------------
\RequirePackage{enumitem}
\setlist{itemsep=1pt, topsep=4pt, parsep=0pt}
\setlist[itemize]{label=--}
\RequirePackage[normalem]{ulem}  % \sout – skreślenie w oświadczeniu
\RequirePackage{amsmath}
\RequirePackage{csquotes}

% Objaśnienia symboli pod wzorem:
%   \begin{gdzie}
%     \zm{U}{współczynnik przenikania ciepła}{\si{W/(m^2.K)}}
%   \end{gdzie}
% Trzeci argument (jednostkę) można zostawić pusty.
\newenvironment{gdzie}
  {\par\noindent gdzie:\par\nopagebreak\vspace{1pt}%
   \noindent\tabularx{\linewidth}{@{\hspace{\parindent}}>{$}l<{$}@{\enspace--\enspace}X@{}}}
  {\endtabularx\par\vspace{6pt}}
\newcommand{\zm}[3]{#1 & #2\ifblank{#3}{}{, [#3]}\\}

% Wykaz oznaczeń w postaci trzech kolumn: symbol, opis, jednostka.
%   \begin{oznaczenia}
%     \grupaoznaczen{Litery łacińskie}
%     \oznaczenie{U}{współczynnik przenikania ciepła}{\si{W/(m^2.K)}}
%   \end{oznaczenia}
\newenvironment{oznaczenia}[1][Wykaz ważniejszych oznaczeń]
  {\rozdzialbeznumeru{#1}%
   \setlength{\LTpre}{0pt}\setlength{\LTleft}{0pt}%
   \longtable{@{}>{$}p{2.3cm}<{$}p{\dimexpr\textwidth-2.3cm-3.4cm-4\tabcolsep\relax}l@{}}
   \toprule \textbf{Symbol} & \textbf{Opis} & \textbf{Jednostka}\\ \midrule \endhead
   \bottomrule \endlastfoot}
  {\endlongtable}
\newcommand{\oznaczenie}[3]{#1 & #2 & #3\\}
\newcommand{\grupaoznaczen}[1]{%
  \multicolumn{3}{@{}l}{\rule{0pt}{14pt}\textit{#1}}\\[2pt]}

% ---------- Dane pracy (wpisywane na górze pliku strony/tytulowa.tex) ------
% \wisie@pole{nazwa}{wartość domyślna} tworzy polecenie \nazwa{...}
% oraz makro wewnętrzne \wisie@nazwa z zapisaną wartością.
\newcommand*{\wisie@pole}[2]{%
  \expandafter\def\csname wisie@#1\endcsname{#2}%
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \expandafter\def\csname wisie@#1\endcsname{##1}}}

\wisie@pole{autor}{Imię Nazwisko}
\wisie@pole{plecautora}{}             % M lub K; puste – formy z ukośnikiem
\wisie@pole{tytulPL}{Tytuł pracy w języku polskim}
\wisie@pole{rodzajpracy}{inżynierska} % inżynierska / magisterska
\wisie@pole{formastudiow}{stacjonarne}
\wisie@pole{stopienstudiow}{I}
\wisie@pole{kierunek}{}
\wisie@pole{specjalnosc}{brak}
\wisie@pole{promotor}{tytuł/stopień Imię Nazwisko}
\wisie@pole{recenzent}{}
\wisie@pole{miejsce}{Kraków}
\wisie@pole{rok}{2026}
\wisie@pole{zgodaASAP}{}              % TAK / NIE; puste – do skreślenia ręcznie

% Odczyt danych na stronach pracy:  \dana{autor}, \dana{tytulPL} ...
% Element warunkowy:                \jeslidana{recenzent}{Recenzent: ...}
\newcommand{\dana}[1]{\csname wisie@#1\endcsname}
\newcommand{\jeslidana}[2]{%
  \expandafter\ifdefempty\csname wisie@#1\endcsname{}{#2}}

% Kontrola danych nie zmienia treści ani układu PDF. Ostrzeżenia trafiają
% tylko do logu. Puste M/K i TAK/NIE pozostają dozwolone (skreślenie ręczne).
\ExplSyntaxOn
\cs_new_protected:Npn \wisie_sprawdz_wymagane:n #1
  {
    \exp_args:Nv \tl_if_blank:nT { wisie@#1 }
      { \ClassWarningNoLine{wisiepk}{Pole~'#1'~jest~puste.
          \MessageBreak Uzupelnij~dane~w~strony/tytulowa.tex} }
  }
\cs_new_protected:Npn \wisie_sprawdz_przyklad:nn #1#2
  {
    \exp_args:Nv \tl_if_in:nnT { wisie@#1 } {#2}
      { \ClassWarningNoLine{wisiepk}{Pole~'#1'~zawiera~dane~przykladowe.
          \MessageBreak Uzupelnij~dane~w~strony/tytulowa.tex} }
  }
\cs_new_protected:Npn \wisie_sprawdz_wybor:nn #1#2
  {
    \tl_set:Nv \l_tmpa_tl { wisie@#1 }
    \tl_if_blank:VF \l_tmpa_tl
      {
        \clist_if_in:nVF {#2} \l_tmpa_tl
          { \ClassWarningNoLine{wisiepk}{Nieprawidlowa~wartosc~pola~'#1'.
              \MessageBreak Dozwolone:~#2~lub~puste~pole.
              \MessageBreak Popraw~dane~w~strony/tytulowa.tex} }
      }
  }
\NewDocumentCommand{\sprawdzdanepracy}{}
  {
    \clist_map_inline:nn
      { autor,tytulPL,rodzajpracy,formastudiow,stopienstudiow,kierunek,
        specjalnosc,promotor,miejsce,rok }
      { \wisie_sprawdz_wymagane:n {##1} }
    \clist_map_inline:nn { autor,promotor,recenzent }
      { \wisie_sprawdz_przyklad:nn {##1} {Imię~Nazwisko} }
    \wisie_sprawdz_przyklad:nn {tytulPL} {Tytuł~pracy~w~języku~polskim}
    \wisie_sprawdz_przyklad:nn {tytulPL} {Temat~pracy~dyplomowej}
    \wisie_sprawdz_wybor:nn {plecautora} {M,K}
    \wisie_sprawdz_wybor:nn {zgodaASAP} {TAK,NIE}
  }
\ExplSyntaxOff

% Metadane pliku PDF (autor, tytuł) – wywoływane po wpisaniu danych
\newcommand{\metadanepdf}{%
  \sprawdzdanepracy
  \hypersetup{pdfauthor={\wisie@autor}, pdftitle={\wisie@tytulPL},
              pdfsubject={Praca dyplomowa \wisie@rodzajpracy}}}

% Kolory z identyfikacji wizualnej PK (granat PK, niebieski wydziału)
\definecolor{pkgranat}{HTML}{003571}
\definecolor{wisieniebieski}{HTML}{006EAA}

% Formy zależne od rodzaju gramatycznego autora:
%   \formaMK{uzyskałem}{uzyskałam}{uzyskałem/am}
% Gdy \plecautora jest puste, drukowany jest trzeci wariant z gwiazdką,
% a pod oświadczeniem pojawia się dopisek „niepotrzebne skreślić”.
\newif\ifwisie@skreslenia
\newcommand{\formaMK}[3]{%
  \ifdefstring{\wisie@plecautora}{K}{#2}{%
    \ifdefstring{\wisie@plecautora}{M}{#1}{#3*\global\wisie@skresleniatrue}}}

% Wybór TAK / NIE w oświadczeniu (niewybrana opcja zostaje skreślona)
\newcommand{\wyborTakNie}{%
  \ifdefstring{\wisie@zgodaASAP}{TAK}{TAK / \sout{NIE}}{%
    \ifdefstring{\wisie@zgodaASAP}{NIE}{\sout{TAK} / NIE}{%
      TAK / NIE*\global\wisie@skresleniatrue}}}
\newcommand{\dopisekSkreslenia}{%
  \ifwisie@skreslenia\par\vspace{4mm}\noindent{\footnotesize * niepotrzebne skreślić}\fi}

% Linia na podpis
\newcommand{\miejscenapodpis}[1][podpis]{%
  \par\vspace{8mm}%
  \hfill\begin{tabular}{@{}c@{}}
    \makebox[6cm]{\dotfill}\\[-2pt]
    {\footnotesize #1}
  \end{tabular}\par}

% Logo z identyfikacji wizualnej PK (pliki w rysunki/logo/, pobrane
% z pk.edu.pl). Argument opcjonalny – wysokość sygnetu.
%  * pk_wisie_logo.pdf – logo wydziału (2026, wersja asymetryczna PL);
%    przycięcie (trim) pomija sygnet PK i pole ochronne, zostawiając sygnet
%    wydziału z nazwą – tak jak na formatce wydziałowej,
%  * pk_sygnet.pdf     – sygnet Politechniki Krakowskiej.
% Obie grafiki stoją na wspólnej linii bazowej (dół sygnetów), więc ich
% górne krawędzie także się pokrywają.
\newcommand{\logowydzialu}[1][1.6cm]{%
  \raisebox{-0.0641\dimexpr#1\relax}{%
    \includegraphics[height=1.0641\dimexpr#1\relax,
      trim=424bp 53bp 59.5bp 70bp, clip]{rysunki/logo/pk_wisie_logo.pdf}}}
\newcommand{\logopk}[1][1.6cm]{%
  \includegraphics[height=#1, trim=70.5bp 71bp 71bp 70.5bp, clip]
    {rysunki/logo/pk_sygnet.pdf}}

% ---------- Bibliografia (biblatex + biber) ------------------------------
\ifwisie@bibpodzial
  \PassOptionsToPackage{defernumbers=true}{biblatex}
\fi
\RequirePackage[backend=biber, style=numeric-comp, sorting=none, natbib=true,
  giveninits=true, maxbibnames=3, minbibnames=3, maxcitenames=2,
  mincitenames=1, uniquename=false, uniquelist=false, isbn=true,
  doi=true, url=true, eprint=false, urldate=short, dateabbrev=false,
  autolang=hyphen]{biblatex}

% Nazwiska w formie „Nazwisko I.”, rozdzielane przecinkami
\DeclareNameAlias{default}{family-given}
\DeclareNameAlias{sortname}{family-given}
\DeclareDelimFormat{revsdnamepunct}{}
\DeclareDelimFormat[bib]{finalnamedelim}{\addcomma\space}
% Tytuły artykułów i rozdziałów bez cudzysłowów, „W:” tylko przy rozdziałach
\DeclareFieldFormat[article,inproceedings,incollection,inbook,thesis]{title}{#1}
\renewbibmacro{in:}{%
  \ifentrytype{article}{}{\printtext{\bibstring{in}\intitlepunct}}}
\DeclareFieldFormat{edition}{%
  \ifinteger{#1}{\bibstring{edition}~#1}{#1}}  % „wyd. 4”
\DeclareFieldFormat{url}{\url{#1}}
\DeclareFieldFormat{urldate}{\mkbibbrackets{\bibstring{urlseen}\addcolon\space#1}}

% Normy:  @standard{klucz, number = {PN-EN ...}, title = {...},
%                   organization = {PKN}, location = {Warszawa}, year = {...}}
\DeclareFieldFormat[standard]{title}{\mkbibemph{#1}}
\DeclareBibliographyDriver{standard}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \printfield{number}%
  \setunit{\addspace}%
  \usebibmacro{title}%
  \newunit\newblock
  \printfield{note}%
  \newunit\newblock
  \printlist{location}%
  \setunit*{\addcolon\space}%
  \printlist{organization}%
  \setunit*{\addcomma\space}%
  \usebibmacro{date}%
  \newunit\newblock
  \usebibmacro{doi+eprint+url}%
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \usebibmacro{finentry}}

% Akty prawne:  @legislation{klucz, title = {Ustawa z dnia ...},
%                            howpublished = {t.j. Dz.U. ... poz. ...}}
\DeclareFieldFormat[legislation]{title}{#1}
\DeclareBibliographyDriver{legislation}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{title}%
  \setunit{\addspace}%
  \printfield[parens]{howpublished}%
  \newunit\newblock
  \printfield{note}%
  \newunit\newblock
  \usebibmacro{doi+eprint+url}%
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \usebibmacro{finentry}}

\defbibheading{wisie}[Literatura]{\rozdzialbeznumeru{#1}}
\defbibheading{wisiesub}[]{%
  \section*{#1}\addcontentsline{toc}{section}{#1}}
\defbibfilter{wisie@www}{type=online or type=software or type=dataset}

\newcommand{\wykazliteratury}{%
  \ifwisie@bibpodzial
    \printbibheading[heading=wisie]%
    \printbibliography[heading=wisiesub, title={Publikacje i opracowania},
      nottype=standard, nottype=legislation, nottype=online,
      nottype=software, nottype=dataset]%
    \printbibliography[heading=wisiesub, title={Normy}, type=standard]%
    \printbibliography[heading=wisiesub, title={Akty prawne}, type=legislation]%
    \printbibliography[heading=wisiesub,
      title={Źródła internetowe, dane i oprogramowanie}, filter=wisie@www]%
  \else
    \printbibliography[heading=wisie]%
  \fi}

% ---------- Załączniki ----------------------------------------------------
\newcommand{\zalaczniki}{%
  \appendix
  \titleformat{\chapter}[hang]
    {\normalfont\fontsize{14}{17}\selectfont\bfseries}
    {Załącznik~\thechapter.}{0.6em}{}%
  \addtocontents{toc}{\protect\renewcommand{\protect\cftchappresnum}{Załącznik~}%
    \protect\setlength{\protect\cftchapnumwidth}{6.6em}}}

% ---------- Hiperłącza (ładowane na końcu) --------------------------------
\RequirePackage[hidelinks,unicode,bookmarksnumbered,pdfusetitle]{hyperref}
\urlstyle{same}

\endinput
