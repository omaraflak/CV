% create class "resume"
\ProvidesClass{resume}[Resume]

% font size and paper type
\LoadClass[11pt, a4paper]{article}

% remove paragraph indentation
\usepackage[parfill]{parskip}

\usepackage{xcolor}

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
% CUSTOM COLORS
%----------------------------------------------------------------------------------------

\definecolor{visible}{rgb}{0.961, 0, 0.341}
\definecolor{hint}{rgb}{0.129, 0.129, 0.129}

%----------------------------------------------------------------------------------------
% COMMAND FOR PRINTING LINKS
%----------------------------------------------------------------------------------------

\newcommand{\link}[2]{\textbf{\textcolor{brown}{\href{#1}{#2}}}}
\newcommand{\importantlink}[2]{\textbf{\textcolor{visible}{\href{#1}{#2}}}}

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
%	EXPERIENCE FORMATTING
%----------------------------------------------------------------------------------------

% 6 input argument - company name, location, job title, from, to, description
\newenvironment{job}[6]{
  {\bf #1}, {#2} \textemdash\ \textit{#3} \\
  {\footnotesize \textcolor{hint}{{#4} \textendash\ {#5}}} \\
  \begin{minipage}{6.5in}
    \smallskip
    {#6}
  \end{minipage}
  \vspace{0.5em}
}

%----------------------------------------------------------------------------------------
% EDUCATION FORMATTING
%----------------------------------------------------------------------------------------

% 5 input argument - school name, school type, from, to, description
\newenvironment{school}[5]{
  {\bf #1} \textendash\ \textit{#2} \\
  {\footnotesize \textcolor{hint}{{#3} \textendash\ {#4}}} \\
  \begin{minipage}{6.5in}
    \smallskip
    {#5}
  \end{minipage}
  \vspace{0.5em}
}

%----------------------------------------------------------------------------------------
% AWARD FORMATTING
%----------------------------------------------------------------------------------------

% 6 input argument - title, location, city, date, description
\newenvironment{award}[5]{
  {\bf #1} \textemdash\ \textit{#2, #3} \\
  {\footnotesize \textcolor{hint}{{#4}}} \\
  \begin{minipage}{6.5in}
    \smallskip
    {#5}
  \end{minipage}
  \vspace{0.5em}
}

%----------------------------------------------------------------------------------------
% PROJECTS FORMATTING
%----------------------------------------------------------------------------------------

% 3 input argument - title, date, description
\newenvironment{project}[3]{
  {\bf #1} \textendash\ {\footnotesize \textcolor{hint}{{#2}}} \\
  \begin{minipage}{6.5in}
    \smallskip
    {#3}
  \end{minipage}
  \vspace{0.5em}
}

%----------------------------------------------------------------------------------------
% FONT SIZE & SKIP SIZE
%----------------------------------------------------------------------------------------

% Size of the name at the top of the document
\def \namesize {\huge}
% The space between the two address (or phone/email) lines
\def \addressskip {\smallskip}
% The space above the horizontal line for each section
\def \sectionlineskip {\medskip}
% The space after your name at the top
\def \nameskip {\bigskip}
% The space after the heading section
\def \sectionskip {\bigskip}
