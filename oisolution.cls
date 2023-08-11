\ProvidesClass{oisolution}[A LaTeX document class for OI contest solutions.]
\NeedsTeXFormat{LaTeX2e}

% Requires
\LoadClass[12pt]{ctexart}
\RequirePackage{amsmath,amsfonts}
\RequirePackage{geometry}
\RequirePackage{titling}
\RequirePackage{titlesec}
\RequirePackage{fontspec}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{makecell}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage{tcolorbox}
\RequirePackage{fancyhdr,fancyvrb}
\RequirePackage{lastpage}
\RequirePackage{minted,lineno}
\RequirePackage{xeCJK,xeCJKfntef}

% Settings
\geometry{bottom=20mm,top=25mm,left=27mm,right=27mm}
\setmonofont{Consolas}
\setCJKmainfont[BoldFont={黑体},ItalicFont={楷体}]{宋体}
\tcbuselibrary{most}
\renewcommand{\theFancyVerbLine}{\ttfamily\textcolor{gray}{\footnotesize\arabic{FancyVerbLine}}}

\pretitle{\vspace*{-20mm}\begin{center}\Huge\bfseries}
\posttitle{\par\Large\kaishu\end{center}}
\predate{\begin{center}\large\heiti}
\postdate{\end{center}}

\titleformat{\section}{\Large\bf}{\textbf{\Alph{section}}}{10pt}{\centering\label{sec:\thesection}}
\titleformat{\subsection}{\large\bf}{\arabic{subsection}.}{0.5em}{}
\titleformat{\subsubsection}{\bf}{\arabic{subsection}.\arabic{subsubsection}.}{0.5em}{}

\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}

\pagestyle{fancy}
\fancyhead[L]{\footnotesize\@title}
\fancyhead[R]{\footnotesize\MakeLowercase{\fancyplain{}{\leftmark}}}
\fancyfoot[C]{\footnotesize 第 \thepage 页 \hspace{2em} 共 { \color{blue} \pageref{LastPage}} 页}

% Commands
\newcommand\stress[1]{\textbf{\CJKunderdot{#1}}}
\newcommand\filename[1]{\textbf{\textit{#1}}}
\newcommand\ttstring[1]{\texttt{\uline{#1}}}
\newcommand\englishname[1]{\texorpdfstring{\textrm{\MakeLowercase{#1}}}{#1}}
\def\ilcode{\mintinline}

\newcommand\solutiontitle{\begin{titlingpage}\maketitle\tableofcontents\end{titlingpage}}
\newcommand\newproblem[2]{\newpage\section[#2]{#1（\englishname{#2}）}}

% environments
\usepackage{etoolbox}
\usemintedstyle{vs}
\newenvironment{code}[1]%
{%
	\VerbatimEnvironment
	\begin{tcolorbox}[colframe=blue,breakable=true,colback=white,boxrule=0.5pt,left=2mm]
	\begin{minted}[linenos]{#1}%
}
{
	\end{minted}
	\end{tcolorbox}
}
\renewenvironment{table}[1]
{
	\def\tabmid{\Xhline{3\arrayrulewidth}}
	\begin{center}\begin{tabular}{#1}
		\Xhline{5\arrayrulewidth}
}
{
		\Xhline{5\arrayrulewidth}
	\end{tabular}\end{center}
	\edef\tabmid
}
