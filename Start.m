#DeAn 1.0, designed by Bakr Al-rawi
#Telegram: @Bakr_Alrawi
#Instagram: bakr_rkab
#Start (Mode Select)

pkg load symbolic
pkg load interval
display("Would you like to:")
display("Yes: Use a pre-existing function")
display("No: Build your own graph using kinematics")
mode_option = yes_or_no("Mode: ");
if mode_option == 1
  run FunctionMode
endif

if mode_option == 0
  run KinematicsMode
endif
