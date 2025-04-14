%% File: `iasbs-thesis.cls', Version 2.37
%%
%% This document class is designed based of xepersian v25.0 
%% for academic theses at the Institute for Advanced Studies 
%% in Basic Sciences (IASBS).
%%
%% ______________________________________________
%% Copyright © 2009–2025 IASBS
%% The initial version (v1.xx) of this document class
%% was developed by Mohammad Charsooghi as `xepersian-thesis-iasbs.cls',
%% based on `xepersian-thesis'.
%% The current version (v2.xx) has been revised and extended
%% by M. D. Niry since January 12, 2025.
%%
%% If you encounter any errors or bugs while using this class,
%% please inform me via email: m.d.niry@iasbs.ac.ir
%% To help identify and resolve the problem, try to create a 
%% simplified case where other parts of the thesis are removed, 
%% and send it to me. I would also greatly appreciate any
%% suggestions to improve this class and make it more user-
%% friendly for students. Feel free to share your feedback or
%% recommendations without hesitation.
%%
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{iasbs-thesis}[2025/04/14 v2.37
  IASBS Thesis document class in XeLaTeX]
\DeclareOption*{ % Handle all options
  \PassOptionsToClass{\CurrentOption}{report}
}
\ProcessOptions\relax % Apply all options
\LoadClass{report} % Load the base report class


\RequirePackage{ifthen,etoolbox} % For advanced macro processing


% Manage the thesis class options
\newif\ifphd
\newif\ifmaster
\newif\ifgraduate
\newif\ifproposal
\newif\ifthesis
\newif\ifreview

\DeclareOption{phd}{\phdtrue \graduatetrue}
\DeclareOption{master}{\mastertrue \graduatetrue}
\DeclareOption{proposal}{\proposaltrue}
\DeclareOption{review}{\reviewtrue}
\DeclareOption*{} % Handle all other options

\ProcessOptions\relax % Apply all options

\ifproposal
  \thesisfalse
\else
  \ifgraduate
    \thesistrue
  \fi
\fi

% Load required packages -----------------------------------
\RequirePackage{graphicx}
\RequirePackage{calc} % For performing basic calculations on lengths
%\RequirePackage{float}
\RequirePackage{fontspec}
\RequirePackage{amsmath, amssymb, xfrac}
\RequirePackage{bm,bbold} % boldface or doublestroke font; for something like: \mathbb{1}
\RequirePackage{relsize} % For larger \int symbol; using \mathlarger
\RequirePackage{xspace} % \xsapce inserts the space if there isn't a punctuation mark. Following line is used for xepersian.
\xspaceaddexceptions{، ؛ \LTRfootnote}
\RequirePackage{xecolour, xcolor, listings}
\RequirePackage{listingsutf8} % Enable UTF-8 support for listings
\usepackage[small]{caption} % Use small font size for cation.
\RequirePackage{tabularx} % Same as tabular* environment, but modifies the widths of columns.
\RequirePackage{array,hhline,multirow} % For advanced table formating
\RequirePackage{etoolbox} % For advanced macro processing
\RequirePackage{verbatim}
% Requirments of the easyReview package --------------------
\let\comment\texcomment % The easyReview redefines \comment, so let save the definition of the verbatim as \texcomment
\RequirePackage{easyReview} % for \comment, \alert, \remove, \highlight and \replace command which are useful in draft mode
\RequirePackage{bidihl}
\RequirePackage[normalem]{ulem} % \st is not compatible with bidi
\let\LTRcomment\comment
\ifreview
  \renewcommand{\hl}[1]{\bidihl{#1}} % \hl is not fully compatible with bidi
  \renewcommand{\comment}[2]{\LTRcomment{#1}{\vspace*{-12pt}\begin{flushright}\rl{#2}\end{flushright}}}
  \renewcommand{\st}[1]{\sout{#1}}
\else
  \setreviewsoff
  \renewcommand{\hl}[1]{#1}
  \renewcommand{\comment}[2]{#1}
  \renewcommand{\st}[1]{}
\fi
% End of requirments of the easyReview package -------------
\RequirePackage[font=small,floatrowsep=qquad,captionskip=5pt]{floatrow} % Side caption; floatrow do not work with float package
\floatsetup[table]{style=plaintop}
\floatsetup[figure]{style=plain}
\RequirePackage{subcaption}
\RequirePackage{rotating} % A package for rotating text and figures
\RequirePackage{algorithm, algpseudocode} % Provides an algorithmic environment
\RequirePackage{multicol} % Provides multicols environment
\RequirePackage[top=40mm,right=24mm,bottom=24mm,left=36mm]{geometry} % For page margins
\setlength{\headheight}{16pt} % Increase \headheight from 12pt to 16pt.
\addtolength{\topmargin}{-4pt} % Decrease \topmargin to compensate
\RequirePackage{fancyhdr} % Used for setting headers and page numbers
\RequirePackage{setspace} % To adjust line spacing
%\RequirePackage[Lenny]{fncychap}
\RequirePackage{cite} % Concatenate citations: [1,2,3,4] --> [1-4]
\RequirePackage[hyphens]{url}
\RequirePackage[colorlinks,linkcolor=blue,citecolor=blue]{hyperref}
\RequirePackage{bookmark} % Manages bookmarks in pdf files
%\bookmarksetup{stationary}
\RequirePackage{makeidx} % Creating indexes
\RequirePackage[section]{tocbibind} % The tocbibind package can be used to add document elements like a bibliography to the Table of Contents.
\RequirePackage{zref-totpages}
%\RequirePackage{natbib} % For Department of Mathematics


% Patch \begin{figure} and \end{table} to count figures and tables.
\newcounter{@totfigures}
\newcounter{@tottables}
\providecommand\@totfig{} % Define the command if it is not loaded from mai auxilary file.
\providecommand\@tottab{} % Define the command if it is not loaded from mai auxilary file.
\AtBeginEnvironment{figure}{\stepcounter{@totfigures}}
\AtBeginEnvironment{table}{\stepcounter{@tottables}}
\AtBeginEnvironment{sidewaysfigure}{\stepcounter{@totfigures}}
\AtBeginEnvironment{sidewaystable}{\stepcounter{@tottables}}

% Provide command to store (load) the content of list of symbols into (from) the main auxilary file.
\providecommand\@listofsymbols{}


% Additional settings for headers
%  \renewcommand{\chaptermark}[1]{%
%    \markboth{\chaptername\ \thechapter.\ #1}{}}
%  \renewcommand{\sectionmark}[1]{%
%    \markright{\thesection.\ #1}}

% Init the thesis document class ---------------------------
\newcommand{\initstyle}{ % This must be the final command executed before the begin document.
  \typeout{Initialize the document class and thesis style.}
  \typeout{The XePersian package and the zref-perpage package are being loaded.}
  \usepackage[extrafootnotefeatures]{xepersian}
  \twocolumnfootnotes
  \usepackage{zref-perpage}
  \zmakeperpage{footnote} % restart footnote index in every pages

  \typeout{The XePersian package will load the fonts.}
  \settextfont[Scale=1.07]{XB Niloofar}[Script=Persian] % Use this line with the new version of xepersian (v23.3).
  \IfFontExistsTF{Times New Roman}{ % Select Latin font
    \setlatintextfont[Scale=1.05]{Times New Roman}}{
    \IfFontExistsTF{DejaVu Serif}{
      \setlatintextfont[Scale=1.03]{DejaVu Serif}}{
      \IfFontExistsTF{Liberation Serif}{
        \setlatintextfont[Scale=1.06]{Liberation Serif}}{
        \typeout{Install 'Times New Roman' or 'DejaVu Serif' font.}
      }
    }
  }

  %\ExplSyntaxOn
  %\cs_set_eq:NN
  %\etex_iffontchar:D
  %\tex_iffontchar:D
  %\cs_undefine:N \c_one
  %\int_const:Nn \c_one { 1 }
  %\ExplSyntaxOff
  \setdigitfont[Scale=1.05]{Yas} % Purpose: To have a zero digit as an empty circle

  \defpersianfont\nastaliqXL[Scale=2.0]{IranNastaliq}
  \defpersianfont\nastaliq[Scale=1.0]{IranNastaliq}

  \typeout{Configuring the page style and setting the page numbering to 'adadi'.}
  \pagestyle{plain} % Include page numbers in the document
  \pagenumbering{adadi}

  \AtBeginDocument{ % Make the front matter of thesis
    \setlength{\parskip}{10pt} % Adjust the space between paragraphs
    \setlength{\parindent}{0pt} % Adjust the space at the begining of paragraphs
    \setstretch{1.2} % Space between lines

    \typeout{Generating the front matter of the thesis.}
    \@makefrontmatter

    \cleardoublepage % begin chapters at an odd page
    \pagenumbering{arabic}\setcounter{page}{1}

    % Set the header and page number
    \typeout{Configuring the header of the main matter.}
    \pagestyle{fancy} % Set the page style to "fancy"
    \fancyhf{} % Clear all default header and footer settings
    \fancyhead[OL,ER]{\thepage} % Page number on the outer side of pages (OL: Odd Left, ER: Even Right)
    \fancyhead[OR]{\leftmark} % Chapter title on odd pages (OR: Odd Right)
    \fancyhead[EL]{\@title} % Thesis title on even pages (EL: Even Left)
  }

  \AtEndDocument{ % Make the end matter of thesis
    \typeout{Generating the end matter of the thesis.}
    \@makeendmatter

    \typeout{Write definitions and values of two variables in the main auxilary file.}

    % Write the total number of figures and tables in the main auxilary file.
    \immediate\write\@mainaux{
      \string\gdef\string\@totfig{\number\value{@totfigures}}
      \string\gdef\string\@tottab{\number\value{@tottables}}
    }

    % Wrtie the content of list of symbols in the main auxilary file.
    \immediate\write\@mainaux{
      \string\gdef\string\@listofsymbols{\detokenize\expandafter{\@farsilistofsymbols}}
    }
  }
}


\newcommand{\scaletext}[2]{ % Scale the text to fit the text width (\textwidth), with a maximum font size limit.
  \begingroup % Begin a local group to confine changes.
    \setlength{\fboxsep}{0pt} % Remove any extra spacing around the text box.

    \newlength{\@mylen} % Declare a new length variable.
    \settowidth{\@mylen}{#2 #1} % Calculate the width of the text.

    \ifdim\textwidth<\@mylen % Check if the text width is smaller than the calculated width.
        \resizebox{\textwidth}{!}{#1} % Scale the text proportionally to fit the text width.
    \else
        {#2 #1} % Use the specified font size if the calculated width is within the limit.
    \fi
    \global\let\@mylen\undefined % Delete the length variable
  \endgroup % Close the local group and restore previous settings
}


% Save the previous definition of the abstract environment
\let\@oldabstract\abstract
\let\@endoldabstract\endabstract
\ExplSyntaxOn % Undefine the 'abstract' environment
\cs_undefine:N \abstract
\cs_undefine:N \endabstract
\ExplSyntaxOff


% Prepare thesis information -------------------------------
\newif\iflatinfieldexist
\newif\iffarsifieldexist
\newif\iflatinsubfieldexist
\newif\iffarsisubfieldexist
\newif\iflatinsubtitleexist
\newif\iffarsisubtitleexist
\newif\iflatinsubsubtitleexist
\newif\iffarsisubsubtitleexist
\newif\ifmultisupervisor
\newif\iflatinadvisorexist
\newif\iffarsiadvisorexist
\newif\ifmultiadvisor
\newif\ifdedicationexist
\newif\ifacknowledgmentexist

% Defining internal Farsi variables
\newcommand{\@farsidepartment}{}
\newcommand{\@farsifield}{}
\newcommand{\@farsisubfield}{}
\newcommand{\@farsisubtitle}{}
\newcommand{\@farsisubsubtitle}{}
\newcommand{\@farsidegree}{\ifproposal پیشنهاد پروژهٔ
                           \else \ifphd رسالهٔ
                                 \else \ifmaster پایان‌نامهٔ
                                       \else گزارش پروژهٔ
                                       \fi
                                 \fi
                           \fi
                           \ifphd دکتری
                           \else \ifmaster کارشناسی ارشد
                                 \else کارشناسی
                                 \fi
                           \fi
}
\newcommand{\@farsisupervisor}{}
\newcommand{\@farsiadvisor}{}
\newcommand{\@dedication}{}
\newcommand{\@acknowledgment}{}
\newcommand{\@farsiabstract}{}
\newcommand{\@farsikeywords}{}
\newcommand{\@farsicommittee}{}
\newcommand{\@farsistudentid}{}
\newcommand{\@farsinationalid}{}
\newcommand{\@farsilistofsymbols}{}
\newcommand{\@farsilistofsymbolscolumns}{1}


% Defining internal English variables
\newcommand{\@latindepartment}{}
\newcommand{\@latinfield}{}
\newcommand{\@latinsubfield}{}
\newcommand{\@latintitle}{}
\newcommand{\@latinsubtitle}{}
\newcommand{\@latinsubsubtitle}{}
\newcommand{\@latindegree}{\ifphd PhD
                           \else \ifmaster Master's
                                 \else Bachelor's
                                 \fi
                           \fi
                           \ifproposal Proposal
                           \else \ifphd Dissertation
                                 \else \ifmaster Thesis
                                       \else Project Report
                                       \fi
                                 \fi
                           \fi
}
\newcommand{\@latinauthor}{}
\newcommand{\@latinsupervisor}{}
\newcommand{\@latinadvisor}{}
\newcommand{\@latindate}{}
\newcommand{\@latinabstract}{}
\newcommand{\@latinkeywords}{}
\newcommand{\@latincommittee}{}


% Define new commands
\newcommand{\dash}{% short dash between two word
\ifRtoL{\hspace{0.5pt}\raisebox{-2pt}{\lr{-}}\hspace{0.1pt}}{-}}
\newcommand{\emdash}{% short dash between two word
\ifRtoL{\hspace{0.5pt}\raisebox{-2pt}{\lr{---}}\hspace{0.5pt}}{---}}
\newcommand{\unit}[1]{% \unit is used to insert an SI unit to formulas
\ensuremath{\,\mathrm{#1}}}
\newcommand{\degC}{% displays the symbol for degrees Celsius
{\ensuremath{^\circ\mathrm{C}}}}
\let\@originald\d % Save the previous definition of the \d
\renewcommand{\d}[1]{ % redefine \d, in math mode it display diffrential and in text
  \ifmmode            % works as original definition.
    \,\mathrm{d}#1
  \else
    \@originald{#1}
  \fi
}
\newcommand{\department}[2]{\renewcommand{\@latindepartment}{#1}
                            \renewcommand{\@farsidepartment}{#2}
}
\newcommand{\field}[2]{\renewcommand{\@latinfield}{#1}
                       \renewcommand{\@farsifield}{#2}
                       \ifthenelse{\equal{#1}{}}{}{\latinfieldexisttrue}
                       \ifthenelse{\equal{#2}{}}{}{\farsifieldexisttrue}
}
\newcommand{\subfield}[2]{\renewcommand{\@latinsubfield}{#1}
                          \renewcommand{\@farsisubfield}{#2}
                          \ifthenelse{\equal{#1}{}}{}{\latinsubfieldexisttrue}
                          \ifthenelse{\equal{#2}{}}{}{\farsisubfieldexisttrue}
}
\renewcommand{\title}[2]{\renewcommand{\@latintitle}{#1}
                         \renewcommand{\@title}{#2}
}
\newcommand{\subtitle}[2]{\renewcommand{\@latinsubtitle}{#1}
                          \renewcommand{\@farsisubtitle}{#2}
                          \ifthenelse{\equal{#1}{}}{}{\latinsubtitleexisttrue}
                          \ifthenelse{\equal{#2}{}}{}{\farsisubtitleexisttrue}
}
\newcommand{\subsubtitle}[2]{\renewcommand{\@latinsubsubtitle}{#1}
                             \renewcommand{\@farsisubsubtitle}{#2}
                             \ifthenelse{\equal{#1}{}}{}{\latinsubsubtitleexisttrue}
                             \ifthenelse{\equal{#2}{}}{}{\farsisubsubtitleexisttrue}
}
\newcommand{\thesis}{\ifproposal پیشنهاد پروژه% Don't remove comment and don't add any space to the following lines!
\else \ifphd رساله%
\else \ifmaster پایان‌نامه%
\else گزارش پروژه%
\fi
\fi
\fi\xspace
}
\renewcommand{\author}[2]{\renewcommand{\@latinauthor}{#1}
                          \renewcommand{\@author}{#2}
}
\newcommand{\supervisor}[2]{ % Add a supervisor
   \ifthenelse{\equal{\@latinsupervisor}{}}{
     \g@addto@macro\@latinsupervisor{
       #1
     }
   }{
     \g@addto@macro\@latinsupervisor{
       \\ &  #1
     }
     \multisupervisortrue
   }
   \ifthenelse{\equal{\@farsisupervisor}{}}{
     \g@addto@macro\@farsisupervisor{
       #2
     }
   }{
     \g@addto@macro\@farsisupervisor{
       \\ & #2
     }
     \multisupervisortrue
   }
}
\newcommand{\advisor}[2]{ % Add an advisor
   \ifthenelse{\equal{\@latinadvisor}{}}{
     \g@addto@macro\@latinadvisor{
       & #1
     }
     \latinadvisorexisttrue
   }{
     \g@addto@macro\@latinadvisor{
       \\ & #1
     }
     \multiadvisortrue
   }
   \ifthenelse{\equal{\@farsiadvisor}{}}{
     \g@addto@macro\@farsiadvisor{
       & #2
     }
     \farsiadvisorexisttrue
   }{
     \g@addto@macro\@farsiadvisor{
       \\ & #2
     }
     \multiadvisortrue
   }
}
\renewcommand{\date}[2]{\renewcommand{\@latindate}{#1}
                        \renewcommand{\@date}{#2}
}
\newcommand{\dedication}[1]{\renewcommand{\@dedication}{#1}
                            \ifthenelse{\equal{#1}{}}{}{\dedicationexisttrue}
}
\newcommand{\acknowledgment}[1]{\renewcommand{\@acknowledgment}{#1}
                                %\ifthenelse{\equal{#1}{}}{}{\acknowledgmentexisttrue}
                                \acknowledgmentexisttrue
}
\newcommand{\abstract}[2]{\renewcommand{\@latinabstract}{#1}
                          \renewcommand{\@farsiabstract}{#2}
}
\newcommand{\keywords}[2]{\renewcommand{\@latinkeywords}{#1}
                          \renewcommand{\@farsikeywords}{#2}
}
\newcommand{\committeemember}[6]{ % Add a member of review committee
   \g@addto@macro\@farsicommittee{
     {\large #4} (#5)\\[-0.5ex]\hline
     \textbf{\scriptsize #6}\\[3ex]
   }
   \g@addto@macro\@latincommittee{
     {\large #1} (#2)\\[-0.5ex]\hline
     \textbf{\scriptsize #3}\\[3ex]
   }
}
\newcommand{\studentid}[1]{\renewcommand{\@farsistudentid}{$#1$}}
\newcommand{\nationalid}[1]{\renewcommand{\@farsinationalid}{$#1$}}
\newcommand{\addsymbolslist}[2]{ % Add an item to the list of symbols
   \g@addto@macro\@farsilistofsymbols{
     \item[#1] #2
   }
}
\newcommand{\twocolumnsybolslist}{\renewcommand{\@farsilistofsymbolscolumns}{2}}
\newcommand{\feglossaries}{ % Make Farsi to English Glossaries
  \cleardoublepage
  \fancyhead[OR]{واژه‌نامهٔ فارسی به انگلیسی} % Chapter title on odd pages (OR: Odd Right)
  \thispagestyle{plain} % Remove header on this specific page
  \phantomsection % required when using hyperref
  \addcontentsline{toc}{section}{واژه‌نامهٔ فارسی به انگلیسی}
  \section*{واژه‌نامهٔ فارسی به انگلیسی}
}
\newcommand{\fegitem}[2]{% Insert a Farsi to English glossary entry
  #1\dotfill\lr{#2}\\}

% Farsi keywords for algorithmic environment
\renewcommand{\algorithmicif}{\textbf{\iflatin{if}{اگر}}}
\renewcommand{\algorithmicthen}{\textbf{\iflatin{then}{آنگاه}}}
\renewcommand{\algorithmicelse}{\textbf{\iflatin{else}{وگرنه}}}
\renewcommand{\algorithmicdo}{\textbf{\iflatin{do}{انجام بده}}}
\renewcommand{\algorithmicend}{\textbf{\iflatin{end}{پایان}}}
\renewcommand{\algorithmicfor}{\textbf{\iflatin{for}{برای}}}
\renewcommand{\algorithmicloop}{\textbf{\iflatin{loop}{حلقه}}}
\renewcommand{\algorithmicwhile}{\textbf{\iflatin{while}{تازمانی‌که}}}
\renewcommand{\algorithmicrepeat}{\textbf{\iflatin{repeat}{تکرار کن}}}
\renewcommand{\algorithmicuntil}{\textbf{\iflatin{until}{تا}}}


% Farsi Title Page -----------------------------------------
\newcommand{\@makefarsititlepage}{
  \typeout{Generate the Farsi title page.}
  \thispagestyle{empty}
  \begin{titlepage}\begin{center}
    % logo
    \large\includegraphics[width=7cm]{logo-fa.eps}\\[0.5em]
    % department
    \textbf{\@farsidepartment}\\[8pt]
    % field and subfield
    \iffarsifieldexist
        \normalsize
        \iffarsisubfieldexist
            \textbf{\@farsifield~(\@farsisubfield)}
        \else
            \textbf{\@farsifield}
        \fi\\[2.5em]
    \else
        \iffarsisubfieldexist
            \normalsize\textbf{\@farsisubfield}\\[2.5em]
        \fi
    \fi
    % title and subtitle
    \Huge\scaletext{\textbf{\@title}}{\Huge}
    \iffarsisubtitleexist
        \\[4pt]\scaletext{\textbf{\@farsisubtitle}}{\LARGE}
    \fi
    \iffarsisubsubtitleexist
        \\[-4pt]\scaletext{\textbf{\@farsisubsubtitle}}{\large}
    \fi\\[2em]
    % degree
    \Large\textbf{\@farsidegree}{\hspace{-2mm}ِ}\\[1em]
    % author
    \textbf{\LARGE\@author}\\
    \vfill
    % List of supervisor(s) and advisor(s)
    \begin{tabular}{rr}
        \ifmultisupervisor
          \textbf{اساتید راهنما:}
        \else
          \textbf{استاد راهنما:}
        \fi & \@farsisupervisor \\
        \iffarsiadvisorexist
            \ifmultiadvisor
              \textbf{مشاوران:}
            \else
              \textbf{مشاور:}
            \fi \@farsiadvisor
        \fi
    \end{tabular}
    \vfill
    % date
    \@date\\[2em]
  \end{center}\end{titlepage}
}


% Latin Title Page -----------------------------------------
\newcommand{\@makelatintitlepage}{
  \typeout{Generate the latin title page.}
  \thispagestyle{empty}
  \begin{titlepage}\begin{center}\begin{latin}    
    % logo
    \large\includegraphics[width=7cm]{logo-en.eps}\\[0.5em]
    % department
    \textbf{\@latindepartment}\\[8pt]
    % field and subfield
    \iflatinfieldexist
        \normalsize
        \iflatinsubfieldexist
            \textbf{\@latinfield~(\@latinsubfield)}
        \else
            \textbf{\@latinfield}
        \fi\\[2.5em]
    \else
        \iflatinsubfieldexist
            \normalsize\textbf{\@latinsubfield}\\[2.5em]
        \fi
    \fi
    % title and subtitle
    \Huge\scaletext{\textbf{\@latintitle}}{\Huge}
    \iflatinsubtitleexist
        \\[-4pt]\scaletext{\textbf{\@latinsubtitle}}{\LARGE}
    \fi
    \iflatinsubsubtitleexist
        \\[-8pt]\scaletext{\textbf{\@latinsubsubtitle}}{\large}
    \fi\\[2em]
    % degree
    \Large\textbf{\@latindegree}\\[0.5em]
    \textbf{by}\\[0.5em]
    % author
    \textbf{\LARGE\@latinauthor}\\
    \vfill
    % List of supervisor(s) and advisor(s)
    \begin{tabular}{ll}
        \ifmultisupervisor
          \textbf{Supervisors:}
        \else
          \textbf{Supervisor:}
        \fi & \@latinsupervisor \\
        \iflatinadvisorexist
          \ifmultiadvisor
            \textbf{Advisors:}
          \else
            \textbf{Advisor:}
          \fi \@latinadvisor
        \fi
    \end{tabular}
    \vfill
    % date
    \@latindate\\[2em]
  \end{latin}\end{center}\end{titlepage}
}


% Besm page ------------------------------------------------
\newcommand{\@makebesmpage}{
    \typeout{Generate the besm page.}
    \newpage
    \thispagestyle{empty}
    \vspace*{4cm}
    \begin{center}
    \includegraphics[width=12cm]{besm}
    \end{center}
}


% Dedication page ------------------------------------------
\newcommand{\@makededicationpage}{
    \typeout{Generate the dedication page.}
    \ifdedicationexist
        \newpage
        \begin{center}
        \Huge\nastaliqXL
        \vspace*{2cm}
        \@dedication
        \end{center}
    \fi
}


% Acknowledgment page ------------------------------------------
\newcommand{\@makeacknowledgmentpage}{
    \typeout{Generate the acknowledgment page.}
    \ifacknowledgmentexist
        \newpage
        \begin{center}
        \Large\nastaliq
تشکر و قدردانی\\[0.5em]
        \end{center}
        \phantomsection\label{acknowledgement}
        \addcontentsline{toc}{section}{تشکر و قدردانی} % add this section to contents table
        \@acknowledgment
    \fi
}


% Farsi abstract page --------------------------------------
\newcommand{\@farsiabstractpage}{
    \typeout{Generate the Farsi abstract page.}
    \phantomsection % required if using hyperref
    \addcontentsline{toc}{section}{چکیده} % To add the abstract in the index.
    \begin{center}
      \textbf{\large\@title
        \iffarsisubtitleexist
          \xspace\@farsisubtitle
        \fi
        \iffarsisubsubtitleexist
          \\\@farsisubsubtitle
        \fi
      }\\[4pt]
      \large\textbf{\@author}\\[8pt]
    \end{center}
    %\@oldabstract
    \@farsiabstract
    \par\vspace{5mm}
    \noindent\textbf{واژه‌های کلیدی:} {\textit{\@farsikeywords}}
    %\@endoldabstract
}


% Latin abstract page --------------------------------------
\newcommand{\@latinabstractpage}{
  \typeout{Generate the latin abstract page.}
  \begin{latin}
    \phantomsection % required if using hyperref
    \addcontentsline{toc}{section}{Abstract} % To add the abstract in the index.
    \begin{center}
      \textbf{\large\@latintitle
        \iflatinsubtitleexist
          \xspace\@latinsubtitle
        \fi
        \iflatinsubsubtitleexist
          \\\@latinsubsubtitle
        \fi
      }\\[4pt]
      \large\textbf{\@latinauthor}\\[8pt]
    \end{center}
    %\@oldabstract
    \@latinabstract
    \par\vspace{5mm}
    \noindent\textbf{Keywords:} \textit{\@latinkeywords}
    %\@endoldabstract
  \end{latin}
}


% Farsi Copyright page -------------------------------------
\newcommand{\@farsicopyrightpage}{
    \typeout{Generate the Farsi copyright page.}
    \null
    \vfill
    \ifphd
شناسنامه رسالهٔ دکتری\\[2pt]
    \else\ifmaster
شناسنامه پایان‌نامهٔ کارشناسی ارشد\\[2pt]
    \fi\fi
    \begin{tabular}{rr}
      \hline\noalign{\smallskip}
عنوان: &
      \textbf{\@title
        \iffarsisubtitleexist
          \xspace\@farsisubtitle
        \fi
      }\\
      & \textbf{\@farsisubsubtitle}\\
نگارنده: &
      \textbf{\@author}\\[8pt]
شماره دانشجویی: &
      \@farsistudentid\\
شماره ملی: &
      \@farsinationalid\\
تعداد صفحات: &
      \ifreview
        \number\numexpr\ztotpages-1\relax\\
      \else
        \number\numexpr\ztotpages-2\relax\\
      \fi
تعداد اشکال: &
      \@totfig\\
تعداد جداول: &
      \@tottab\\
دانشکده: &
      \@farsidepartment\\
رشته (گرایش): &
      \@farsifield
      \iffarsisubfieldexist
      \xspace(\@farsisubfield)
      \fi\\
تاریخ: &
      \@date\\[4pt]
      \hline
    \end{tabular}\\[8pt]
\ifphd
حقوق تألیف این رساله برای نگارنده محفوظ است و هرگونه استفاده، تکثیر یا پخش مطالب آن به‌صورت جزئی یا کلی بدون مجوز کتبی نگارنده جز برای دانشگاه تحصیلات تکمیلی علوم‌پایه زنجان ممنوع است.\\[4pt]
برای تحقیق اصالت این رساله
\else\ifmaster
حقوق تألیف این پایان‌نامه برای نگارنده محفوظ است و هرگونه استفاده، تکثیر یا پخش مطالب آن به‌صورت جزئی یا کلی بدون مجوز کتبی نگارنده جز برای دانشگاه تحصیلات تکمیلی علوم‌پایه زنجان ممنوع است.\\[4pt]
برای تحقیق اصالت این پایان‌نامه
\fi\fi
با آموزش دانشگاه تحصیلات تکمیلی علوم‌پایه زنجان
به آدرس پستی زنجان، گاوازنگ، بلوار پروفسور یوسف ثبوتی، 
زنجان
$45137-66731$،
ایران یا پست الکترونیک
\href{mailto:edu@iasbs.ac.ir}{edu@iasbs.ac.ir}
مکاتبه فرمایید.
}


% Latin copyright page -------------------------------------
\newcommand{\@latincopyrightpage}{
  \typeout{Generate the latin copyright page.}
  \thispagestyle{empty}
  \begin{latin}
  \begin{center}
    \null
    \vfill
    Copyright~\textcopyright~by \@latinauthor\\[8pt]
    \@latindate
    \vspace{2ex}
  \end{center}
  \end{latin}
}


% Farsi signature papge ------------------------------------
\newcommand{\@farsiapprovalpage}{
    \typeout{Generate the Farsi approval page.}
    \begin{center} % Title and author
      \textbf{\large\@title
        \iffarsisubtitleexist
          \xspace\@farsisubtitle
        \fi
        \iffarsisubsubtitleexist
          \\ \@farsisubsubtitle
        \fi
      }\\[4pt]
      \large\textbf{\@author}\\[8pt]
    \end{center}
    \onehalfspacing

    \ifphd
این رساله به‌عنوان بخشی از مدارک لازم برای اخذ درجهٔ دکتری ارائه و در کمیته زیر بررسی و تایید شده است:
    \else\ifmaster
این پایان‌نامه به‌عنوان بخشی از مدارک لازم برای اخذ درجهٔ کارشناسی ارشد ارائه و در کمیته زیر بررسی و تایید شده است:
    \fi\fi
    \vspace{0.5in}

    \setstretch{1}
    \noindent\small
    \begin{tabularx}{\textwidth}{X}
      \@farsicommittee
    \end{tabularx}

    \vfill

    \noindent\textbf{
      \large\@date\\[4pt]
      \@farsidepartment\\[4pt]
دانشگاه تحصیلات تکمیلی علوم‌پایه زنجان
    }
}


% Latin signature papge ------------------------------------
\newcommand{\@latinapprovalpage}{
  \typeout{Generate the latin approval page.}
  \begin{latin}
    \begin{center} % Title and author
      \textbf{\large\@latintitle
        \iflatinsubtitleexist
          \xspace\@latinsubtitle
        \fi
        \iflatinsubsubtitleexist
          \\\@latinsubsubtitle
        \fi
      }\\[4pt]
      \large\textbf{\@latinauthor}\\[8pt]
    \end{center}
    \onehalfspacing

    \ifphd
      This dissertation, sumitted in partial fulfillment of the requirements for the degree of doctor of philosophy, has been examined and approved by the following committee members.
    \else\ifmaster
      This thesis, submitted in partial fulfillment of the requirements for the master's degree, has been examined and approved by the following committee members.
    \fi\fi
    \vspace{0.5in}

    \setstretch{1}
    \noindent\small
    \begin{tabularx}{\textwidth}{X}
      \@latincommittee
    \end{tabularx}

    \vfill

    \noindent\textbf{
      \large\@latindate\\[4pt]
      \@latindepartment\\[4pt]
       Institute for Advanced Studies in Basic Sciences (IASBS)
    }
  \end{latin}
}


% Farsi declaaration page ----------------------------------
\newcommand{\@farsideclarationpage}{
  \typeout{Generate the declaration page.}
  \fbox{\quad\begin{minipage}{\textwidth}
    \vspace{8pt}
    \begin{center}
      \large\textbf{اعلامیه}
    \end{center}
اینجانب بدین وسیله اعلام می‌دارم که این
\thesis
نتیجه کار و پژوهش شخصی‌ام از تاریخ ثبت‌نام در دورهٔ دکتری دانشگاه تحصیلات تکمیلی علوم‌پایه زنجان، با استفاده از امکانات مادی و معنوی است که دانشگاه برایم فراهم کرده است. تمامی یا قسمتی از آن قبلاً در هیچ پایان‌نامه یا رساله‌ای که به این دانشگاه یا هر نهاد علمی دیگری برای دریافت درجهٔ دکتری، کارشناسی ارشد، یا دیگر مدارک تحصیلی ارائه شده باشد، گنجانده نشده است. در هر جای این
\thesis
که از سایر مستندات علمی برای تکمیل بحث استفاده کرده‌ام، به منبع اصلی ارجاع داده‌ام. چنان‌که عین مطلب یا شکلی را از منبع دیگری اقتباس کرده‌ام، علاوه بر ارجاع، به صراحت ذکر کرده‌ام و از صاحب منبع اصلی در بخش تشکر و قدردانی سپاسگزاری کرده‌ام.

در طول این پژوهش، راهنمایی‌های اخلاق پژوهشی و ایمنی جاری دانشگاه را رعایت کرده‌ام و مسئولیت اجرای پروتکل‌های اخلاقی و ایمنی را در کار با نمونه‌های زنده، مواد شیمیایی و تجهیزات آزمایشگاهی می‌پذیرم. تمام تلاشم را کرده‌ام که خطرات مرتبط با این پژوهش را که ممکن است حین اجرای آن به وجود آید شناسایی کنم، و مجوزهای اخلاقی و/یا ایمنی مربوطه را (در صورت لزوم) قبل از اجرا دریافت کنم.

از آنجا که این پژوهش برمبنای منابع مادی و معنوی است که دانشگاه برایم فراهم کرده است، بهره‌برداری مادی از دستاوردهای این پژوهش و سهم دانشجو، استاد و دانشگاه تابع قوانین جاری دانشگاه خواهد بود. اینجانب متعهد می‌شوم اقدام یک‌‌جانبه‌ای در این مورد انجام ندهم.
    \\[6ex]
    \@author~\rule{10em}{0.4pt}\\[8pt]
    \@date\\
  \end{minipage}\quad}
}


% Table of symbols -----------------------------------------
\newcommand{\@farsitableofsymbolspages}{ % Show the table of symbols if avalible
 \typeout{Generate the table of symbols.}
 \section*{فهرست نمادها}
 \thispagestyle{plain} % Remove header on this specific page
 \addcontentsline{toc}{section}{فهرست نمادها}

 \ifx\@listofsymbols\@empty
 \else
   \ifnum\@farsilistofsymbolscolumns=1
     \begin{description}
       \@listofsymbols
     \end{description}
   \else
     \begin{multicols}{\@farsilistofsymbolscolumns}
       \begin{description}
         \@listofsymbols
       \end{description}
     \end{multicols}
   \fi
 \fi
}


% Cut lines ------------------------------------------------
\newcommand{\@cutlines}{
  % B5, 176 × 250 mm
  % A4, 297 × 210 mm
  \typeout{Draw the cutlines around the page.}
  \thispagestyle{empty}
  \begin{titlepage}
    \begin{picture}(210mm,297mm)
      \put(24mm,40.2mm)               {\framebox(209.9mm,296.7mm){}} % Page margin
    \end{picture}
  \end{titlepage}
}


% Cover page -----------------------------------------------
\newcommand{\@cover}{
  \typeout{Generate the cover of thesis.}
  % B5, 176 × 250 mm
  % A3, 420 × 297 mm
  % A4, 297 × 210 mm
  % Layout of this page is A4, but when it scaled in A3, a true size of cover could be cut out (B5 + spine + B5).
  \thispagestyle{empty}
  \newgeometry{top=5mm,right=5mm,bottom=5mm,left=5mm}

  % Define the size of the cover
  \newlength{\coverheight} % Cover height is sum of the Farsi and Latin side of the cover and its spine thickness.
  \newlength{\farsisidey}  % y of the begining of the Farsi side of the cover
  \newlength{\latinsidey}  % y of the begining of the Latin side of the cover
  \newlength{\spineyi}     % y of the begining of the Spine of the cover
  \newlength{\spineyf}     % y of the ending of the Spine of the cover
  \newlength{\spineh}      % Height of the Spine of the cover
  \newlength{\@marginheight}
  \newlength{\@ribbonlength}

  % The thickness of a page is 0.1 mm in the A3 cover, which is 0.071 mm on A4 size paper.
  \setlength{\spineh}{\dimexpr 0.071mm * \ztotpages \relax}
  \setlength{\spineyi}{124.5mm}
  \setlength{\spineyf}{\dimexpr \spineyi + \spineh \relax}
  \setlength{\coverheight}{\dimexpr 249mm + \spineh \relax}
  \setlength{\farsisidey}{14mm}
  \setlength{\latinsidey}{\dimexpr 138.5mm + \spineh \relax}
  \setlength{\@marginheight}{\dimexpr \coverheight + 5mm \relax}
  \setlength{\@ribbonlength}{\dimexpr \coverheight + 9mm \relax}

  % Define custom colors
  \definecolor{customGray}{cmyk}{0, 0, 0, 0.18} % {RGB}{209, 209, 209}
  \definecolor{customRed}{cmyk}{0, 0.67, 0.67, 0.41} % {RGB}{150, 50, 50}

  \begin{titlepage}
    \begin{picture}(200mm,287mm)
      \put(0,0)         {\framebox(200mm,287mm){}} % Page margin
      \put(15mm,0)      { % Comments on border of the page
                          \begin{minipage}[10mm]{170mm}
                            \raggedleft\scriptsize
این طرح جلد در کاغذ \lr{A4} ترسیم شده است، اما وقتی آن را در مقیاس کاغذ \lr{A3} چاپ کنید، اندازه آن برای جلد \thesis چاپ شده روی کاغذ \lr{B5} مناسب خواهد شد. پاره‌خط‌ها در حاشیه جلد محل برش‌های افقی و قائم را مشخص می‌کنند.
                          \end{minipage}
                        }
      \put(10mm,10mm)   {\@covercontent}
    \end{picture}
  \end{titlepage}

  \restoregeometry % Restore default geometry
}

\newcommand{\@covercontent}{
\typeout{Generate the content of the cover of thesis.}
\begin{picture}(177mm,\coverheight)
  % Farsi-side of the cover
  \put(136mm,\farsisidey)     {\color{black}\rotatebox{90}{
                               \begin{minipage}{96.5mm}
                                 \raggedleft%
                                 % title and subtitle
                                 \scaletext{\textbf{\@title}}{\Large}
                                 \iffarsisubtitleexist
                                   \\[4pt]\scaletext{\textbf{\@farsisubtitle}}{\large}
                                   \iffarsisubsubtitleexist
                                     \\[2pt]\scaletext{\textbf{\@farsisubsubtitle}}{\large}\\[1em]
                                   \else
                                     \\[1em]
                                   \fi
                                 \else
                                   \\[1em]
                                 \fi
                                 % degree + author
                                 \textbf{\normalsize\@farsidegree{\hspace{-1mm}ِ} \@author}
                               \end{minipage}
                              }}
  \put(55mm,\farsisidey)      {\color{black}\rotatebox{90}{
                               \begin{minipage}{96.5mm}
                                 \raggedleft
                                 % List of supervisor(s) and advisor(s)
                                 \begin{tabular}{rr}
                                   \normalsize
                                   \ifmultisupervisor
                                     \textbf{اساتید راهنما:}
                                   \else
                                     \textbf{استاد راهنما:}
                                   \fi & \@farsisupervisor \\
                                   \small
                                   \iffarsiadvisorexist
                                     \ifmultiadvisor
                                       \textbf{مشاوران:}
                                     \else
                                       \textbf{مشاور:}
                                     \fi \@farsiadvisor
                                   \fi
                                 \end{tabular}
                               \end{minipage}
                              }}
  \put(16.5mm,\farsisidey)    {\color{black}\rotatebox{90}{
                               \begin{minipage}{96.5mm}
                                 \raggedleft\small
                                 \includegraphics[width=60mm]{logo-fa.eps}\\[3.2ex]
                                 \@farsidepartment،\hfill\@date
                               \end{minipage}
                              }}
  % Latin side of the cover
  \put(136mm,\latinsidey)     {\color{black}\rotatebox{90}{
                                 \begin{minipage}{96.5mm}
                                   \begin{latin}
                                     \raggedright
                                     % title and subtitle
                                     \scaletext{\textbf{\@latintitle}}{\Large}
                                     \iflatinsubtitleexist
                                         \\[2pt]\scaletext{\textbf{\@latinsubtitle}}{\large}
                                         \iflatinsubsubtitleexist
                                             \\[2pt]\scaletext{\textbf{\@latinsubsubtitle}}{\large}\\[1em]
                                         \else
                                             \\[1em]
                                         \fi
                                     \else
                                         \\[1em]
                                     \fi
                                     % degree + author
                                     \textbf{\normalsize\@latindegree by \@latinauthor}
                                   \end{latin}
                                 \end{minipage}
                              }}
  \put(55mm,138mm)            {\color{black}\rotatebox{90}{
                                \begin{minipage}{96mm}
                               \begin{latin}
                                 \raggedright
                                 % List of supervisor(s) and advisor(s)
                                 \begin{tabular}{ll}
                                     \normalsize
                                     \ifmultisupervisor
                                       \textbf{Supervisors:}
                                     \else
                                       \textbf{Supervisor:}
                                     \fi & \@latinsupervisor \\
                                     \small
                                     \iflatinadvisorexist
                                       \ifmultiadvisor
                                         \textbf{Advisors:}
                                       \else
                                         \textbf{Advisor:}
                                       \fi \@latinadvisor
                                     \fi
                                 \end{tabular}
                               \end{latin}
                               \end{minipage}
                              }}
  \put(16.5mm,138mm)          {\color{black}\rotatebox{90}{
                                \begin{minipage}{96mm}
                                \begin{latin}
                                  \raggedright\small
                                  \includegraphics[width=60mm]{logo-en.eps}\\[3.2ex]
                                  \@latindepartment,\hfill\@latindate
                                \end{latin}
                                \end{minipage}
                              }}
  % Spine
  \put(26mm,\spineyi)         {\color{black} % date
                                \begin{minipage}[c][\spineh][s]{110mm}
                                  \ifthenelse{\ztotpages > 80}{\small}{\scriptsize}
                                  \raggedleft
                                  \@date
                                \end{minipage}
                              }
  \put(56mm,\spineyi)         {\color{black} % author + title
                                \begin{minipage}[c][\spineh][s]{110mm}
                                  \ifthenelse{\ztotpages > 80}{\small}{\scriptsize}
                                  \raggedleft
                                  \@author\hfill\@title
                                  \iffarsisubtitleexist
                                  $\dots\:$
                                  \fi
                                \end{minipage}
                              }

  %\put(0,0)           {\color{black}\framebox(177mm,\coverheight){}} % Border
  \put(22mm,-4.5mm)   {\color{customRed}\rule{1.4mm}{\@ribbonlength}} % Red line
  \put(24.1mm,-4.5mm) {\color{customGray}\rule{31mm}{\@ribbonlength}} % Gray ribbon

  % Lines of paper
  \put(-10mm,\spineyi)   {\rotatebox{90}{\rule{0.2mm}{5mm}}}
  \put(182mm,\spineyi)   {\rotatebox{90}{\rule{0.2mm}{5mm}}}
  \put(-10mm,\spineyf)   {\rotatebox{90}{\rule{0.2mm}{5mm}}}
  \put(182mm,\spineyf)   {\color{black}\rotatebox{90}{\rule{0.2mm}{5mm}}}

  % Cut lines
  \put(-10mm,0)               {\rotatebox{90}{\rule{0.2mm}{5mm}}}
  \put(182mm,0)               {\rotatebox{90}{\rule{0.2mm}{5mm}}}
  \put(-10mm,\coverheight)    {\rotatebox{90}{\rule{0.2mm}{5mm}}}
  \put(182mm,\coverheight)    {\rotatebox{90}{\rule{0.2mm}{5mm}}}
  \put(0,-10mm)               {\rule{0.2mm}{5mm}}
  \put(0,\@marginheight)      {\rule{0.2mm}{5mm}}
  \put(177mm,-10mm)           {\rule{0.2mm}{5mm}}
  \put(177mm,\@marginheight)  {\rule{0.2mm}{5mm}}
\end{picture}
}


% Front Matter ---------------------------------------------
\newcommand{\@makefrontmatter}{
    %\pagenumbering{adadi}
    \ifreview
        \typeout{Generate the front matter in review mode.}
        \ifthesis
          \@cover
        \fi

        \cleardoublepage                % begin an odd page
        \@makefarsititlepage
        \@makelatintitlepage
        \ifthesis
          \@farsicopyrightpage
          \ifphd
            \newpage
            \@latincopyrightpage
          \fi
        \fi

        \ifthenelse{\boolean{phd} \OR \boolean{thesis}}{
          \cleardoublepage              % begin an odd page
          \@makebesmpage
        }{}

        \ifthesis
          \ifphd
            \newpage
            \@farsideclarationpage
          \fi
          \newpage
          \@farsiapprovalpage
          \newpage
          \@latinapprovalpage

          \cleardoublepage              % begin an odd page
          \@makededicationpage
          \@makeacknowledgmentpage
        \fi

        \cleardoublepage                % begin an odd page
        \@farsiabstractpage
        \ifthesis
          \newpage
          \@latinabstractpage
        \fi

        \ifthenelse{\boolean{phd} \OR \NOT \boolean{proposal}}{
          % Tables of contents, figures, and tables
          \typeout{Generate the table of contents.}
          \newpage
          \tableofcontents
          \ifnum\@totfig>0
            \typeout{Generate the table of figures.}
            \newpage
            \listoffigures
          \fi
          \ifnum\@tottab>0
          \typeout{Generate the table of contents.}
            \newpage
            \listoftables
          \fi
          \ifx\@listofsymbols\@empty
          \else
            \newpage
            \@farsitableofsymbolspages
          \fi
        }{}
    \else
        \typeout{Generate the front matter in final mode.}
        \@makefarsititlepage
        \ifthesis
          \@farsicopyrightpage
        \fi

        \ifthenelse{\boolean{phd} \OR \boolean{thesis}}{
          \cleardoublepage              % begin an odd page
          \@makebesmpage
        }{}

        \ifthenelse{\boolean{phd} \AND \boolean{thesis}}{
          \cleardoublepage              % begin an odd page
          \@farsideclarationpage
        }{}

        \ifthesis
          \cleardoublepage              % begin an odd page
          \@farsiapprovalpage

          \cleardoublepage              % begin an odd page
          \@makededicationpage

          \cleardoublepage              % begin an odd page
          \@makeacknowledgmentpage
        \fi


        \cleardoublepage                % begin an odd page
        \@farsiabstractpage

        \ifthenelse{\boolean{phd} \OR \NOT \boolean{proposal}}{
          % Tables of contents, figures, and tables
          \typeout{Generate the table of contents.}
          \cleardoublepage              % begin an odd page
          \tableofcontents
          \ifnum\@totfig>0
            \typeout{Generate the table of figures.}
            \cleardoublepage            % begin an odd page
            \listoffigures
          \fi
          \ifnum\@tottab>0
            \typeout{Generate the table of tables.}
            \cleardoublepage            % begin an odd page
            \listoftables
          \fi
          \ifx\@listofsymbols\@empty
          \else
            \typeout{Generate the table of symbols.}
            \cleardoublepage            % begin an odd page
            \@farsitableofsymbolspages
          \fi
        }{}
    \fi
}


% End Matter -----------------------------------------------
\newcommand{\@makeendmatter}{
    \ifreview
        \typeout{Generate the end matter in review mode.}
        \cleardoublepage
        \thispagestyle{empty}
        \null\vfill

        \noindent
در حالت مرور (\lr{review}) برای تسهیل مقایسه و تصحیح متن برای داوران صفحات همسان فارسی و انگلیسی پشت‌سرهم در ابتدا می‌آیند و صفحات خالی حذف می شوند. اما در قالب نهایی صفحات فارسی در ابتدا و صفحات انگلیسی در انتها قرار می‌گیرند و صفحات خالی اضافه می‌شوند تا صفحات آغازین در چاپ دورو فرد باشند.
        \vfill
    \else
        \typeout{Generate the end matter in final mode.}
        \cleardoublepage
        \thispagestyle{empty}
        \null\clearpage % Start endmatter from next even page
        \pagenumbering{roman}

        \ifthesis
          \pagestyle{plain}
          \@latinabstractpage

          \ifphd
            \cleardoublepage
            \@latincopyrightpage
          \fi

          \cleardoublepage
          \@latinapprovalpage
        \fi

        \cleardoublepage
        \@makelatintitlepage

        \ifthesis
          \@cutlines % Margin of B5 pages
          \@cover
        \fi
    \fi
}
% ----------------------------------------------------------


%% Copyright © 2009–2025 by Institute for Advanced Studies in Basic Sciences (IASBS)
%%
%% This work is distributed under the LaTeX Project Public License (LPPL), 
%% version 1.3c or later (at your choice). The latest version of this license is 
%% available at: [http://www.latex-project.org/lppl.txt].
%%
%% The maintenance of this work, as defined under the LPPL maintenance status, 
%% is carried out by M. D. Niry (m.d.niry@iasbs.ac.ir). This document class has been
%% specifically designed for use at the IASBS. Modifications and adaptations for 
%% use in other universities are permitted, provided that the original copyright 
%% notice of the document class is retained.

%% The goal of permitting these modifications is to contribute to the enhancement 
%% of academic literature quality across universities in Iran. However, neither 
%% M. D. Niry nor the IASBS assumes any responsibility for the outcomes resulting 
%% from the use of this document class. All liability lies solely with the user.
%%
%%
%%
%% End of file `iasbs-thesis.cls'.

\endinput
