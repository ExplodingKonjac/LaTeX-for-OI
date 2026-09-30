% oicontest-v2.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{oicontest-v2}[A LaTeX document class for OI contest statement.]

% inherits from ctexart
\LoadClass[a4paper,12pt]{ctexart}

% requirements
\RequirePackage{xeCJK,xeCJKfntef}
\RequirePackage{etoolbox}
\RequirePackage{geometry}
\RequirePackage{titling}
\RequirePackage{titlesec}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsfonts}
\RequirePackage{tabularx}
\RequirePackage{makecell}
\RequirePackage{multirow}
\RequirePackage{multicolumn}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{lineno}
\RequirePackage{minted}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage{tcolorbox}
\RequirePackage{fancyhdr}
\RequirePackage{fancyvrb}
\RequirePackage{lastpage}
\RequirePackage{verbatim}
\RequirePackage{enumitem}

% geometric settings
\geometry{a4paper,left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm}
\renewcommand{\baselinestretch}{1.3}

% pagestyle settings
\pagestyle{fancy}
\setlength{\headheight}{20pt}
\renewcommand{\headrulewidth}{0.2pt}
\renewcommand{\footrulewidth}{0pt}
\fancyhead[L]{%
	\footnotesize\@title%
	\expandafter\ifstrempty\expandafter{\@subtitle}{}{\hspace{1em}\@subtitle}
}
\fancyhead[R]{%
	\footnotesize\nouppercase\rightmark
}
\fancyfoot[C]{%
	\footnotesize 第 \thepage 页 ~~~~ 共 { \color{blue} \pageref{LastPage}} 页
}

% font settings
\setmonofont{Consolas}
\setCJKmonofont{SimSun}

% list settings
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=0pt,leftmargin=3em}
\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=0pt,leftmargin=3em}
\setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=0pt,leftmargin=3em}

