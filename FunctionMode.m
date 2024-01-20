#Revised version of Derivative Angles, designed by Bakr Alrawi
#Telegram: @Bakr_Alrawi
#Instagram: bakr_rkab

#Part 0: Preamble for the code
warning ("off", "OctSymPy:sym:rationalapprox");
pkg load symbolic
pkg load interval
close #closes open figure windows
close
fflush(stdout);
syms x; #identifies x as a symbolic variable
x1 = -10000:0.1:10000; #Identifies the domain with 0.1 increments

#Part 0.5: Settings

display("Would you like to have a graph to display the tangent point?")
graph_option = yes_or_no("Plot the graphs?: ");
value_option = yes_or_no("Would you like angle values to be displayed in degrees? (radians by default): ");
display("Enter your function!", "Make sure the independent value is expressed as 'x'")
display("Also, make sure that any coefficients be separated from their term with an * symbol (unnecessary for a - sign)")

#Part 1: Identifying the Original Function and its Derivative
str1F = input("Your Function: ", "s");
str1F = strrep(str1F,"e^x","exp(x)") #Does not help in all cases of writing 'e' but for now this will be used
symb1F = sym(str1F);
oFunction = function_handle(symb1F); #this is the original Function
formFunction = formula(oFunction(x)); #this converts the oFunction into a formulaic form to take the derivative
symbDF = diff(formFunction);
dFunction = function_handle(symbDF); #this is the derivative of the function
disp("The derivative has been calculated!")

#Part 2: Computing the Derivative at an x-Value and Constructing the Tangent Line
dformFunction = formula(dFunction(x));
disp("What is the x-value for which you want to evaluate the derivative at? (For initial velocity, you can type 'vo')")
xo = input("The x-Value: ", "s");
double(vpasolve(formFunction, x, -10000));
xo = strrep(xo,"vo",num2str(ans));
subs(dformFunction, x, xo);
slope = vpa(ans);
xo = vpa(xo);
subs(formFunction, x, xo);
yo = vpa(ans);
formTL = formula(slope * x - slope * xo + yo);
tLine = function_handle(formula(slope * x - slope * xo + yo));
idx = index(disp(formTL), "x");
condition1 = 0;
condition2 = 0;
eqnComparator = formFunction == formTL;

#Part 3: Plotting to show
if idx == 0
  if double(formTL) == 0
    disp("The tangent line has an angle of 0 or 180 (degrees or radians) with the x-Axis")
    condition1 = 1;
  else
    disp("The tangent line does not have an angle with (is parallel to) the x-Axis")
    condition2 = 1;
  endif
endif

if graph_option > 0 && condition1 == 0 && condition2 == 0
  figure(1)
  axis([-10000 10000 -5e07 5e07]);
  xaxisline = x1 - x1;
  if double(vpasolve(formTL)) > double(xo)
    xmin = double(xo) - 1;
    xmax = double(vpasolve(formTL));
    xfinalmax = double(xmax) + 0.25 * (double(xmax) - double(xmin));
    xfinalmin = double(xmin) - 0.25 * (double(xmax) - double(xmin));
  elseif double(vpasolve(formTL)) < double(xo)
    xmin = double(vpasolve(formTL)) - 1;
    xmax = double(xo) + 5;
    xfinalmax = double(xmax) + 0.25 * (double(xmax) - double(xmin));
    xfinalmin = double(xmin) - 0.25 * (double(xmax) - double(xmin));
  else
    xfinalmin = double(vpasolve(formTL)) - 1;
    xfinalmax = xfinalmin + 5;
  endif
  ymax = double(((vpa(xfinalmax) - vpa(xfinalmin))) * 0.5);
  ymin = double(-ymax);
  disp("Your graph has been created!")
  plot(x1, tLine(x1), x1, oFunction(x1))
  line ("xdata",[-10000,10000], "ydata",[0,0], "linewidth", 0.5)
  line ("xdata",[0,0], "ydata",[-10000,10000], "linewidth", 0.5)
  axis([xfinalmin xfinalmax ymin ymax], "square");
  legend('Tangent Line', 'Original Function f(x)', 'x-Axis', 'y-Axis')
  title("The Original Function with the Tangent Line")

  figure(2);
  if double(vpasolve(formTL)) > double(xo)
    xmin = double(xo) - 1;
    xmax = double(vpasolve(formTL)) + 5;
  elseif double(vpasolve(formTL)) < double(xo)
    xmin = double(vpasolve(formTL)) - 1;
    xmax = double(xo) + 5;
  else
    xmin = double(vpasolve(formTL)) - 1;
    xmax = double(xmin) + 5;
  endif
  ymax = double((double(xmax) - double(xmin)) * 0.5);
  ymin = double(-ymax);
  plot(x1, tLine(x1), x1, xaxisline, "color", "k")
  axis([xmin xmax ymin ymax], "square")
  legend('Tangent Line', 'X-Axis Line')
  title("Highlighting the Angle of the Tangent Line with the x-Axis")
endif
disp("-----------------Results-----------------")
disp("The function and the tangent line are tangent at (y-Value)...")
if condition1 == 1
  disp("every real value of x")
elseif condition2 == 1
  disp("Nowhere")
else
  disp(double(yo))
endif

#Part 4: Finding the Angle between the Tangent Line and the X-axis

if condition1 == 0 && condition2 == 0
  oppositeSide = double(yo) - 0 + 1 * double(slope); #This is the difference in the y-values
  adjacentSide = double(xo) - double(vpasolve(formTL)) + 1; # This is the difference in the x-values
  preAngleRad = atan(oppositeSide / adjacentSide); #The angle in radians
  preAngleDeg =  preAngleRad * 180/pi; #The angle in degrees
  if preAngleDeg < 0
    theAngleDeg = 90 - abs(preAngleDeg) + 90;
    theAngleRad = theAngleDeg * pi/180;
  else
    theAngleDeg = preAngleDeg;
    theAngleRad = preAngleRad;
  endif
  if value_option > 0
    disp("The angle that the tangent line makes with the x-Axis is (in degrees)...")
    disp(strcat(sprintf('%.10f', theAngleDeg), ", which is approximately ~", sprintf('%.0f\n', theAngleDeg)))
  else
    disp("The angle that the tangent line makes with the x-Axis is (in radians)...")
    disp(strcat(sprintf('%.10f', theAngleRad), ", which is approximately ~", sprintf('%.0f\n', theAngleRad)))
  endif
  if theAngleDeg > 90
    disp("Nevertheless, the direction of your tangent line itself is at an angle of (in degrees)...")
    disp(theAngleDeg - 180)
  endif
endif
#Part 5: Graphing a part-circle to represent that angle

