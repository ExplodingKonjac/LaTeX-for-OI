\ProvidesClass{oicontest}[A LaTeX document class for OI contest statement.]
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

\newcommand\SubtitleContent{}
\newcommand\subtitle[1]{\renewcommand\SubtitleContent{#1}}
\pretitle{\vspace*{-20mm}\begin{center}\Huge\bfseries}
\posttitle{\par\mdseries\huge\SubtitleContent\end{center}}
\preauthor{\begin{center}\Large\kaishu}
\postauthor{\end{center}}
\predate{\begin{center}\large\heiti 时间：}
\postdate{\end{center}}

\titleformat{\section}{\Large\sf}{}{0pt}{\centering\label{sec:\thesection}}
\titleformat{\subsection}{\bf}{}{0.5em}{}
\titleformat{\subsubsection}{\bf}{}{0.5em}{}

\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}

\pagestyle{fancy}
\fancyhead[L]{\footnotesize\@title}
\fancyhead[R]{\footnotesize\MakeLowercase{\fancyplain{}{\leftmark}}}
\fancyfoot[C]{\footnotesize 第 \thepage 页 \hspace{2em} 共 { \color{blue} \pageref{LastPage}} 页}

\hypersetup
{
	colorlinks=true,
	linkcolor=blue,
	filecolor=blue,
	urlcolor=blue,
	citecolor=green
}

% Commands
\newcommand\stress[1]{\textbf{\CJKunderdot{#1}}}
\newcommand\filename[1]{\textbf{\textit{#1}}}
\newcommand\ttstring[1]{\texttt{\uline{#1}}}
\newcommand\englishname[1]{\texorpdfstring{\textrm{\MakeLowercase{#1}}}{#1}}
\newcommand\ilcode{\mintinline}

\newcommand\CurProb{[unknown]}
\newcommand\newproblem[2]{\newpage\renewcommand\CurProb{#2}\section{#1（\englishname{#2}）}}
\newcommand\background{\subsection[题目背景]{【题目背景】}}
\newcommand\probdescription{\subsection[题目描述]{【题目描述】}}
\newcommand\inputformat{\subsection[输入格式]{【输入格式】}从文件 \filename{\CurProb.in} 中读入数据。\par}
\newcommand\outputformat{\subsection[输出格式]{【输出格式】}输出到文件 \filename{\CurProb.out} 中。\par}
\newcommand\exampleinput[1]{\subsection[样例 #1 输入]{【样例 #1 输入】}}
\newcommand\exampleoutput[1]{\subsection[样例 #1 输出]{【样例 #1 输出】}}
\newcommand\exampleexplain[1]{\subsection[样例 #1 解释]{【样例 #1 解释】}}
\newcommand\examplefile[1]{\subsection[样例 #1]{【样例 #1】}见选手目录下的 \filename{\CurProb/\CurProb#1.in} 与 \filename{\CurProb/\CurProb#1.ans}。\par}
\newcommand\implement{\subsection[实现细节]{【实现细节】}}
\newcommand\scoring{\subsection[评分细则]{【评分细则】}}
\newcommand\constraints{\subsection[数据范围]{【数据范围】}}
\newcommand\hints{\subsection[提示]{【提示】}}

\newcommand\attention
{
	\begin{enumerate}
		\item 文件名（程序名和输入输出文件名）必须使用英文小写。
		\item C/C++ 中函数 \texttt{main()} 的返回值类型必须是 \texttt{int}，程序正常结束时的返回值必须是 0。
		\item 提交的程序代码文件的放置位置请参考各省的具体要求。
		\item 因违反以上三点而出现的错误或问题，申诉时一律不予受理。
		\item 若无特殊说明，结果的比较方式为全文比较（过滤行末空格及文末回车）。
		\item 选手提交的程序源文件必须不大于 100KB。
		\item 程序可使用的栈空间内存限制与题目的内存限制一致。
		\item 只提供 Linux 格式附加样例文件。
		\item 评测在当前最新公布的 NOI Linux 下进行，各语言的编译器版本以此为准。
	\end{enumerate}
}

\def\HelperNoipTitleChnName<#1,#2,#3,#4,#5,#6,#7,#8>
{
	题目名称 & #1 & #2 & #3 & #4 \\ \hline
	题目类型 & #5 & #6 & #7 & #8 \\ \hline
}
\def\HelperNoipTitleEngName<#1,#2,#3,#4>
{
	目录 & \texttt{#1} & \texttt{#2} & \texttt{#3} & \texttt{#4} \\ \hline
	可执行文件名 & \texttt{#1} & \texttt{#2} & \texttt{#3} & \texttt{#4} \\ \hline
	输入文件名 & \texttt{#1.in} & \texttt{#2.in} & \texttt{#3.in} & \texttt{#4.in} \\ \hline
	输出文件名 & \texttt{#1.out} & \texttt{#2.out} & \texttt{#3.out} & \texttt{#4.out} \\ \hline
}
\def\HelperNoipTitleTimeLimit<#1,#2,#3,#4>
{
	每个测试点时限 & #1 秒 & #2 秒 & #3 秒 & #4 秒 \\ \hline
}
\def\HelperNoipTitleMemoryLimit<#1,#2,#3,#4>
{
	内存限制 & #1 MB & #2 MB & #3 MB & #4 MB \\ \hline
}
\def\HelperNoipTitleTestcaseNumber<#1,#2,#3,#4>
{
	子任务数目 & #1 & #2 & #3 & #4 \\ \hline
}
\def\HelperNoipTitleEqualPoints<#1,#2,#3,#4>
{
	测试点是否等分 & #1 & #2 & #3 & #4 \\ \hline
}
\def\HelperNoipTitleSource<#1,#2,#3,#4>
{
	对于 C++ 语言 & \texttt{#1.cpp} & \texttt{#2.cpp} & \texttt{#3.cpp} & \texttt{#4.cpp} \\ \hline
}
\def\noiptitle[#1][#2][#3][#4][#5][#6][#7]
{
	\begin{titlingpage}
		\maketitle
		\begin{center}
		\begin{tabularx}{\textwidth}{|p{8em}|X|X|X|X|}
			\hline
			\HelperNoipTitleChnName<#1,#2>
			\HelperNoipTitleEngName<#3>
			\HelperNoipTitleTimeLimit<#4>
			\HelperNoipTitleMemoryLimit<#5>
			\HelperNoipTitleTestcaseNumber<#6>
			\HelperNoipTitleEqualPoints<#7>
		\end{tabularx}\par
		\end{center}
		\par 提交源程序文件名
		\begin{center}
		\begin{tabularx}{\textwidth}{|p{8em}|X|X|X|X|}
			\hline
			\HelperNoipTitleSource<#3>
		\end{tabularx}\par
		\end{center}
		\par 编译选项
		\begin{center}
		\begin{tabularx}{\textwidth}{|p{8em}|X<{\centering}|}
			\hline
			对于 C++ 语言 & \texttt{-O2 -std=c++14}\\ \hline
		\end{tabularx}\par
		\end{center}
		\par \stress{注意事项（请仔细阅读）}
		\attention
	\end{titlingpage}
}

\def\HelperNoiTitleChnName<#1,#2,#3,#4,#5,#6>
{
	题目名称 & #1 & #2 & #3 \\ \hline
	题目类型 & #4 & #5 & #6 \\ \hline
}
\def\HelperNoiTitleEngName<#1,#2,#3>
{
	目录 & \texttt{#1} & \texttt{#2} & \texttt{#3} \\ \hline
	可执行文件名 & \texttt{#1} & \texttt{#2} & \texttt{#3} \\ \hline
	输入文件名 & \texttt{#1.in} & \texttt{#2.in} & \texttt{#3.in} \\ \hline
	输出文件名 & \texttt{#1.out} & \texttt{#2.out} & \texttt{#3.out} \\ \hline
}
\def\HelperNoiTitleTimeLimit<#1,#2,#3>
{
	每个测试点时限 & #1 秒 & #2 秒 & #3 秒 \\ \hline
}
\def\HelperNoiTitleMemoryLimit<#1,#2,#3>
{
	内存限制 & #1 MB & #2 MB & #3 MB \\ \hline
}
\def\HelperNoiTitleTestcaseNumber<#1,#2,#3>
{
	子任务数目 & #1 & #2 & #3 \\ \hline
}
\def\HelperNoiTitleEqualPoints<#1,#2,#3>
{
	测试点是否等分 & #1 & #2 & #3 \\ \hline
}
\def\HelperNoiTitleSource<#1,#2,#3>
{
	对于 C++ 语言 & \texttt{#1.cpp} & \texttt{#2.cpp} & \texttt{#3.cpp} \\ \hline
}
\def\noititle[#1][#2][#3][#4][#5][#6][#7]
{
	\begin{titlingpage}
		\maketitle
		\begin{center}
		\begin{tabularx}{\textwidth}{|p{8em}|X|X|X|}
			\hline
			\HelperNoiTitleChnName<#1,#2>
			\HelperNoiTitleEngName<#3>
			\HelperNoiTitleTimeLimit<#4>
			\HelperNoiTitleMemoryLimit<#5>
			\HelperNoiTitleTestcaseNumber<#6>
			\HelperNoiTitleEqualPoints<#7>
		\end{tabularx}\par
		\end{center}
		\par 提交源程序文件名
		\begin{center}
		\begin{tabularx}{\textwidth}{|p{8em}|X|X|X|}
			\hline
			\HelperNoiTitleSource<#3>
		\end{tabularx}\par
		\end{center}
		\par 编译选项
		\begin{center}
		\begin{tabularx}{\textwidth}{|p{8em}|X<{\centering}|}
			\hline
			对于 C++ 语言 & \texttt{-O2 -std=c++14}\\ \hline
		\end{tabularx}\par
		\end{center}
		\par \stress{注意事项（请仔细阅读）}
		\attention
	\end{titlingpage}
}

% Environments
\tcbuselibrary{skins}
\usepackage{etoolbox}
\usemintedstyle{vs}
\newenvironment{code}[1]%
{%
	\VerbatimEnvironment
	\begin{tcolorbox}[colframe=blue,breakable,enhanced jigsaw,colback=white,boxrule=0.5pt,left=2mm]
	\begin{minted}[linenos]{#1}%
}
{
	\end{minted}
	\end{tcolorbox}
}
\newenvironment{example}%
{%
	\VerbatimEnvironment
	\begin{tcolorbox}[colframe=blue,breakable,enhanced jigsaw,colback=white,boxrule=0.5pt,left=2mm]
	\begin{minted}[linenos]{text}%
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

% 向 下 兼 容
\def\constraits{\constraints}
\newenvironment{constraitstab}[1]{\begin{table}{#1}}{\end{table}}
