\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sbabook}[2013/03/08]

% \ExecuteOptions{a4paper,11pt,twoside}
\ProcessOptions*
\LoadClassWithOptions{memoir}

\RequirePackage{graphicx}
\RequirePackage{xcolor}
\renewcommand{\trimmarkscolor}{\color{cyan}}

%%%
%%% Page layout
%%%
\newcommand\stockustrade{\setstocksize{9in}{6in}}
\newcommand\setbleed[1]{%
    \settrimmedsize{\stockheight}{\stockwidth}{*}%
    \settrims{#1}{#1}%
    \advance\stockheight 2\trimtop
    \advance\stockwidth  2\trimedge}

\settypeoutlayoutunit{mm}

\raggedbottom

%%%
%%% Fonts & paragraph typography
%%%
\RequirePackage{fontspec}
\defaultfontfeatures[Gentium Basic]{
  Extension = .ttf,
  UprightFont = GenBkBasR,
  ItalicFont = GenBkBasI,
  BoldFont = GenBasB,
  BoldItalicFont = GenBasBI,
}
\defaultfontfeatures[Inconsolata]{
  UprightFont = *zi4-Regular,
  BoldFont = *zi4-Bold,
  StylisticSet = 3,
}
\defaultfontfeatures[Open Sans]{
  Extension = .ttf,
  UprightFont = OpenSans-Regular,
  ItalicFont = OpenSans-Italic,
  BoldFont = OpenSans-Bold,
  BoldItalicFont = OpenSans-BoldItalic,
}

\setmainfont[Numbers=OldStyle]{Gentium Basic}
\setsansfont[Scale=MatchLowercase,Numbers=OldStyle]{Open Sans}
\setmonofont[Scale=MatchLowercase]{Inconsolata}

\RequirePackage{microtype}

\noindentafterchapter
\setlength{\parindent}{1.5em}
\nonzeroparskip
\firmlists

\RequirePackage{ragged2e}
\RaggedRight
\RequirePackage{varwidth}
\newenvironment{balanced}[1]{%
    \CenteringLeftskip    0pt plus 6em%
    \CenteringRightskip   0pt plus 6em%
    \RaggedLeftLeftskip   0pt plus 12em%
    \RaggedRightRightskip 0pt plus 12em%
    \begin{varwidth}{#1}%
}{\end{varwidth}}

%% margin content
\sideparmargin{outer}
\renewcommand\sideparfont{\footnotesize\sffamily}
\renewcommand\sideparform{\ifmemtortm\RaggedRight\else\RaggedLeft\fi}
% \setmpjustification{\RaggedLeft}{\Raggedright} % this is for margin floats

%%%
%%% Title page
%%%
\setlength\droptitle{5cm}
\pretitle{\begin{flushright}\HUGE\sffamily}
\posttitle{\par\end{flushright}\vskip 1cm}
\preauthor{\begin{flushright}
    \large\sffamily
    \begin{tabular}[t]{r@{}}}
\postauthor{\end{tabular}\par\end{flushright}}
\predate{\begin{flushright}\large\sffamily}
\postdate{\par\end{flushright}}

% place authors on separate lines
% memoir provides \andnext, and normally \\ is used to add data under the
% author's name, like affiliation, email…
\renewcommand\and{\\}

% line break in title, hopefully without polluting PDF metadata etc
\newcommand\titlebreak[2][]{\texorpdfstring{#1\protect\\}{#2}}

%%%
%%% Sectioning
%%%

%% chapter heading
\newlength{\chapnumheight}\setlength{\chapnumheight}{18mm}
\makechapterstyle{sba}{%
    \renewcommand{\chapnamefont}{%
        \LARGE\sffamily\bfseries
        \addfontfeature{LetterSpace=20}%
        \flushright\MakeUppercase}
    \renewcommand{\chapnumfont}{%
        \HUGE\sffamily\bfseries
        \addfontfeature{Numbers={Proportional,Lining}}}
    \renewcommand{\chaptitlefont}{\HUGE\sffamily\mdseries\flushright}
    \renewcommand*{\chapterheadstart}{}
    \renewcommand*{\chapternamenum}{}
    \renewcommand*{\afterchapternum}{\par\nobreak\vskip 25pt}
    \renewcommand*{\printchapternum}{%
        \resizebox{!}{\chapnumheight}{\chapnumfont \,\thechapter}%
        \rlap{%
          \kern .3\chapnumheight
          \rule{\foremargin}{\chapnumheight}}}
    \setlength{\afterchapskip}{8\baselineskip}
    %% chapter precis
    \renewcommand\precisfont{\normalfont\sffamily\RaggedLeft\small}
    \newlength{\postchapterprecisskip}
    \setlength{\prechapterprecisshift}{-4\baselineskip}
    \setlength{\postchapterprecisskip}{\baselineskip}
    \renewcommand\prechapterprecis{%
      \precisfont
      \vspace*{-\postchapterprecisskip}%
      \vspace*{-4\baselineskip}}
    \renewcommand\postchapterprecis{\vspace*{\postchapterprecisskip}}
    %%% fix indentation of 1st paragraph after \chapterprecis
    %% cf https://groups.google.com/forum/#!msg/comp.text.tex/yj4ZoVlbSKE/5hJXO-2jG5EJ
  %  \addtoiargdef\chapterprecis{}{%
  %   \par\@afterheading\m@mindentafterchapter}
  }

% \renewcommand\chapterprecishere[1]{%
%     \prevgraf0
%     \prechapterprecis #1\postchapterprecis
%     {\count0 \numexpr3-\prevgraf\relax
%         \precisfont% just needed in case this did a size change so get right baseline
%         \ifnum\count0 >0 \vspace{\count0 \baselineskip}\fi}}
\renewcommand\chapterprecishere[1]{%
  {\prechapterprecis
    \begin{minipage}[t]{\linewidth}%
      \flushright
      \begin{balanced}{\linewidth}%
        \prevgraf0
        \strut#1\strut\par
        \xdef\precistmp{\noexpand\precisskip{\the\prevgraf}{\the\baselineskip}}%
      \end{balanced}\par%
    \end{minipage}%
    \precistmp
    \postchapterprecis
  }%
  \par
  \@afterheading
}
\def\precisskip#1#2{{%
    \count0 \numexpr4-#1\relax
    \dimen0=#2 %
    \ifnum\count0 >0 \vspace*{\count0 \dimen0}\fi}}


\makeheadstyles{sba}{%
  \renewcommand*{\booknamefont} {\normalfont\huge\sffamily}
  \renewcommand*{\booknumfont}  {\normalfont\huge\sffamily}
  \renewcommand*{\booktitlefont}{\normalfont\Huge\sffamily}
  \renewcommand*{\partnamefont} {\normalfont\huge\sffamily}
  \renewcommand*{\partnumfont}  {\normalfont\huge\sffamily}
  \renewcommand*{\parttitlefont}{\normalfont\Huge\sffamily}
  \chapterstyle{sba}
  \setsecheadstyle      {\LARGE\sffamily\bfseries}
  \setsubsecheadstyle   {\Large\sffamily\bfseries}
  \setsubsubsecheadstyle{\Large\sffamily}
  \setparaheadstyle     {\sffamily\bfseries}
  \setsubparaheadstyle  {\sffamily}
  \setsecnumformat{%
    \llap{\mdseries
      \csname the##1\endcsname
      \quad}}
}

\headstyles{sba}
\setsecnumdepth{section}
\settocdepth{section}


%%%
%%% Table of contents etc
%%%
\cftpagenumbersoff{part}
\setlength{\cftbeforepartskip}{2em plus 1.5em minus .75em}

\addtodef\tableofcontents{\clearforchapter}{}
\renewcommand\cftpartfont{\sffamily\large\bfseries}
\let\cftpartpagefont\cftpartfont% unused, but for coherence
\renewcommand\cftpartleader{}
\renewcommand\cftpartafterpnum{\cftparfillskip}
\setlength{\cftbeforechapterskip}{1em plus .5em minus .2em}
\renewcommand{\cftchapterbreak}{\pagebreak[2]}

\renewcommand\cftchapterfont{\sffamily\bfseries}
\let\cftchapterpagefont\cftchapterfont
\renewcommand\precistocfont{\normalfont\sffamily\itshape\small}
\renewcommand\precistocformat{% discourage hyphenation
    \hyphenpenalty=5000
    \tolerance=1000
    \noindent\narrowragged}

% TODO balance precis in TOC
\renewcommand\cftsectionfont{\sffamily}
\let\cftsectionpagefont\cftsectionfont
\renewcommand\cftsubsectionfont{\sffamily\itshape}
\let\cftsubsectionpagefont\cftsectionfont
\cftsetindents{part}{0pt}{0em}
\renewcommand{\cftpartpresnum}{\hspace{-4em}\hfill}
\renewcommand{\cftpartaftersnum}{\quad}
\cftsetindents{chapter}{0pt}{0em}
\renewcommand{\cftchapterpresnum}{\hspace{-4em}\hfill}
\renewcommand{\cftchapteraftersnum}{\quad}
\cftsetindents{section}{0pt}{0em}
\renewcommand{\cftsectionpresnum}{\hspace{-4em}\hfill}
\renewcommand{\cftsectionaftersnum}{\quad}
\cftsetindents{subsection}{0pt}{3em}
\setrmarg{3.55em plus 1fil}% help avoid hyphenation

%% figures & tables, like sections
\let\cftfigurefont\cftsectionfont
\let\cftfigurepagefont\cftfigurefont
\cftsetindents{figure}{0pt}{0em}
\renewcommand{\cftfigurepresnum}{\hspace{-4em}\hfill}
\renewcommand{\cftfigureaftersnum}{\quad}
\let\cfttablefont\cftsectionfont
\let\cfttablepagefont\cfttablefont
\cftsetindents{table}{0pt}{0em}
\renewcommand{\cfttablepresnum}{\hspace{-4em}\hfill}
\renewcommand{\cfttableaftersnum}{\quad}

% merged list of figures/tables: \newlistofb ?

%%%
%%% Page styles & folios
%%%
\def\headfootfont{\small\sffamily}
%% main page style variant
\makepagestyle{sba-headings}
\makeevenhead{sba-headings}{}{}{\ifonlyfloats{}{\headfootfont\leftmark}}
\makeoddhead {sba-headings}{\ifonlyfloats{}{\headfootfont\rightmark}}{}{}
\makeevenfoot{sba-headings}{\headfootfont\bfseries\thepage}{}{}
\makeoddfoot {sba-headings}{}{}{\headfootfont\bfseries\thepage}
\makepsmarks{sba-headings}{\nouppercaseheads
    \createmark{chapter}{left}{nonumber}{}{}
    \createmark{section}{right}{shownumber}{}{\quad}}
%% page style variant without headings
\makepagestyle{sba-plain}
\makeevenfoot{sba-plain}{\headfootfont\bfseries\thepage}{}{}
\makeoddfoot {sba-plain}{}{}{\headfootfont\bfseries\thepage}
%% no folio on float-only pages
\mergepagefloatstyle{sba}{sba-headings}{empty}

\aliaspagestyle{plain}{sba}
\aliaspagestyle{book}{empty}
\aliaspagestyle{part}{empty}
\aliaspagestyle{chapter}{sba-plain}

%%%
%%% Floats
%%%
\captionnamefont{\sffamily\bfseries}
\captiontitlefont{\sffamily}
\renewcommand\sidecapfloatwidth{.5\linewidth}% ahould adjust \sidecapwidth accordingly

%%%
%%% Graphics
%%%
\RequirePackage{tikz}
\definecolor{shadecolor}{gray}{0.9} % FIXME really needed?

%%%
%%% Source code
%%%
\RequirePackage{listings}

\renewcommand{\lstlistlistingname}{Code examples}
\lstset{
    inputencoding=utf8,
    columns=fullflexible,
    basicstyle=\small\ttfamily
}

\lstnewenvironment{script}[2][defaultlabel]{%
    % \renewcommand{\lstlistingname}{Script}%
    \lstset{
        name={Script},
        caption={\emph{#2}},
        label={scr:#1},
        frame=tb,
        framerule=\heavyrulewidth,
        mathescape=false,
    }
}{}

%% verbatim setup
\bvtopandtail % \bvsides
\setlength{\bvboxsep}{.25em}
\tabson[4]
\setverbatimfont{\normalfont\ttfamily\small}

%%%
%%% Language, localizations, hyphenation
%%%
\RequirePackage{polyglossia}
