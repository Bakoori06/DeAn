# Current GitHub state of DeAn
The current GitHub repository for DeAn includes an incomplete version of the documentation, alongside the full code for DeAn 1.0.
It is advised that at least **the first 3 pages are read**, as they include the instructions on how to download and run the code.
#
**It is necessary that the .m files are all found in the same folder/location when you are running the code on GNU Octave**
## TLDR on How to Run DeAn
- Download GNU Octave
- Download the GitHub files
- Put the GitHub files all in one folder
- Open Octave, on the Command Window, type:
```
pkg load symbolic
pkg load interval
```
- Navigate in the Octave File Browser to where you stored the DeAn files
- On the Command Window, type:
```
run Start
```
- Have fun!
- Additional Note: though already stated in the code, make sure that any coefficients are separated with a * symbol. For example:
```
-3(x-4)^2 + 6
```
Will cause an error to form, instead, you must write:
```
-3*(x-4)^2 + 6
```
Notice the * placed. This also applies if the coefficient is for a non-paranthetical expression, so:
```
-3x
```
Should be typed as:
```
-3*x
```
However, if it is a - sign alone, it is not necessary to separate with a *.
