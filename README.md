# Poster
See [./poster.pdf]

I learnt a lot about how to write a poster when I was presenting this one at the end of the program. Making mine more readable by cutting a column off and focusing on the results and interpretations, rather than obfuscating with equations and logic like I have done would be better. When I was presenting I had a sort of elevator pitch I would go through with people and I would now write a poster to elaborate on such a pitch. If I find time I might make a poster V2 based on these points, but as Huxley said sometimes you just have to move on.

---

You can contact me at leastwood [at] student [dot] unimelb [dot] edu [dot] au for any questions.


---
# Tips for future students

## Writing a poster
Besides what I have written above, try to keep the poster very readable and approachable. As in, don't overload your poster with calculations. You should mention key techniques that are important in your work, but not include step-by-step details. In my project I used the important technique of stationary phase in a few calculations. Instead of showing off this technique in calculations, save the clutter from the equations and talk about how the technique allows you to solve a problem in your work. This helps with readability and helping the audience connect how the technique might be useful in their own work).

Use lots of diagrams too. Flow charts for how different propositions fit together are great, and are a good way to show where a conjecture could lead things.

The article [Suggestions For Giving Talks](https://arxiv.org/pdf/gr-qc/9703019) by Robert Geroch is a good read. I like the quote:
>Talking about physics does not closely resemble thinking about physics because the purposes in the two cases are entirely different. The amount of information you emit is irrelevant; it’s the amount you cause to be absorbed that counts. A talk has a clear objective, to force certain information into the minds of the audience.

## Compiling a poster template

If you are using the template from https://github.com/andiac/gemini-cam and are compiling with latexmk, or you encounter a `fontspec` use `lualatex` error, you can compile your poster by running:
```bash
latexmk -pdflua poster.tex
```
This tells `latexmk` to use `lualatex` to compile the project instead of the default engine.

For manual compilation I recommend using a `Makefile` with the following contents (adapted from the `Makefile` in the above templates repo):
```Makefile
.PHONY: main clean 

main: poster.pdf

poster.pdf: 
	latexmk -pdflua  poster.tex

clean: latexmkrc
	latexmk -pdflua -C
```
You can compile the poster by running `make` and remove the auxilliary files by running `make clean`. Put this file is in the same directory as `poster.tex`. This `Makefile` depends on a `.latexmkrc` file to help with better cleaning, see below. If you don't have one of these remove this word from the file.

### Using vimtex to compile
To allow continuous compile with lualatex, add the following line to your `.latexmkrc` file in the project directory:
```perl
$lualatex = 'lualatex --interaction=nonstopmode';
```
This command sets flags that `lualatex` executes when `lualatex` is called. For example, this call happens when executing
```bash
latexmk -pdflua 
```
and passing possible addition flags, such as `-C` during cleaning in the above `Makefile`. Note that `-pdflua` calls `lualatex` to generate a `.pdf`. 

To ensure vimtex actually calls `lualatex` you need to add
```tex
%! Tex Program = lualatex
```
to the first line of the `poster.tex` file.


The poster templates repo has a `.latexmkrc` file that you can use to help with `bibtex` generation and the cleaning process (done by either `VimTex`, `latexmk` or the `Makefile` above). Copy these lines into you `.latexmkrc` file if you want the better cleaning and `bibtex` generation.

The overall call process is as follows:
1. You run `:VimtexCompile` (e.g. by running `<localleader>ll`).
2. `VimTex` calls `lualatex` to compile the main file (`poster.tex`). This is facilitated by `latexmk`.
3. `latexmk` looks for `.latexmkrc` files, and in our case finds the variable `$lualatex` set above, and uses its value as the compilation command. The `--interaction=nonstopmode` allows `VimTex` to compile on-save by stopping the (lualatex) engine halting-on-error.

Note: I have to run `make` to first generate aux files, then I can use `VimTex`. Not doing so causes my window manager to crash. Hopefully you don't encounter this issue. I'll test this in a Docker container when I get time.

### Generating a printable poster
I had some trouble setting the dimensions of my doc. In the `poster.tex` template above, I used
```latex
\usepackage[size=custom,width=85,height=120,scale=1.0]{beamerposter}
```
Running `pdfinfo poster.pdf` we see
```
Page size:       2409.45 x 3401.58 pts
```
These dimensions are 2.02 times that of an a2 page size:
```
Page size:       1190.55 x 1683.78 pts (A2)
```
I then ran
```bash
pdfjam --outfile submission.pdf --paper a2paper poster.pdf
```
to generate a `submission.pdf` file with the desired dimensions
```
Page size:       1190.55 x 1683.78 pts (A2)
```
and verified the output pdf was ok. I'm pretty sure I got the `pdfjam` command from [this StackExchange thread](https://superuser.com/questions/676013/scaling-pdf-content-and-page-dimensions-from-command-line).

