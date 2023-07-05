using YAML
using Dates
using LaTeXStrings

bibliography = YAML.load_file("data/bibliography.yaml")
talks =  YAML.load_file("data/talks.yaml")
talks_expanded = collect(talks)
talk_names = first.(talks_expanded)
talk_dates = map(x-> Date("$(x["year"])-$(x["month"])", "y-U"), last.(talks_expanded))
_order = sortperm(talk_dates; rev=true)
sorted_talks = talk_names[_order]




texname = "ignatiadis_cv4.tex"



#for key in sorted_talks
#    html_string = """
#   $(html_string)
#    $(talkprint(key))
#    """
#end
latex = L"""
\documentclass[margin,line]{res}

\usepackage{changepage}
\usepackage{xcolor}

\usepackage[greek, english]{babel}
\usepackage[utf8x]{inputenc}
\usepackage[hidelinks]{hyperref}
\usepackage{tikz}
%\usepackage{titlesec}
\usepackage{fontspec}
\usepackage[Latin,Greek]{ucharclasses}

\newfontfamily\substitutefont{CMU Serif}
\setTransitionsForGreek{\begingroup\substitutefont}{\endgroup}


\newcommand{\g}{\textgreek}
\newcommand{\ver}{\vspace*{-2.7mm}}
\renewcommand{\baselinestretch}{1.0}
%\renewcommand{\baselineskip}{1.5in}

\oddsidemargin -0.7in
\evensidemargin -.7in
\textwidth=6.2in
\textheight=690pt
\voffset=-0.4in
\hoffset=1.4in
\itemsep=0in
\parsep=0in
% if using pdflatex:
\setlength{\pdfpagewidth}{\paperwidth}
\setlength{\pdfpageheight}{\paperheight}

\newenvironment{list1}{
  \begin{list}{\ding{113}}{%
      \setlength{\itemsep}{0in}
      \setlength{\parsep}{0in} \setlength{\parskip}{0in}
      \setlength{\topsep}{0in} \setlength{\partopsep}{0in}
      \setlength{\leftmargin}{0.17in}}}{\end{list}}
\newenvironment{list2}{
  \begin{list}{$\bullet$}{%
      \setlength{\itemsep}{0in}
      \setlength{\parsep}{0in} \setlength{\parskip}{0in}
      \setlength{\topsep}{0in} \setlength{\partopsep}{0in}
      \setlength{\leftmargin}{0.2in}}}{\end{list}}
\newenvironment{list3}{
  \begin{list}{}{%
      \setlength{\itemsep}{0in}
      \setlength{\parsep}{0in} \setlength{\parskip}{0in}
      \setlength{\topsep}{0in} \setlength{\partopsep}{0in}
      \setlength{\leftmargin}{0.2in}}}{\end{list}}
\definecolor{urlblue}{HTML}{0000EE}

\usepackage{orcidlink}

\begin{document}

\name{ Nikolaos Ignatiadis \orcidlink{0000-0001-7767-2583} --- CV  \hspace{17em} {\normalfont \textit{Last update: \today}}\vspace*{.1in}}

\begin{resume}
\section{\sc Contact Details}
\vspace{.05in}
\begin{tabular}{@{}p{3.2in}p{4in}}
University of Chicago            & {Telephone:}  +1 (650) 656-0855 \\
Department of Statistics \& Data Science Institute  & {E-mail:}    ignat@uchicago.edu \\
5735 S Ellis Ave &  {Website:} \href{https://nignatiadis.github.io/}{https://nignatiadis.github.io/}\\
Chicago, IL 10027, 60637  & {Google Scholar:} \href{https://scholar.google.com/citations?user=KH3jpkoAAAAJ}{user=KH3jpkoAAAAJ} \\
\end{tabular}



\section{\sc Research Interests}
I am interested in the development of interpretable statistical methods, accompanied by robust software implementations, for the analysis of datasets generated from modern, high-throughput technologies. From a statistical perspective, this interest encompasses Empirical Bayes analysis, causal inference, multiple testing and statistics in the presence of contextual side-information.

\section{\sc Academic Employment}
{\bf Department of Statistics and Data Science Institute, University of Chicago} \hfill Chicago, USA\\
\vspace*{-.14in}
\begin{list2}
\item Assistant Professor \hfill Beginning 07/2023
\end{list2}

{\bf Department of Statistics, Columbia University} \hfill New York, USA\\
\vspace*{-.14in}
\begin{list2}
\item Postdoctoral Research Scientist \hfill 09/2022 - 06/2023
\end{list2}



\section{\sc Education}
{\bf Stanford University} \hfill Stanford, California, USA\\
%{\em Department of Statistics}
\vspace*{-.14in}
\begin{list2}
\item
\textbf{Ph.D., Statistics}  (GPA 4.24) \hfill  09/2016 -- 06/2022\\
Thesis advisor: Stefan Wager\\
Thesis title: Nonparametric perspectives on empirical Bayes.
\item \textbf{M.S., Statistics}
\end{list2}

\vspace*{-2.5mm}
{\bf {Heidelberg University}} \hfill  {Heidelberg, Germany}\\
\vspace*{-.14in}
\begin{list2}
\item \textbf{M.Sc.,  Scientific Computing}, Grade 1.0 \hfill 2015 - 2016\\
Thesis advisors: Wolfgang Huber and Enno Mammen
\item \textbf{B.Sc., Mathematics}, Grade 1.0 with \emph{distinction} \hfill 2011 - 2015\\
Thesis advisors: Wolfgang Huber and Rainer Dahlhaus
\item \textbf{B.Sc., Molecular Biotechnology}, Grade 1.0 \hfill 2010 - 2013
\end{list2}


\section{\sc Awards and Fellowships }
\textbf{Jerome H. Friedman Applied Statistics Dissertation Award} \hfill 2022\\
For developing methodology that uses side information for increased power in multiple testing problems and for developing approaches to inference in empirical Bayes problems.\\
\textbf{Ric Weiland Graduate Fellowship  in the Humanities \& Sciences } \hfill 2020 - 2021\\
This fellowship is awarded to exceptional rising fourth year doctoral candidates in the humanities, social sciences, mathematics, and
statistics upon departmental or programmatic nomination.\\
\textbf{Departmental Teaching Assistant Award}, Statistics Department, Stanford  \hfill  2018\\
\textbf{iGEM Grand Prize Winner \& Best Foundational Advance} \hfill  2013 \\
The International Genetically Engineered Machine competition with Team Heidelberg at MIT.\\
\textbf{Deutschlandstipendium}, Heidelberg University, Germany \hfill 2011 - 2013\\
This scholarship is awarded to talented and high-achieving students at public and state recognised institutions of higher education in Germany and is supported by the German Federal Government.\\
\textbf{Bronze medal at the International Biology Olympiad}, Changwon, South Korea \hfill 2010
"""

