
%%

\NeedsTeXFormat{LaTeX2e}
\def\allameh-thesisversion{0.1}
\ProvidesClass{allameh-thesis}
              [2015/01/22 v\allameh-thesisversion\space A template for the Allameh Tabataba’i University]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions
\LoadClass[a4paper,11pt]{book}
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{listings}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{calc}
\RequirePackage[top=3cm, bottom=2.5cm, left=2.5cm, right=4cm]{geometry}
\RequirePackage[]{acronym}
\RequirePackage[]{graphicx}
\graphicspath{{figures/}}
\RequirePackage{array}
\newcolumntype{C}[1]{>{\raggedleft\centering\arraybackslash}p{#1}}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\newcolumntype{M}[1]{>{\raggedleft\centering\arraybackslash}m{#1}}
\RequirePackage{multicol} 
\RequirePackage{fancyhdr}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{zref-perpage}
\zmakeperpage{footnote}
\RequirePackage{makeidx}
\makeindex
\RequirePackage[]{xcolor}
\RequirePackage[]{hyperref}


\newcommand{\besmwidth}[1]{\def\@besmwidth{#1}}
\def\department#1{\gdef\@department{#1}}
\def\thesisdate#1{\gdef\@thesisdate{#1}}
\newcommand{\firstsupervisor}[1]{\def\@firstsupervisor{#1}}
\newcommand{\secondsupervisor}[1]{\def\@secondsupervisor{#1}}
\newcommand{\firstadvisor}[1]{\def\@firstadvisor{#1}}
\newcommand{\secondadvisor}[1]{\def\@secondadvisor{#1}}
\def\name#1{\gdef\@name{#1}}
\def\surname#1{\gdef\@surname{#1}}
\def\proctorname#1{\gdef\@proctorname{#1}}
\newcommand{\credit}[1]{\def\@credit{#1}}
\newcommand{\defensedate}[1]{\def\@defensedate{#1}}
\newcommand{\grade}[1]{\def\@grade{#1}}
\newcommand{\letgrade}[1]{\def\@letgrade{#1}}
\newcommand{\degree}[1]{\def\@degree{#1}}
\newcommand{\firstinternalreferee}[1]{\def\@firstinternalreferee{#1}}
\newcommand{\secondinternalreferee}[1]{\def\@secondinternalreferee{#1}}
\newcommand{\firstexternalreferee}[1]{\def\@firstexternalreferee{#1}}
\newcommand{\secondexternalreferee}[1]{\def\@secondexternalreferee{#1}}
\newcommand{\viewer}[1]{\def\@viewer{#1}}
\newcommand{\totext}[1]{\def\@totext{#1}}
\newcommand{\ack}[1]{\def\@ack{#1}}
\newcommand{\faabstract}[1]{\def\@faabstract{#1}}
\newcommand{\fakey}[1]{\def\@fakey{#1}}
\def\faculty#1{\gdef\@faculty{#1}}
\def\subject#1{\gdef\@subject{#1}}
\def\field#1{\gdef\@field{#1}}
\def\department#1{\gdef\@department{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%
\def\latintitle#1{\gdef\@latintitle{#1}}
\def\latinthesisdate#1{\gdef\@latinthesisdate{#1}}
\def\latindepartment#1{\gdef\@latindepartment{#1}}
\def\latinfaculty#1{\gdef\@latinfaculty{#1}}
\def\firstlatinsupervisor#1{\gdef\@firstlatinsupervisor{#1}}
\def\secondlatinsupervisor#1{\gdef\@secondlatinsupervisor{#1}}
\def\firstlatinadvisor#1{\gdef\@firstlatinadvisor{#1}}
\def\secondlatinadvisor#1{\gdef\@secondlatinadvisor{#1}}
\def\latinname#1{\gdef\@latinname{#1}}
\def\latinsurname#1{\gdef\@latinsurname{#1}}
\newcommand{\enabstract}[1]{\def\@enabstract{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\if@mscthesis
\@mscthesisfalse
\DeclareOption{msc}{\@mscthesistrue}
\ProcessOptions
%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\mychapter}[1]{%
\phantomsection%
\addcontentsline{toc}{chapter}{#1}\chapter*{#1}\markboth{#1}{#1}%
}

\newcommand{\allamehtitle}{%
\thispagestyle{empty}
%\cleardoublepage%~

\begin{titlepage}
به نام خداوند بخشنده مهربان 
\\
{
\includegraphics[width=2.8cm]{ATU_logo.eps}
}
\\
 دانشگاه علامه طباطبائی
\\[6pt]
{\Large\@faculty
\\[6pt]
\@department}
\par
\vspace{.3\baselineskip}
{\large\bfseries
پایان نامه 
\if@mscthesis
کارشناسی ارشد رشته 
\else
دکتری رشته
\fi
\@subject
 گرایش
\@field
}
\vskip 2ex
\centerline{\large \bfseries}
\vskip 6ex
{\huge\bfseries {\@title}}
\baselineskip=1.5cm\par
\vskip 4ex
 \baselineskip=.5cm
\large
{\ifx\@firstsupervisor\undefined%
\ifx\@secondsupervisor\undefined%
\else\fi
\else
\ifx\@secondsupervisor\undefined%
{\large\bfseries
استاد راهنما:\\
\@firstsupervisor}
\else
{\large\bfseries 
استادان راهنما:\\
\@firstsupervisor{} و \@secondsupervisor}
\fi\fi}
\par\large
{\ifx\@firstadvisor\undefined%
\ifx\@secondadvisor\undefined%
\else\fi
\else
\ifx\@secondadvisor\undefined%
{\large\bfseries
استاد مشاور:\\
\@firstadvisor}
\else
{\large\bfseries
استادان مشاور:\\
\@firstadvisor{} و \@secondadvisor}
\fi\fi}
\par\large
{\large\bfseries%
پژوهشگر: \\
\@name\  \@surname}\par
{\large \@thesisdate}
\end{titlepage}

%%%%%%%%%%%%
\pagenumbering{harfi}
\setcounter{page}{1}
\pagestyle{plain}
\newpage
%\cleardoublepage%~
{\large \bfseries \noindent 
%\thispagestyle{empty}
\begin{center}\includegraphics[scale=.30]{ATU_logo.eps}
\end{center}\par
{\settextfont[Scale=1.3]{B Nazanin}
\begin{center}
به نام خدا\\
\textbf{منشور اخلاق پژوهش}
\end{center}
با یاری از خداوند سبحان و اعتقاد به این که عالم محضر خداوند است و همواره ناظر به اعمال انسان و به منظور پاس داشت مقام بلند دانش و پژوهش و نظر به اهمیت جایگاه دانشگاه در اعتلای فرهنگ و تمدن بشری ما دانشجویان دانشکده ‌های دانشگاه علامه طباطبائی متعهد می گردیم اصول زیر را در انجام فعالیت ‌های پژوهشی مد نظر قرار داده و از آن تخطی نکنیم:
\begin{enumerate}
\item 	اصل حقیقت جوئی: تلاش در راستای پی جویی حقیقت و وفاداری به آن و دوری از هرگونه پنهان سازی حقیقت،
\item	اصل رعایت حقوق: التزام به رعایت کامل حقوق پژوهشگران و پژوهیدگان (انسان، حیوان و نبات) و سایر صاحبان حق،
\item	اصل مالکیت مادی و معنوی: تعهد به رعایت کامل حقوق مادی و معنوی دانشگاه و کلیه همکاران پژوهش،
\item	اصل منافع ملی: تعهد به رعایت مصالح ملی و در نظر داشتن پیشبرد و توسعه کشور در کلیه مراحل پژوهش،
\item	اصل رعایت انصاف و امانت: تعهد به اجتناب از هرگونه جانب داری غیر علمی و حفاظت از اموال، تجهیزات و منابع در اختیار،
\item	اصل رازداری: تعهد به صیانت از اسرار و اطلاعات محرمانه افراد، سازمان هاو کشور و کلیه افراد و نهاد‌های مرتبط با تحقیق،
\item	اصل احترام: تعهد به رعایت حریم ‌ها ‌و حرمت ‌ها ‌در انجام تحقیقات و رعایت جانب نقد و خودداری از هرگونه حرمت شکنی،
\item	اصل ترویج: تعهد به رواج دانش و اشاعه نتایج تحقیقات و انتقال آن به همکاران علمی و دانشجویان به غیر از مواردی که منع قانونی دارد،
\item	اصل برائت: التزام به برائت جوئی از هرگونه رفتار غیر حرفه ای و اعلام موضع نسبت به کسانی که حوزه علم و پژوهش را به شائبه ‌های غیر علمی می آلایند.                                          
\end{enumerate}
\begin{center}
\@name \ \@surname
\vskip 2ex
\@defensedate
\\
امضاء
\end{center}

}
}
\newpage
%\thispagestyle{empty}
\noindent
\pagestyle{plain}
%\cleardoublepage%~
{\large \bfseries \noindent 
%\thispagestyle{empty}
\begin{center}\includegraphics[scale=.30]{ATU_logo.eps}
\end{center}\par
{\settextfont[Scale=1.3]{B Nazanin}
\begin{center}
\textbf{تعهدنامه اصالت اثر}
\end{center}
اینجانب
\ \@name \ \@surname \ 
دانش آموخته مقطع تحصیلی کارشناسی ارشد در رشته 
\ \@subject \
که در تاریخ 
\@defensedate \ 
از پایان نامه خود تحت عنوان 
«{\@title}»
با کسب نمره
\ifx\@grade\undefined
\hphantom{     }
\else
\@grade\
\fi
دفاع نموده ام، متعهد می شوم:
\\
\begin{enumerate}
\item	این پایان نامه حاصل تحقیق و پژوهش انجام شده توسط اینجانب بوده و درمواردی که از دستاوردهای علمی و پژوهشی دیگران (اعم از مقاله، کتاب، پایان نامه و غیره) استفاده نموده ام، مطابق ضوابط ورویه موجود، نام منبع مورد استفاده و سایر مشخصات آن را در فهرست مربوط ذکر و درج کرده ام.
\item	این پایان نامه قبلا برای دریافت هیچ مدرک تحصیلی (هم سطح، پایین تر یا بالاتر) در سایر دانشگاه ها و موسسات آموزش عالی ارائه نشده است.
\item	چنانچه بعد از فراغت از تحصیل، قصد استفاده از هرگونه بهره برداری اعم از چاپ کتاب، ثبت اختراع و ازین دست موارد از این پایان نامه را داشته باشم، از حوزه معاونت پژوهشی دانشگاه علامه طباطبائی مجوزهای مربوطه را اخذ نمایم.
\item	چنانچه در هر مقطع زمانی خلاف موارد فوق ثابت شود، عواقب ناشی از آن را می پذیرم و دانشگاهی مجاز است با اینجانب مطابق ضوابط و مقررات رفتار نموده و درصورت ابطال مدرک تحصیلی ام هیچ گونه ادعائی نخواهم داشت.
\end{enumerate}
\begin{center}
\@name \ \@surname
\vskip 2ex
\@defensedate
\\
امضاء
\end{center}

}
}

\cleardoublepage%~
%\thispagestyle{empty}
{\minutesfont
\vspace{1em}%
\renewcommand{\arraystretch}{2.25}%
\begin{tabular}{|M{3.4cm}|@{}M{6.95cm}@{}|M{3cm}|}
\hline
\vspace{1pt}
\par
\vspace{-2mm}
{\small 
مدیریت تحصیلات تکمیلی
}
&
\baselineskip=1cm
{\large \bfseries 
تاییدیه هیأت داوران جلسه دفاع از پایان نامه ویژه کتابخانه مرکزی\par
دوره
\if@mscthesis 
کارشناسی ارشد
\else
دکتری
\fi
}
&
\if@mscthesis 
  
\else
  
\fi
\\ \hline
\multicolumn{3}{|p{14cm}|}{
\baselineskip=1cm
جلسه دفاعیه پایان‌نامه تحصیلی آقای:          
\@name \  \@surname
\hfill
 دانشجوی
\if@mscthesis 
 كارشناسی ارشد
\else
دکتری
\fi
\par
 رشتـه/گرایش:       
\@subject/\@field
\par                                        
تحت عنوان:        
\@title
\par                                                                                                        
و تعداد واحد:   
\hskip 1ex
\ifx\@credit\undefined
\else
\@credit
\fi
\hskip 1ex
در تاریخ 
\ifx\@credit\undefined
\else
\@defensedate\
\fi \
 با حضور اعضای هيأت داوران (به شرح ذیل) تشكيل گرديد.
\par
پس از ارزيابی توسط هيأت داوران، پايان‌نامه با نمره به عدد 
\ifx\@grade\undefined
\hphantom{     }
\else
\@grade\
\fi
به حروف    
\ifx\@letgrade\undefined
\hphantom{            }
\else
\@letgrade\
\fi                        
و  درجه      
\ifx\@degree\undefined
\hphantom{     }
\else
\@degree\
\fi
 مورد تصويب قرار گرفت.

\vspace{2em}
\begin{tabular}{@{}R{4.2cm}C{5.7cm}C{3cm}@{}}
%%\hline
\multicolumn{1}{c}{\underline{عنوان}}
 &
\underline{نام و نام خانوادگی}
&
\underline{امضاء}%
\\[1em]
%%\hline
استاد راهنما:
\if@mscthesis
\else 
الف:
\ifx\@secondsupervisor\undefined
\else
\newline
\hphantom{استاد راهنما:}
ب:
 \fi
 \fi
 & 
 \@firstsupervisor{}
 \ifx\@secondsupervisor\undefined
 \else
 \par
 \@secondsupervisor
 \fi
 &
\\[2em]
استاد مشاور:
\if@mscthesis
\else
الف:
\ifx\@secondadvisor\undefined
\else
\newline
\hphantom{استاد مشاور:}
ب:
 \fi
 \fi
&
\ifx\@firstadvisor\undefined
  \else
   \@firstadvisor
\fi
 \ifx\@secondadvisor\undefined
 \else
 \par
 \@secondadvisor
 \fi
 &
\\[2em]
\if@mscthesis 
متخصص و صاحبنظر داخلی:
\else
داور داخل گروه: 
\fi
\if@mscthesis
\else 
الف:
\ifx\@secondinternalreferee\undefined
 \else
 \newline
\hphantom{داور داخل گروه:}
ب:
 \fi
 \fi
&
\ifx\@firstinternalreferee\undefined
  \else
   \@firstinternalreferee
\fi
 \ifx\@secondinternalreferee\undefined
 \else
 \par
 \@secondinternalreferee
 \fi
 &
\\[2em] 
\if@mscthesis 
متخصص و صاحبنظر خارجی:
\else
داور خارج از گروه: 
\fi
\if@mscthesis
\else 
الف:
\ifx\@secondexternalreferee\undefined
\else
\newline
\hphantom{داور خارج از گروه:}
ب:
 \fi
 \fi
 & 
 \@firstexternalreferee{}
 \ifx\@secondexternalreferee\undefined
 \else
 \par
 \@secondexternalreferee
 \fi
 &
\\[1.5cm] 
&
\multicolumn{2}{R{7cm}}{
\baselineskip=.7cm
نماينده تحصيلات تكميلی دانشگاه (ناظر)
\par
نام ونام خانوادگی:
\ifx\@viewer\undefined
  \else
   \@viewer
\fi
\par
امضاء:
}
\\[5em]
%%\hline 
\end{tabular} 
}
\\ \hline
\end{tabular}
}% end of \bnazanin font
%\cleardoublepage%~
\newpage
%\cleardoublepage%~
%\thispagestyle{empty}
\ifx\@totext\undefined%
\else
%\thispagestyle{empty}
\@totext
\fi
\newpage
%\cleardoublepage%~
%\thispagestyle{empty}
\ifx\@ack\undefined%
\else
%\thispagestyle{empty}
\@ack
\fi
%\pagenumbering{harfi}
\pagestyle{plain}
%\setcounter{page}{1}
%\clearpage
}

\def\titlepage{\newpage\centering
 \thispagestyle{empty}
  \parindent 0pt \parskip 10pt plus 1fil minus 1fil
  \def\baselinestretch{1}\@normalsize\vbox to \vsize\bgroup\vbox to 9in\bgroup}
\def\endtitlepage{\par\kern 0pt\egroup\vss\egroup\newpage}

\def\signature{\vspace{1cm}
\begin{flushleft}
{\scriptsize \@name\ \@surname \\
\@thesisdate}
\end{flushleft}}

\newcommand{\latinallamehtitle}{%
\setcounter{page}{2}
\cleardoublepage%~
\newpage
\ifx\@enabstract\undefined%
\else
\@enabstract
\fi
\setcounter{page}{2}
%\cleardoublepage%~
\thispagestyle{empty}{\tiny .} \newpage
\begin{titlepage}
\begin{center}\includegraphics[scale=.60]{ATU_logo.eps}
\end{center}
{\Large \bfseries
Allameh Tabataba’i University
}
\\[10pt]
{\Large \bfseries Faculty of \@latinfaculty
\\Department of \@latindepartment}
\par
\vspace{4em}
{\Large
 \if@mscthesis
Thesis Submitted in Partial Fulfillment of the Requirements for the Degree of  \\[1em]
Master of Arts (MA) / Master of Science (MSc) in. . . . . .
\else
Thesis Submitted \\[1em]
for the degree of Ph.D.
\fi
}
\par
\vspace{5em}
{\Large \bfseries Title:}
\par
{\Large\bfseries\@latintitle}
\baselineskip=1cm \par
\vskip 1.5cm
\ifx\@firstlatinsupervisor\undefined%
\ifx\@secondlatinsupervisor\undefined%
\else\fi
\else
\ifx\@secondlatinsupervisor\undefined%
{\large\bfseries
Supervisor:
\@firstlatinsupervisor}
\else
{\large\bfseries
Supervisors:
 \@firstlatinsupervisor{} and \@secondlatinsupervisor}
\fi\fi
\par
\ifx\@firstlatinadvisor\undefined%
\ifx\@secondlatinadvisor\undefined%
\else\fi
\else
\ifx\@secondlatinadvisor\undefined%
{\large\bfseries
Advisor:
\@firstlatinadvisor}
\else
{\large\bfseries
Advisors:
\@firstlatinadvisor{} and \@secondlatinadvisor}
\fi\fi
\vskip 5mm
{\large\bfseries By:
\@latinname \; \@latinsurname}\par
\vskip 5mm
\par
\vskip 1cm
{\large\bfseries Terhan 
\\\@latinthesisdate}
\par
\vskip 1cm
\par
\vfill
%
\end{titlepage}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\persiangloss[2]{#1\dotfill\lr{#2}\\}
\newcommand\englishgloss[2]{#2\dotfill\lr{#1}\\}
%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{
\theoremstyle{definition}
\newtheorem{definition}{تعریف}[section]
\theoremstyle{plain}
\newtheorem{theorem}[definition]{قضیه}
\newtheorem{lemma}[definition]{لم}
\newtheorem{proposition}[definition]{گزاره}
\newtheorem{corollary}[definition]{نتیجه}
\newtheorem{remark}[definition]{ملاحظه}
\theoremstyle{definition}
\newtheorem{example}[definition]{مثال}
\renewcommand{\bibname}{منابع و مآخذ}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{fancy}
\fancyhf{} 
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\AtBeginDocument{
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \if@RTL\raggedleft\else\raggedright\fi \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \huge\bfseries \@chapapp\space \thechapter
        \par\nobreak
        \vskip 20\p@
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
    \thispagestyle{empty}
    \newpage
  }}
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \if@RTL\raggedleft\else\raggedright\fi
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
    \thispagestyle{empty}
%%    \newpage
  }}  
  \flushbottom
}


\setlength{\parindent}{1cm}
\setlength{\parskip}{0pt}

\setlength{\footskip}{
\paperheight   -(1in+\voffset+\topmargin+\headheight+\headsep+\textheight)  -1cm
}

\makeatletter
\renewcommand\section{\@startsection{section}{1}{\z@}%
                                   {-1.4cm \@plus -0ex \@minus -0ex}%
                                   {1cm \@plus0ex}%
                                   {\normalfont\Large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                    {-1.4cm \@plus -0ex \@minus -0ex}%
                                   {1cm \@plus0ex}%
                                     {\normalfont\large\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-1.4cm \@plus -0ex \@minus -0ex}%
                                   {1cm \@plus0ex}%
                                     {\normalfont\normalsize\bfseries}}  


\def\bflabel#1{{\textsf{#1}\hfill}}
\renewcommand*\@verridelabel[1]{%
  \@bsphack
  \label{#1}%
  \protected@write\@auxout{}{\string\undonewlabel{#1}}%
  \@overriddenmessage rs{#1}%
  \@esphack
}%
\renewcommand*{\@acf}[1]{%
      \ifAC@starred\else\AC@logged{#1}\fi%
       \acffont{%
          \AC@placelabel{#1}\hskip\z@%\AC@acl{#1}%
          \nolinebreak[3]%
          \acfsfont{\acsfont{\AC@acs{#1}}}%
        }}
 \makeatother
 
\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\vspace*{\fill}
\begin{center}
%این صفحه، عمداً خالی گذاشته شده است.
\end{center}
\vspace{\fill}
\thispagestyle{empty}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother


\makeatletter
\let\origprintindex\printindex
\renewcommand*{\printindex}{%
\cleardoublepage
  \fancypagestyle{plain}{%
    \fancyhf{}%
    \renewcommand{\headrulewidth}{0pt}%
    \renewcommand{\footrulewidth}{0pt}%
  }%
  \tolerance=10000
  \origprintindex
}
\makeatother
%% 
%% 
%% Distributable under the LaTeX Project Public License,
%% version 1.3c or higher (your choice). The latest version of
%% this license is at: http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status)
%%  by Vahid Damanafshan.
%% 
%% 
%% 
%% 
%%
%% End of file `allameh-thesis.cls'.
