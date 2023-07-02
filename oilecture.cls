\ProvidesClass{oilecture}[A LaTeX beamer class for OI lectures]
\NeedsTeXFormat{LaTeX2e}

% Requires
\LoadClass[9pt]{ctexbeamer}
\RequirePackage{amsmath,amsfonts}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{hyperref}

% Settings
\mode<presentation>
{
	\usetheme{Ilmenau}
	\usecolortheme[RGB={47,126,238}]{structure}
	\usefonttheme[]{serif}
	\parskip=0.5em
}
\hypersetup
{
	colorlinks=true,
	linkcolor=blue,
	filecolor=cyan,
	urlcolor=blue,
	citecolor=green
}

% Commands
\def\vsp{\vspace{0.5em}}
\def\hsp{\hspace{0.5em}}
\newcommand\lecturetitle[3]{\title{\textsf{#1}}\author{\texttt{#2}}\date{#3}\begin{frame}\titlepage\end{frame}}
\newcommand\lectureend[1]{\begin{frame}\begin{center}\Huge{#1}\end{center}\end{frame}}
\newcommand\CurProb{[unknown]}
\newcommand\newproblem[1]{\renewcommand\CurProb{#1}}

% Environments
\newenvironment{pstatement}
{
	\begin{frame}
		\frametitle{\textsf{\CurProb}}
		\framesubtitle{\textbf{Statement}}
}
{
	\end{frame}
}
\newenvironment{phints}
{
	\begin{frame}
		\frametitle{\textsf{\CurProb}}
		\framesubtitle{\textbf{Hints}}
}
{
	\end{frame}
}
\newenvironment{psolution}
{
	\begin{frame}
		\frametitle{\textsf{\CurProb}}
		\framesubtitle{\textbf{Solution}}
}
{
	\end{frame}
}
\newenvironment{items}
{
	\begin{itemize}
		\setlength{\itemsep}{0.5em}
}
{
	\end{itemize}
}
\newenvironment{enums}
{
	\begin{enumerate}
		\setlength{\itemsep}{0.5em}
}
{
	\end{enumerate}
}