item_no = 0


latex = L"""
%$(latex)
\section{\sc Journal Publications}
\begin{list1}
"""

journal_keys = ["IgnatiadisSahaSunMuralidharan2021",
                "IgnatiadisWager2022Rejoinder",
                "IgnatiadisWager2022",
                "IgnatiadisHuber2021",
                "Karacosta2021",
                "IgnatiadisKlausZauggHuber2016",
                "Beer2014"]

#\item[5.]  Ignatiadis, N., Klaus, B., Zaugg, J. B. and Huber, W. (2016). \textbf{Data-driven hypothesis weighting increases detection power in genome-scale multiple testing.} Nature Methods, 13(7), 577-580.



for key in journal_keys
    global item_no += 1
    paper = bibliography[key]
    authors = join([LaTeXString(name) for name ∈ paper["author"] ], ", ")

    global latex = L"""
    %$(latex)
    \item[%$(item_no).]
    %$(authors) (%$(paper["year"])).
    \textbf{%$(paper["title"]).}
    %$(paper["journal"]).
    """
end

latex = L"""
%$(latex)
\end{list1}

\section{\sc Conference proceedings}
\begin{list1}
"""

conference_keys = ["Pfohl2022",
    "IgnatiadisWager2019"]

for key in conference_keys
        global item_no += 1
        paper = bibliography[key]
        authors = join([LaTeXString(name) for name ∈ paper["author"] ], ", ")

        global latex = L"""
        %$(latex)
        \item[%$(item_no).]
        %$(authors) (%$(paper["year"])).
        \textbf{%$(paper["title"]).}
        %$(paper["journal"]).
        """
 end

 latex = L"""
 %$(latex)
 \end{list1}

 \section{\sc Book chapters}
 \begin{list1}
 """