% section settings
\renewcommand{\sectionmark}[1]{\markright{#1}}
\renewcommand{\subsectionmark}[1]{}
\renewcommand{\subsubsectionmark}[1]{}

\newcommand{\oic@addbracket}[1]{【#1】}
\titleformat{\section}{\Large\heiti}{}{0pt}{%
	\centering\label{sec:\thesection}
}
\titleformat{\subsection}{\bf}{}{1em}{%
	\heiti\fontsize{13bp}{13bp*\real{\baselinestretch}}\oic@addbracket
}
\titleformat{\subsubsection}{\bf}{}{1em}{}

% hyperref settings
\hypersetup{
	setpagesize=false,
	colorlinks=true,
	linkcolor=blue,
	breaklinks=true,
	pdfborder={0 0 0}
}

% code blocks settings
\renewcommand{\theFancyVerbLine}{\ttfamily\footnotesize\color{gray}\arabic{FancyVerbLine}}
\setminted{
	style=xcode,
	frame=single,
	rulecolor=\color{blue},
	linenos=true,
	numbersep=6.5pt,
	tabsize=4,
	breaklines,
	breakanywhere,
	xleftmargin=8.5pt,
	xrightmargin=-3.5pt
}

% text formats
\renewcommand{\textbf}[1]{{\bfseries\CJKunderdot{#1}}}
\newcommand{\oicfilename}[1]{\textbf{\textit{#1}}}
\newcommand{\oicstring}[1]{\texttt{\uline{#1}}}

% problemset operations
\newcounter{oic@probnum}
\newcommand{\oic@probindexlist}{}

% \addproblem{中文名}{英文名}{类型}{时间}{空间}{测试点数}{是否等分}
\newcommand{\addproblem}[7]{\begingroup%
	\stepcounter{oic@probnum}
	\listxadd{\oic@probindexlist}{\alph{oic@probnum}}
	\def\@deffield##1##2{
		\expandafter\gdef\csname oic@prob@\alph{oic@probnum}@##1\endcsname{##2}%
	}
	\@deffield{name}{#1}
	\@deffield{eng}{#2}
	\@deffield{type}{#3}
	\@deffield{dir}{#2}
	\@deffield{exec}{#2}
	\@deffield{input}{#2.in}
	\@deffield{output}{#2.out}
	\@deffield{tl}{#4 秒}
	\@deffield{ml}{#5 MiB}
	\@deffield{testnum}{#6}
	\@deffield{scoreequal}{#7}
	\@deffield{cppsrc}{#2.cpp}
\endgroup}

% title page definition
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\@subtitle}{}
\renewcommand{\@title}{}
\renewcommand{\@author}{}
\renewcommand{\@date}{}

\newcommand{\oicjudgermachine}{}
\newcommand{\oicjudgerenvironment}{}
\newcommand{\oicattention}{}

\listadd{\oicattention}{文件名（程序名和输入输出文件名）必须使用英文小写。赛后正式测试时将以选手留在题目目录下的源代码为准。}
\listadd{\oicattention}{\texttt{main} 函数的返回值类型必须是 \texttt{int}，程序正常结束时返回值必须是 0。}
\listadd{\oicattention}{若无特殊说明，结果的比较方式为全文比较（过滤行末空格及文末回车）。}
\listadd{\oicattention}{选手提交的程序源文件必须不大于 100KB。}
\listadd{\oicattention}{程序可使用的栈空间内存限制与题目的内存限制一致。}
\listadd{\oicattention}{禁止在源代码中改变编译器参数（如使用 \texttt{\#pragma} 命令），禁止使用系统结构相关指令（如内联汇编）和其他可能造成不公平的方法。}

\newcommand{\oic@getfield}[2]{%
	\csname oic@prob@#1@#2\endcsname
}
\newcommand{\oictitlepage}{%
	\clearpage
	\thispagestyle{empty}
	\maketitle
}
\renewcommand{\maketitle}{\begingroup%
	\expandafter\ifstrempty\expandafter{\@title}{}{%
		\begin{center}
			\centering\bfseries\huge\@title
		\end{center}
	}
	\expandafter\ifstrempty\expandafter{\@subtitle}{}{%
		\begin{center}
			\kaishu\huge\@subtitle
		\end{center}
	}
	\expandafter\ifstrempty\expandafter{\@author}{}{%
		\begin{center}
			\kaishu\large\@author
		\end{center}
	}
	\expandafter\ifstrempty\expandafter{\@date}{}{%
		\begin{center}
			\heiti\large 时间：\@date
		\end{center}
	}

	\ifnum \value{oic@probnum}=3
		\edef\hdrwidth{0.22\textwidth}
	\else \ifnum \value{oic@probnum}=4
		\edef\hdrwidth{0.20\textwidth}
	\else
		\edef\hdrwidth{\dimexpr \textwidth/(\theoic@probnum+1) \relax}
	\fi \fi

	\def\@printcol##1##2##3{& ##1\oic@getfield{##3}{##2}}
	\def\@printrow##1##2{\forlistloop{\@printcol{##1}{##2}}{\oic@probindexlist}}

	\begin{center}
	\begin{tabularx}{\textwidth}{|p{\hdrwidth}|*{\theoic@probnum}{X|}}
		\hline
		题目名称 \@printrow{}{name} \\
		\hline
		题目类型 \@printrow{}{type} \\
		\hline
		目录 \@printrow{\ttfamily}{dir} \\
		\hline
		可执行文件名 \@printrow{\ttfamily}{exec} \\
		\hline
		输入文件名 \@printrow{\ttfamily}{input} \\
		\hline
		输出文件名 \@printrow{\ttfamily}{output} \\
		\hline
		每个测试点时限 \@printrow{}{tl} \\
		\hline
		空间限制 \@printrow{}{ml} \\
		\hline
		测试点数目 \@printrow{}{testnum} \\
		\hline
		测试点是否等分 \@printrow{}{scoreequal} \\
		\hline
	\end{tabularx}
	\end{center}
	
	\par 提交源程序文件名
	\begin{center}
	\begin{tabularx}{\textwidth}{|p{\hdrwidth}|*{\arabic{oic@probnum}}{X|}}
		\hline
		对于 C++ 语言 \@printrow{\ttfamily}{cppsrc} \\
		\hline
	\end{tabularx}
	\end{center}

	编译选项
	\begin{center}
	\begin{tabularx}{\textwidth}{|p{\hdrwidth}|X<{\centering}|}
		\hline
		对于 C++ 语言 & \texttt{-O2 -std=c++14} \\
		\hline
	\end{tabularx}
	\end{center}

	\textbf{注意事项（请仔细阅读）}
	\begin{enumerate}
		\expandafter\ifstrempty\expandafter{\oicjudgermachine}{}{%
			\item 测试机器：\oicjudgermachine。
		}
		\expandafter\ifstrempty\expandafter{\oicjudgerenvironment}{}{%
			\item 测试环境：\oicjudgerenvironment。
		}
		\forlistloop{\item }{\oicattention}
	\end{enumerate}
\endgroup}

% problem page definition
\newcounter{oic@curprob}
\newcommand{\oicnextproblem}{\begingroup%
	\clearpage
	\stepcounter{oic@curprob}%
	\edef\name{\oic@getfield{\alph{oic@curprob}}{name}}%
	\edef\eng{\oic@getfield{\alph{oic@curprob}}{eng}}%
	\section{\name（\eng）}%
\endgroup}

% subsections definition
\newcommand{\oicbackground}{%
	\subsection{题目背景}
}
\newcommand{\oicstatement}{%
	\subsection{题目描述}
}
\newcommand{\oicinputformat}{%
	\subsection{输入格式}
	从文件 \oicfilename{\oic@getfield{\alph{oic@curprob}}{input}} 中读入数据。\par
}
\newcommand{\oicoutputformat}{%
	\subsection{输出格式}
	输出到文件 \oicfilename{\oic@getfield{\alph{oic@curprob}}{output}} 中。\par
}
\newcommand{\oicsampleinput}[1]{%
	\subsection{样例 #1 输入}
}
\newcommand{\oicsampleoutput}[1]{%
	\subsection{样例 #1 输出}
}
\newcommand{\oicsampleexplain}[1]{%
	\subsection{样例 #1 解释}
}
\newcommand{\oicsamplefile}[1]{\begingroup%
	\subsection{样例 #1}
	\edef\base{\oic@getfield{\alph{oic@curprob}}{eng}}%
	见选手目录下的 \oicfilename{\base/\base#1.in} 与 \oicfilename{\base/\base#1.ans}。
\endgroup}
\newcommand{\oicimplementation}{%
	\subsection{实现细节}
}
\newcommand{\oictesting}{%
	\subsection{测试程序方式}
}
\newcommand{\oicscoring}{%
	\subsection{评分方式}
}
\newcommand{\oicconstraints}{%
	\subsection{数据范围}
}
\newcommand{\oichints}{%
	\subsection{提示}
}

% environment definition
\newminted[oicsample]{text}{}
\newmintedfile[oicsamplefrom]{text}{}

\newenvironment{oictable}[1]{%
	\begingroup
	\def\tabmid{\Xhline{3\arrayrulewidth}}
	\begin{center}
		\begin{tabular}{#1}
			\Xhline{5\arrayrulewidth}
}{%
			\Xhline{5\arrayrulewidth}
		\end{tabular}
	\end{center}
	\endgroup
}
\newenvironment{oictablex}[2]{%
	\begingroup
	\def\tabmid{\Xhline{3\arrayrulewidth}}
	\center
		\tabularx{#1}{#2}
			\Xhline{5\arrayrulewidth}
}{%
			\Xhline{5\arrayrulewidth}
		\endtabularx
	\endcenter
	\endgroup
}
