% chmullig HW class file
% based heavily on
% HMC Math dept HW class file
% v0.04 by Eric J. Malm, 10 Mar 2005
%%% IDENTIFICATION --------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1995/01/01]
\ProvidesClass{chmullighw}
    [2012/10/05 v0.05 chmullig HW class file]

%%% INITIAL CODE ----------------------------------------------------------

% test whether the document is being compiled with PDFTeX
\RequirePackage{ifpdf}

%% Header Options: header*, no header
\newif\ifhmcpset@header

% no header block in upper right hand corner
\DeclareOption{noheader}{%
    \hmcpset@headerfalse%
}

% do print header block
\DeclareOption{header}{%
    \hmcpset@headertrue%
}

%% Running Header Options: runheader*, no runheader
\newif\ifhmcpset@runheader

% no running header at the top of every page
\DeclareOption{norunheader}{%
    \hmcpset@runheaderfalse%
}

% do print header block
\DeclareOption{runheader}{%
    \hmcpset@runheadertrue%
}

%% Problem Boxing: boxed*, unboxed
\newif\ifhmcpset@boxed

% box problem statements
\DeclareOption{boxed}{%
    \hmcpset@boxedtrue%
}
   
% don't box problem statements
\DeclareOption{unboxed}{%
    \hmcpset@boxedfalse%
}
   
% pass remaining options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%%% EXECUTION OF OPTIONS --------------------------------------------------
%% default to:
% including header, 
% boxing problem statements
\ExecuteOptions{header,runheader,boxed}

\ProcessOptions

%%% PACKAGE LOADING -------------------------------------------------------
%% based on std article class
\LoadClass{article}



%% AMSLaTeX math environments and symbols
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{listings}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{color}

\definecolor{lightgray}{rgb}{0.25, 0.25, 0.25}
\definecolor{gray}{rgb}{0.5, 0.5, 0.5}
\definecolor{darkgray}{rgb}{0.75, 0.75, 0.75}
\lstset {
  basicstyle=\footnotesize,
  numbers=left,
  numberstyle=\tiny\color{gray},
  frame=single,
  tabsize=4,
  breaklines=true,
  breakatwhitespace=true,
  title=\lstname
}
%% boxed minipage for boxed problem environment
\RequirePackage{boxedminipage}

%%% MAIN CODE -------------------------------------------------------------
%% Tell dvips/pdflatex correct page size
\ifpdf
  \AtBeginDocument{%
    \setlength{\pdfpageheight}{\paperheight}%
    \setlength{\pdfpagewidth}{\paperwidth}%
  }
\else
  \AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}%
\fi


%% Problem set environments
% boxed problem environment
\newenvironment{problem}[1][]{%
  \ifhmcpset@boxed\def\hmcpset@probenv{boxed}\else\def\hmcpset@probenv{}\fi%
  \bigskip% put space before problem statement box %
  \noindent\begin{\hmcpset@probenv minipage}{\columnwidth}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty\else%
    \hmcpset@probformat{#1}\hspace{0.5em}%
  \fi%
}{%
  \end{\hmcpset@probenv minipage}%
}
% display optional argument to problem in bold
\let\hmcpset@probformat\textbf

% solution environment with endmark and optional argument
\newenvironment{solution}[1][]{%
  \begin{trivlist}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty%
    \item[]%
  \else%
    \item[\hskip\labelsep\relax #1]%
  \fi%
}{%
  \mbox{}\penalty10000\hfill\hmcpset@endmark%
  \end{trivlist}%
}


% default endmark is small black square
\def\hmcpset@endmark{\ensuremath{\scriptscriptstyle\blacksquare}}

%% Problem set list, for top of document
\newcommand{\problemlist}[1]{\begin{center}\large\sffamily{#1}\end{center}}

%% commands for upper-right id header block
\newcommand{\headerblock}{
  \thispagestyle{plain}
  \mbox{}\protect
}

% put id header block at start of document
\ifhmcpset@header\AtBeginDocument{\headerblock}\fi


% internal state for headerblock
\def\hmcpset@uni{}
\def\hmcpset@class{}
\def\hmcpset@professor{}
\def\hmcpset@assignment{}
\def\hmcpset@duedate{}
\def\hmcpset@extraline{}
\def\titleheader{}

% commands to set header block info
\newcommand{\name}[1]{\def\hmcpset@name{#1}
  \author{\hmcpset@name}}
\newcommand{\uni}[1]{\def\hmcpset@uni{#1}}
\newcommand{\class}[1]{\def\hmcpset@class{#1}}
\newcommand{\professor}[1]{\def\hmcpset@professor{#1}}
\newcommand{\assignment}[1]{\def\hmcpset@assignment{#1}
  \title{\hmcpset@assignment}}
\newcommand{\duedate}[1]{\def\hmcpset@duedate{#1}
  \date{\hmcpset@duedate}}
\newcommand{\extraline}[1]{\def\hmcpset@extraline{#1}}





% set the header
\pagestyle{fancyplain}
\fancyhf{}
\cfoot{\thepage}

\rhead{\fancyplain{\ifhmcpset@header
    \hmcpset@name \; $\langle$\hmcpset@uni$\rangle$ \\
    \hmcpset@class, \hmcpset@professor \\
    \hmcpset@assignment \\
    \hmcpset@duedate%
    \ifx\hmcpset@extraline\empty\else\protect\\\hmcpset@extraline\fi%end "plain" header
  \fi}{\ifhmcpset@runheader \hmcpset@name \; $\langle$\hmcpset@uni$\rangle$ \fi}}

\ifhmcpset@runheader
  \lhead{\fancyplain{}{\hmcpset@class: \hmcpset@assignment}} 
\else
  \renewcommand{\headrulewidth}{0pt} %"plain" header style
\fi