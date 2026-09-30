# `oicontest.cls` 使用说明

`oicontest.cls` 是一个面向信息学竞赛题面（OI/ICPC 风格）的中文 LaTeX 文档类。它在 `ctexart` 的基础上预设 A4 纸张、页眉页脚、题目元数据表格、题目章节标题、样例代码和题面表格等格式，适合把多道题目排版成一份完整的比赛题面。

本文以仓库中的 `oicontest/oicontest.cls` 为准。类文件中声明的内部类名是 `oicontest-v2`，但仓库文件名是 `oicontest.cls`；因此最稳妥的用法是把类文件复制到主文档所在目录后使用 `\documentclass{oicontest}`。如果使用现有示例中的 `\documentclass{oicontest-v2}`，请先将类文件重命名为 `oicontest-v2.cls`，或建立同名副本。

## 安装

### 依赖

建议使用带有完整中文支持的 TeX Live（2022 或更新版本）和 XeLaTeX。类文件直接加载了下列宏包：

`ctexart`、`xeCJK`、`xeCJKfntef`、`etoolbox`、`geometry`、`titling`、`titlesec`、`amsmath`、`amssymb`、`amsfonts`、`tabularx`、`makecell`、`graphicx`、`hyperref`、`lineno`、`minted`、`tikz`、`xcolor`、`tcolorbox`、`fancyhdr`、`fancyvrb`、`lastpage`、`verbatim`、`enumitem` 和 `tabularray`。

在 Debian/Ubuntu 上可以安装 TeX Live 的完整集合：

```bash
sudo apt install texlive-full python3-pygments
```

若不希望安装完整集合，至少需要上述宏包及其依赖，并安装 Python 的 `Pygments`，因为 `minted` 依赖 `pygmentize`。类文件默认使用 `SimSun`、`SimHei` 和 `Consolas`：

```tex
\setCJKmainfont{SimSun}[BoldFont=SimHei]
\setmonofont{Consolas}
```

系统没有这些字体时，请在导言区改成已安装的字体，例如 Noto CJK 与 Noto Sans Mono：

```tex
\setCJKmainfont{Noto Serif CJK SC}[BoldFont=Noto Sans CJK SC]
\setmonofont{Noto Sans Mono}
\setCJKmonofont{Noto Sans Mono}
```

### 文件安装位置

最简单的方式是把 `oicontest.cls` 放在 `.tex` 主文件旁边：

```text
contest/
├── contest.tex
└── oicontest.cls
```

也可以把它安装到 TeX 的本地目录树中，并运行 `mktexlsr`；对于单个题面项目，放在项目目录更容易复现。

### 编译

由于样例代码使用 `minted`，编译必须允许调用外部程序：

```bash
xelatex -shell-escape contest.tex
xelatex -shell-escape contest.tex
```

通常需要编译两次，第二次用于更新 `lastpage` 和交叉引用。使用 `latexmk` 时：

```bash
latexmk -xelatex -shell-escape contest.tex
```

在受限的在线平台上，如果不能启用 `-shell-escape`，请不要使用 `oicsample`/`oicsamplefrom`，或改用不需要 `minted` 的本地排版方案；类文件本身仍会加载 `minted`，所以平台必须提供该宏包。

## 快速开始

下面的最小示例生成一份含两道题的题面：

```tex
\documentclass{oicontest}

\title{NOI 2024}
\subtitle{Day 1}
\author{出题组}
\date{2024 年 7 月 4 日}

\addproblem{集合}{set}{传统型}{2.0}{512}{20}{是}
\addproblem{百万富翁}{richest}{交互型}{6.0}{512}{2}{否}

\begin{document}

\oictitlepage

\oicnextproblem
\oicstatement
题目描述写在这里。

\oicinputformat
输入格式写在这里。

\oicoutputformat
输出格式写在这里。

\oicsampleinput{1}
\begin{oicsample}
1 2 3
\end{oicsample}

\oicsampleoutput{1}
\begin{oicsample}
6
\end{oicsample}

\oicconstraints
\begin{oictable}{ccc}
测试点 & $n\leq$ & 分值 \\
1 & $100$ & $100\%$
\end{oictable}

\oicnextproblem
\oicstatement
第二道题的题目描述。

\end{document}
```

