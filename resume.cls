% create class "resume"
\ProvidesClass{resume}[Resume]

% font size and paper type
\LoadClass[11pt,letterpaper]{article}

% remove paragraph indentation
\usepackage[parfill]{parskip}

% required for boldface (\bf and \bfseries) tabular columns
\usepackage{array}

% suppress page numbers
\pagestyle{empty}

%----------------------------------------------------------------------------------------
%	COMMANDS FOR PRINTING NAME
%----------------------------------------------------------------------------------------

% sets \@name to empty by default
\def \@name {}

% defines the \name command to set name
\def \name #1{
  \def \@name {#1}
}

% \printname is used to print the name as a page header
\def \printname {
  \begingroup
    \hfil{\MakeUppercase{\namesize \@name}}\hfil
    \nameskip\break
  \endgroup
}

%----------------------------------------------------------------------------------------
% COMMANDS FOR PRINTING ADDRESSES
%----------------------------------------------------------------------------------------

% one, two or three address lines can be specified 
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

% set default address separator to a diamond
\def \addressSep {$\diamond$}

% \address command can be used to set the first, second, and third address (last 2 optional)
\def \address #1{
  \@ifundefined{@addressone}{
    \def \@addressone {#1}
  }{
    \@ifundefined{@addresstwo}{
      \def \@addresstwo {#1}
    }{
      \@ifundefined{@addressthree}{
        \def \@addressthree {#1}
      }
    }
  }
}

% \printaddress is used to style an address line (given as input)
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    \centerline{#1}
  \endgroup
  \par
  \addressskip
}

%----------------------------------------------------------------------------------------
% COMMAND FOR PRINTING LINKS
%----------------------------------------------------------------------------------------

\newcommand{\link}[2]{
  \textcolor{brown}{\href{#1}{#2}}
}

%----------------------------------------------------------------------------------------
%	PRINT THE HEADING LINES
%----------------------------------------------------------------------------------------

% save old \document command
\let\ori@document=\document
% ovewrite document
\renewcommand{\document}{
  % begin document using old \document command
  \ori@document
  % print the name specified with \name
  \printname
  % print addresses when defined
  \@ifundefined{@addressone}{}{
    \printaddress{\@addressone}
    \@ifundefined{@addresstwo}{}{
      \printaddress{\@addresstwo}
      \@ifundefined{@addressthree}{}{
        \printaddress{\@addressthree}
      }
    }
  }
}

%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

% defines the rSection environment for the large sections within the CV
% 1 input argument - section name
\newenvironment{rSection}[1]{
  % some space
  \sectionskip
  % section title
  \MakeUppercase{\bf #1}
  % some space
  \sectionlineskip
  % horizontal line
  \hrule
  % list for each individual item in the section
  \begin{list}{}{
    % margin within the section
    \setlength{\leftmargin}{1em}
  }
  \item[]
}{
  \end{list}
}

%----------------------------------------------------------------------------------------
%	WORK & AWARD EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

% defines the event environment : items of rSection
% 4 input argument - title, place, date, description
\newenvironment{event}[4]{
	{\bf #1} \hfill {#2}
	\begin{minipage}{5.5in}
		\smallskip
		{#4}
	\end{minipage}
	\hfill {#3}
	\vspace{0.5em}
}

% The below commands define the whitespace after certain things in the document - they can be \smallskip, \medskip or \bigskip
\def\namesize{\huge} % Size of the name at the top of the document
\def\addressskip{\smallskip} % The space between the two address (or phone/email) lines
\def\sectionlineskip{\medskip} % The space above the horizontal line for each section 
\def\nameskip{\bigskip} % The space after your name at the top
\def\sectionskip{\bigskip} % The space after the heading section