chapter_keys = ["Xu2022"]

for key in chapter_keys
        global item_no += 1
        paper = bibliography[key]
        authors = join([LaTeXString(name) for name ∈ paper["author"] ], ", ")

        global latex = L"""
        %$(latex)
        \item[%$(item_no).]
        %$(authors) (%$(paper["year"])).
        \textbf{%$(paper["title"]).}
        %$(paper["journal"]).
        """
end

latex = L"""
%$(latex)
\end{list1}

\section{\sc Preprints}
\begin{list1}
"""

preprint_keys = ["IgnatiadisSen2023",
    "IgnatiadisWangRamdas2022",
    "Eckles2022",
    "IgnatiadisLolas2021"
    ]

for key in preprint_keys
        global item_no += 1
        paper = bibliography[key]
        authors = join([LaTeXString(name) for name ∈ paper["author"] ], ", ")

        global latex = L"""
        %$(latex)
        \item[%$(item_no).]
        %$(authors) (%$(paper["year"])).
        \textbf{%$(paper["title"]).}
        %$(paper["journal"]).
        """
 end



latex = L"""
%$(latex)
\end{list1}


\section{\sc Invited discussions}
\textbf{International Seminar on Selective Inference (ISSI)} \hfill December 2020\\
Discussant of the talk `Clipper: p-value-free FDR control on high-throughput data from two conditions'
by Prof. Jingyi Jessica Li.



\section{\sc Peer Review}

\textbf{Statistics journals}\\
Annals of Statistics (AoS),
Bernoulli,
Biometrical Journal,
Biometrics,
Biometrika,
Electronic Journal of Statistics (EJS),
Journal of the American Statistical Association: Theory \& Methods (JASA T\&M),
Journal of Business \& Economic Statistics (JBES),
Journal of Causal Inference (JCI),
Journal of Computational and Graphical Statistics (JCGS),
Journal of the Royal Statistical Society--Series B (JRSS-B),
Journal of Statistical Software (JSS),
Statistical Papers,
Statistical Science

\ver

\textbf{Other journals}\\
Bioinformatics,
Bioinformatics Advances,
BMC Medical Research Methodology,
Journal of Cell Science,
Management Science,
Nature Protocols,
Operations Research,
PeerJ

\ver
\textbf{Conferences}\\
AISTATS (2021),
NeurIPS (2021, 2022),
ICLR (2022)

\section{\sc Software}
{\bf R packages} in Bioconductor:
\begin{list2}
\item \href{https://bioconductor.org/packages/IHW}{{\color{urlblue} IHW}}:  Independent Hypothesis Weighting for multiple testing with side-information.
\item \href{https://bioconductor.org/packages/IHWpaper}{{\color{urlblue} IHWpaper}}: Companion to the IHW package facilitating reproducibility.
\end{list2}
{\bf Julia packages} in the official registry:
\begin{list2}
\item \href{https://github.com/nignatiadis/Aurora.jl}{{\color{urlblue} Aurora.jl}}: Empirical Bayes mean estimation with nonparametric errors on replicated data.
\item \href{https://github.com/nignatiadis/Empirikos.jl}{{\color{urlblue} Empirikos.jl}}: Nonparametric empirical Bayes confidence intervals.
\item \href{https://github.com/nignatiadis/RegressionDiscontinuity.jl}{{\color{urlblue}  RegressionDiscontinuity.jl}}: Basic functionality for analyzing sharp regression discontinuity designs.
\item \href{https://github.com/nignatiadis/SigmaRidgeRegression.jl}{{\color{urlblue} SigmaRidgeRegression.jl}}: $\sigma$-Ridge for regression with features that can be partitioned into groups.
\item \href{https://github.com/nignatiadis/SmoothingSplines.jl}{{\color{urlblue} SmoothingSplines.jl}}: Nonparametric regression using smoothing splines.
\item Contributions to Distributions.jl, GLM.jl, MultipleTesting.jl and others.
\end{list2}


\section{\sc Industry experience}
\textbf{Google AdsMetrics}, Mountain View, USA \hfill Summer 2019\\
Data science intern with Omkar Muralidharan, Sujayam Saha and Dennis L. Sun.


\section{\sc Research appointments}
{\bf Biomedical Informatics},  Stanford, California, USA \hfill 2021 - 2022\\
Research assistant in the group of Prof. Nigam Shah funded by the NHLBI R01 grant `Applying statistical learning tools to personalize cardiovascular treatment'.\\
{\bf Statistics Department},  Stanford, California, USA \hfill 2017 - 2021\\
Research assistant with Prof. Stefan Wager working on empirical Bayes and causal inference problems.
{\bf European Molecular Biology Laboratory},  Heidelberg, Germany \hfill 2014 - 2016\\
Research assistant in the group of Dr. Wolfgang Huber.



\section{\sc Teaching}
\textbf{Instructor} at Columbia University\\
GR8201: Topics in Theoretical Statistics, Empirical Bayes (jointly with Bodhisattva Sen) \hfill Spring 2023

\ver

\textbf{Instructor} at Stanford University\\
STATS 302: Applied Statistics Ph.D. Qualifying Exam Workshop. \hfill Summer 2020

\ver
\textbf{Teaching Assistant (TA)} at Stanford University\\
STATS 315B: Modern Applied Statistics: Data Mining. \hfill Spring 2021\\
STATS 361: Causal Inference. \hfill Spring 2020\\
STATS 305B: Applied Statistics II. \hfill Winter 2020\\
STATS 315A: Modern Applied Statistics: Learning. \hfill Winter 2019\\
STATS 300A: Theory of Statistics I. \hfill Fall 2018\\
STATS 366 (BIOS 221): Modern Statistics for Modern Biology. \hfill Summer 2017 \& 2018, Fall 2019\\
STATS 218: Introduction to Stochastic Processes II. \hfill Spring 2018\\
STATS 290: Computing for Data Science. \hfill Winter 2018\\
STATS 305A: Introduction to Statistical Modeling. \hfill Fall 2017\\
STATS 191: Introduction to Applied Statistics. \hfill Winter 2017\\
STATS 141 (BIOS 141): Biostatistics.\hfill Fall 2016

\ver
\textbf{Trainer} at EMBL (European Molecular Biology Laboratory)\\
Introductory Course: Statistical Bioinformatics using R and Bioconductor \hfill October 2015
"""

latex = L"""
%$(latex)
\section{\sc Talks and Presentations}
\begin{adjustwidth*}{0pt}{0pt}
"""

for (i, key) in enumerate(sorted_talks)
    talk = talks[key]
    escape_at_start = i==1 ? LaTeXString("") : LaTeXString("\\\\")
    global latex = L"""
    %$(latex) %$(escape_at_start)
    \textbf{%$(talk["title"])} \\
    %$(talk["event"]) \\
    %$(talk["location"]), %$(talk["month"]) %$(talk["year"])
    """
end


latex = L"""
%$(latex)
\end{adjustwidth*}
\end{resume}
\end{document}
"""

open(texname, "w") do file
    write(file, latex)
end

run(`tectonic ignatiadis_cv4.tex`)