`\addproblem` 的顺序决定题目编号和题目页顺序。每次调用 `\oicnextproblem` 会开始下一道题，并自动显示形如“题目名称（英文名）”的章节标题；因此应在每道题内容开始前调用一次。

## 完整参考

### 文档类与全局设置

```tex
\documentclass{oicontest}
```

类继承 `ctexart`，固定使用 A4、12 磅字号，并设置页边距为上下左右 2.5 cm、行距为 `1.3` 倍。默认使用 `fancy` 页眉：左侧显示标题和副标题，右侧显示当前节标题；页脚显示“第 x 页 / 共 y 页”。链接为蓝色无边框。

列表环境的段前段后间距和项目间距被压缩，左缩进约为 3 em。`section` 标题居中并使用黑体；`subsection` 标题以中文方括号包围，例如“【输入格式】”。

类文件将等宽字体设为 `Consolas`，中文正文设为 `SimSun`，粗体中文设为 `SimHei`。如果字体不可用，应按安装部分覆盖这些设置。

### 标题页

```tex
\title{比赛名称}
\subtitle{Day 1}
\author{出题组}
\date{2024 年 7 月 4 日}
\oictitlepage
```

`\oictitlepage` 清空当前页，以空白页样式调用 `\maketitle`。标题、副标题、作者和日期均可省略；省略的字段不会输出。

标题页还会输出题目总表、C++ 编译选项和注意事项。题目总表的数据来自所有 `\addproblem` 调用。页眉中的标题和副标题也来自 `\title` 与 `\subtitle`。

可以用 `\listadd` 向注意事项列表追加内容：

```tex
\listadd{\oicattention}{选手可以使用自测工具进行调试。}
```

也可以设置评测机器和环境：

```tex
\renewcommand{\oicjudgermachine}{AMD EPYC 7B13}
\renewcommand{\oicjudgerenvironment}{Ubuntu 22.04，g++ 12.3}
```

类文件已经预置文件名、`main` 返回值、输出比较、源文件大小、栈空间和禁止作弊等注意事项。

### 题目元数据：`\addproblem`

```tex
\addproblem{中文题名}{英文题名}{题目类型}{时限}{内存}{测试点数}{是否等分}
```

七个参数的含义如下：

| 参数 | 含义 | 示例 | 生成内容 |
| --- | --- | --- | --- |
| 1 | 中文题名 | `集合` | 题目名称 |
| 2 | 英文题名，同时作为目录和文件名前缀 | `set` | 目录 `set`、可执行文件 `set`、输入 `set.in`、输出 `set.out` |
| 3 | 题目类型 | `传统型` | 题目类型 |
| 4 | 每个测试点的时间限制 | `2.0` | `2.0 秒` |
| 5 | 内存限制 | `512` | `512 MiB` |
| 6 | 测试点数量 | `20` | 测试点数目 |
| 7 | 测试点是否等分 | `是` | 是否等分 |

英文题名会用于 `\oicnextproblem` 的英文标题，也会生成 C++ 源文件名 `<英文题名>.cpp`。命令本身不检查参数内容，时间、内存和“是否等分”应按题面需要填写。

### 切换题目：`\oicnextproblem`

```tex
\oicnextproblem
```

该命令清页、将当前题目编号加一，并输出对应的题目标题。它必须按照 `\addproblem` 的顺序调用；调用次数超过已登记题目数会导致未定义的控制序列错误。题目正文中的 `\oicinputformat` 等命令会读取最近一次 `\oicnextproblem` 对应的题目元数据。

