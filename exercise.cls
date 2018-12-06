\NeedsTeXFormat{LaTeX2e}

\LoadClass{article}
\ProvidesClass{exercisesheet}

\setlength{\parindent}{0pt}

\RequirePackage{geometry}
\geometry{
	a4paper,
	total = {210mm, 297mm},
	left = 22mm,
	right = 22mm,
	top = 20mm,
	bottom = 20mm,
}


\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{amsmath, amsfonts, amssymb, amsthm}
\RequirePackage{multicol}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{tikz}

\RequirePackage{totcount}
\RequirePackage{changepage}
\RequirePackage{etoolbox}
\RequirePackage{environ}

\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{mathtools} 


% Aufgaben-Commands
% \exercise{points}
\newtotcounter{exercisenumber}
\newtotcounter{subexercisenumber}
\newtotcounter{totalpoints}

\newcommand{\Exercise}{Exercise}

\newenvironment{exercise}[1]
{
	\def\points{#1}
	\stepcounter{exercisenumber}
	\setcounter{subexercisenumber}{0}
	\section*{\Exercise~\arabic{exercisenumber}}
}
{	
	\phantom{} \hfill A\arabic{exercisenumber}: \framebox[1.75cm]{\hspace{1cm}/\hfill\points} \\
	\addtocounter{totalpoints}{10*\real{\points}}
	\addPT{\arabic{exercisenumber}}{\points}
}

\newenvironment{subexercise}
{
	\stepcounter{subexercisenumber}
	
	\ifnum\value{subexercisenumber}=1
	\else
		\vspace{1em}
	\fi
	
	\textbf{(\alph{subexercisenumber})}
	\begin{adjustwidth}{2em}{0em}
	\vspace{-\baselineskip}
}
{
	\end{adjustwidth}
}

\newcommand{\addPT}[2]
{
	    \edef\tempA{A#1 &}
	    \edef\tempB{\qquad/#2 &}
	
	\expandafter\gappto\expandafter\PTableA\expandafter{\tempA}
	\expandafter\gappto\expandafter\PTableB\expandafter{\tempB}
}

\newcommand{\pointtable}{
    \begin{table}[h!]
        \centering
        \ifcsname exerciseNumberSaved\endcsname
        \begin{tabular}{|c@{}| *{\exerciseNumberSaved}{c|}}
            \PTableASaved $\Sigma$ \\ \hline
        	\PTableBSaved \qquad / \totalpointsSaved
    	\end{tabular}
        \else
        Compile again\ClassWarning{Compile again}
        \fi
    \end{table}
}
\AtEndDocument{
    \makeatletter
    \immediate\write\@mainaux{\string\gdef\string\PTableASaved{\PTableA}}%
    \immediate\write\@mainaux{\string\gdef\string\PTableBSaved{\PTableB}}%
    \setcounter{totalpoints}{\totvalue{totalpoints}/10}
    \immediate\write\@mainaux{\string\gdef\string\totalpointsSaved{\arabic{totalpoints}}}%
    
    \setcounter{exercisenumber}{\totvalue{exercisenumber}*2/2}
    \immediate\write\@mainaux{\string\gdef\string\exerciseNumberSaved{\arabic{exercisenumber}}}%
   
    \makeatother
}
