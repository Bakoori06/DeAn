#DeAn 1.0, designed by Bakr Al-rawi
#Telegram: @Bakr_Alrawi
#Instagram: bakr_rkab
#Kinematics Mode

#Part 0: Preamble for the code
warning ("off", "OctSymPy:sym:rationalapprox");
pkg load symbolic
pkg load interval
close #closes open figure windows
close
fflush(stdout);
syms x; #identifies x as a symbolic variable
x1 = -10000:0.1:10000; #Identifies the domain with 0.1 increments

disp("Provide the following information:")
value_option = yes_or_no("Would you like angle values to be displayed in degrees? (radians by default): ");
disp("What is the acceleration (pay attention to the sign)? Type 'g' if you are dealing with Earth's gravity")
ac_v = input("Acceleration: ", "s");
ac_v = strrep(ac_v,"g",num2str(-9.80665));
ac_v = str2num(ac_v);
disp("what is the initial velocity?")
in_v = str2num(input("Initial velocity: ", "s"));
disp("What is the initial position (initial height)?")
in_p = str2num(input("Initial position: ", "s"));

HeightEquation = formula(in_p + in_v * x + 1/2 * (ac_v) * x^2);
formVelocityEq = formula(((in_v + ac_v * x)^2 - (in_v)^2)/(2*ac_v) + in_p);
velocityEq = function_handle(formula(((in_v + ac_v * x)^2 - (in_v)^2)/(2*ac_v) + in_p));
double(vpasolve(formVelocityEq, x, 10000));
xmaxi = ans;
maxheightX = (double(vpasolve(formVelocityEq, x, 10000)) + in_p) / 2;
subs(formVelocityEq, x, maxheightX);
maxheightY = double(ans);


symbDx = diff(formVelocityEq);
dPosition = function_handle(symbDx);
dformPosition = formula(dPosition(x));

double(vpasolve(dformPosition, x, 0));
subs(formVelocityEq, x, ans);
maxheightY = double(ans);

disp("What is the x-value (time) for which you want to evaluate the derivative at?")
disp("For initial velocity, you can type 'vo'")
xo = input("The time: ", "s");
xo = strrep(xo,"vo",num2str(0));
subs(dformPosition, x, xo);
slope = vpa(ans);
xo = vpa(xo);
subs(formVelocityEq, x, xo);
yo = vpa(ans);
formTL = formula(slope * x - slope * xo + yo);
tLine = function_handle(formula(slope * x - slope * xo + yo));



plot(x1, velocityEq(x1), x1, tLine(x1));
axis([-1 xmaxi -1 maxheightY]);
title("Change in Height versus Time")
line ("xdata",[-10000,10000], "ydata",[0,0], "linewidth", 0.5)
line ("xdata",[0,0], "ydata",[-10000,10000], "linewidth", 0.5)
legend('Height vs. Time', 'Tangent Line (Instantaneous velocity)','x-Axis (time)', 'y-Axis (Height)')

idx = index(disp(formTL), "x");
condition1 = 0;
condition2 = 0;
eqnComparator = formVelocityEq == formTL;
if idx == 0
  if double(formTL) == 0
    disp("The tangent line has an angle of 0 or 180 (degrees or radians) with the x-Axis")
    condition1 = 1;
  else
    disp("The tangent line does not have an angle with (is parallel to) the x-Axis")
    condition2 = 1;
  endif
endif
disp("-----------------Results-----------------")
disp("The velocity at that time is:")
disp(double(subs(dformPosition, x, xo)))

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

disp("The trajectory falls to the ground (height of 0) at (in time)...")
disp(double(vpasolve(formVelocityEq, x, 10000)))
disp("Type 'HeightEquation' if you would like to see the formula of the inst. velocity at the specified time.")
disp("Type 'dformPosition' if you would like to see the derivative formula (inst. velocity)")
disp("Type 'dPosition' for the same purpose as above, but in anonymous function form.")
disp(":)")