### 题目内容命令

以下命令都会生成一个带有预设格式的二级标题：

| 命令 | 标题 |
| --- | --- |
| `\oicbackground` | 题目背景 |
| `\oicstatement` | 题目描述 |
| `\oicinputformat` | 输入格式，并自动说明输入文件名 |
| `\oicoutputformat` | 输出格式，并自动说明输出文件名 |
| `\oicimplementation` | 实现细节 |
| `\oictesting` | 测试程序方式 |
| `\oicscoring` | 评分方式 |
| `\oicconstraints` | 数据范围 |
| `\oichints` | 提示 |

样例相关命令带一个样例编号参数：

```tex
\oicsampleinput{1}
\oicsampleoutput{1}
\oicsampleexplain{1}
```

它们分别输出“样例 1 输入”“样例 1 输出”和“样例 1 解释”。命令只负责标题，样例正文应紧跟其后。

```tex
\oicsamplefile{2}
```

该命令输出“样例 2”标题，并根据当前题目的英文名提示题目目录中的 `<英文名>/<英文名>2.in` 和 `<英文名>/<英文名>2.ans` 文件。它不会读取或排版这些文件。

### 代码块环境

```tex
\begin{oicsample}
输入或输出样例
\end{oicsample}
```

`oicsample` 是由 `minted` 提供的文本代码环境，使用文本高亮、边框和行号。也可以直接排版文件：

```tex
\oicsamplefrom{path/to/file.txt}
```

`\oicsamplefrom` 的参数是待显示文件路径。文件路径相对于主 `.tex` 文件解析。两种形式都需要 `-shell-escape`；若内容包含 `%`、`\` 等 TeX 特殊字符，代码环境会按原样处理。

### 表格环境：`oictable`

```tex
\begin{oictable}{列格式}
表格内容
\end{oictable}
```

该环境基于 `tabularray`，会自动居中，并在表格上下加入约 `0.8` 个基线间距。首尾横线较粗，表头下横线较粗，内部竖线使用普通线宽。列格式遵循 `tabularray` 语法，例如 `ccc`、`X[2]X[1]` 或 `Q[l]Q[c]`。

示例：

```tex
\begin{oictable}{cccc}
测试点编号 & $n\leq$ & $m\leq$ & 分值 \\
1--3 & $50$ & $10^3$ & $15\%$ \\
\end{oictable}
```

表格单元格中的数学公式需要使用 `$...$` 或 `\(...\)`。复杂表格可使用 `tabularray` 支持的列说明和单元格命令。

### 文本格式命令

```tex
\oicfilename{main.cpp}
\oicstring{Yes}
```

`\oicfilename` 用于强调文件名，`\oicstring` 使用等宽字体并加下划线，适合表示输出字符串、命令或固定文本。普通的 `\textbf` 已被重定义为中文加点强调；需要代码字体时优先使用 `\texttt` 或 `\oicstring`。

## 常见问题

**`minted` 报错或没有代码高亮。** 确认已安装 `python3-pygments`，并使用 `xelatex -shell-escape`。清理项目中的 `_minted-*` 目录后再编译，通常可以排除缓存造成的问题。

**字体找不到。** 在导言区用 `\setCJKmainfont`、`\setmonofont` 和 `\setCJKmonofont` 指定系统已有字体。字体名称必须与 `fc-list` 或操作系统字体管理器显示的名称一致。

**页脚总页数显示为 `??`。** 再运行一次 XeLaTeX；`lastpage` 需要第二次编译才能得到最终页数。

**题目页标题或输入文件名不正确。** 确认每道题都先调用了 `\addproblem`，并且在正文开始前按相同顺序调用 `\oicnextproblem`。英文题名同时决定目录、输入输出文件名和 C++ 源文件名。

## 许可证

本类文件遵循仓库根目录 [LICENSE](../LICENSE) 中的许可条款。
