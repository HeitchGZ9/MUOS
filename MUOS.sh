#!/bin/bash
###################################################################
#Script Name    : MUOS assessment 3 script in bash  multimenu (Almost Cortana)
#Description    : This Script gives 4 options: Create a backup copy of a script file, Create a date stamped log file, create a copu of a file and move the location of a file in the current directory
#Args           : First try
#Author         : Hector Fernandez
#Email          : ec1963652@edinburghcollege.ac.uk
################################################################### 
###################################################################
##Setting up  functions and Colour variables:###
RED=`echo -en "\e[31m"` #|Red 
GRN=`echo -en "\e[32m"` #|Green 
BLU=`echo -en "\e[34m"` #|Blue   
MGN=`echo -en "\e[35m"` #|Magenta
CYN=`echo -en "\e[36m"` #|Cyan    
DEF=`echo -en "\e[0m"` #default colors and effects   



##### Function for the maun menu ####
menu () {
sleep 1
echo "
1.- Create a backup copy of a script file."
sleep 1
echo "
2.- Create a date stamped log file."
sleep 1
echo "
3.- Create a copy of a file. "
sleep 1
echo "
4.- Move the location of a file in your current directory."
sleep 1
echo "
0.- Just go away!"
}
##### Function for the bye bye message ####

bye_bye () {
echo  "Hope see you again soon, bye for now!"
sleep 1
echo "Quitting. "
sleep 1
echo "${MGN}."
sleep 1
echo "${CYN}.."
sleep 1
echo "${BLU}..."
sleep 1      
}

##### Function for come back to the main menu ####

come_back () {
z=0
sleep 1
while [ $z = 0 ]
do
echo  "Would you like to try again or go  back to the main menu?"
sleep 1
read -p "Type Again to try it again or Back to go back..." option
case $option in
  Again|again|A) 
        sleep 1
        echo "Let's do that"
        clear
        z=1
;;
  Back|back|b)  
         echo "Coming back to the main menu"
         sleep 2
         clear
         echo "Let me just remind you our options..."
        sleep 1
        n=1
        p=1
        z=1
;;
  *) echo "${RED}Sorry, no clue what you meant with that..."
     sleep 1
     echo "Let's try again${DEF}";;
esac
done
}



#This is just a welcome banner
clear
echo "${RED}              ___           ___           ___           ___     "
echo "${RED}             /\__\         /\__\         /\  \         /\  \     "
echo "${RED}            /::|  |       /:/  /        /::\  \       /::\  \    "
echo "${GRN}           /:|:|  |      /:/  /        /:/\:\  \     /:/\ \  \   "
echo "${GRN}          /:/|:|__|__   /:/  /  ___   /:/  \:\  \   _\:\~\ \  \  "
echo "${BLU}         /:/ |::::\__\ /:/__/  /\__\ /:/__/ \:\__\ /\ \:\ \ \__\ "
echo "${BLU}         \/__/~~/:/  / \:\  \ /:/  / \:\  \ /:/  / \:\ \:\ \/__/   "
echo "${CYN}               /:/  /   \:\  /:/  /   \:\  /:/  /   \:\ \:\__\   "
echo "${CYN}              /:/  /     \:\/:/  /     \:\/:/  /     \:\/:/  /   "
echo "${MGN}             /:/  /       \::/  /       \::/  /       \::/  /    "
echo "${MGN}             \/__/         \/__/         \/__/         \/__/     "
echo "${DEF}   "

#This first stage of the script just echoes the menu's options
sleep 2
echo "
Hey ${GRN}$USER${DEF}!"
sleep 1
echo "My name is ${GRN}MUOS${DEF}. I know I am not Cortana, but I still can do some good stuff!"
sleep 3
echo "Here some things that I can do for you:"
sleep 1

######This second part creates the body of the menu.##############

m=0 #main variable for loops

while [ $m = 0 ]
do
######  
n=0 ####
p=0 # secondary varibles for loops
######
menu
echo "Tell me, what can I do for you then?"
sleep 1
read -p  "Pick an option 0-4, please: . . . " answer    
sleep 1
##########################################Begining of the  Case conditinal for the script options.####################################
        case $answer in
        1)  clear
            echo "I can do that!" 
            sleep 1
            while [ $n = 0 ]
            do  
              read -p "Write the name of the file: . . .  " option1                                          #This creates a  input variable#
                sleep 1
                if [[ $option1 == *sh ]]; then                                                               #If conditional to check if the file is a script that follows the linux conventions#
                        file=$option1                                                                        #Variable part of the file's name#
                        times=$(date +%d_%m_%y)                                                              #Variable to print  append the date to the file#
                        final_file=$file._backup_.$times                                                     #Variable to build the full name of the file#
                                 if [[ -f $HOME/$final_file ]]; then                                         #If to check if the file already exist in the home directory#
                                        sleep 1
                                        echo "${RED}Sorry, this file already exist ${BLU}:(${DEF}"
                                        come_back
                                 elif [[ ! -f ./$option1 ]]; then                                             # Check if the file to back up exist in the
                                        echo "${RED}Sorry, this file does not exist${DEF}"
                                        come_back

                                 else  sleep 1
                                        echo "${BLU}Easy peasy"
                                        cp $option1   $final_file && mv $final_file  $HOME                     #secuence to make a copy of the file and move to ~ directory#
                                        sleep 1
                                        echo -e "Yes! $option1 has been backedup as $final_file${DEF}"                 # Inform user that everything went ok
                                        sleep 1
                                        bye_bye
                                        n=1
                                        m=1
                                fi
                        else
                                clear
                                echo "${RED}Sorry,This is not a script!!! ${BLU}:(${DEF}"
                                come_back             # Loop back to main menu 


                        fi

                   done         
                        ;;
        2) clear
                echo "Let's go...!"
                user=$(cat /etc/passwd | grep home | cut -d ":" -f1)                    #########
                who=$(whoami)                                                           ########
                disk=$(du -ch / 2> /dev/null | grep -w "total")                         ##### Variables for the output##
                run=$(ps)                                                               ########
                times=$(date +%d_%m_%y)                                                 ##########
                clear
                if [[ -d $HOME/log_dir ]]; then                                         #Conditional to check if the log_dir directory exist##
                        echo -e "The this are the users of the system: $user
\nBut Right now $who is logged.\nThe total disk usage is: $disk \nAnd last, this are the running processes:\n $run"   > $HOME/log_dir/log.$times   # Command that creates a string with the variables and then send them to a file in the log_dir directory##
                        echo "Log file created! :)"
                        sleep 1
                        bye_bye
                        m=1
                else                                                                    #next part of the conditional In case the directory does not exist##
                        clear
                        echo "${MGN}Minor issues here..."
                        sleep 1
                        echo "I think log_dir directory does not exist${DEF}"
                        sleep 1
                   while [ $n = 0 ]                                                                     ## This conditional loop back until the log is correctly created.
                     do 
                        read -p "Would you like to create it and copy the log? Yes/No ... " direct
                        clear
                        echo "let's go...!"
                                case $direct in                                                         #Case loop to giving the option to create the directory log_dir and the log file##
                                Y|Yes|yes|YES) mkdir $HOME/log_dir                                                                                      ###########
                                               echo -e "The this are the users of the system: $user                                                     #########
\nBut Right now $who is logged.\nThe total disk usage is: $disk \nAnd last, this are the running processes:\n $run"   > $HOME/log_dir/log.$times        ######
                                               echo "Done! Directory and file created! :)"                                                              # Creates the directory and the file##
                                               sleep 1
                                               bye_bye

                                                n=1
                                                m=1  ;;

                                N|No|no|NO ) clear
                                             echo "${MGN}Unfortunatelly, I can't help you then.... ${RED}:( ${DEF}" 
                                             sleep 1
                                             echo "Coming back to the main menu..."                ##Looping back##
                                             echo "I am going to remind you our options:"
                                             n=1
                                             ;;
                               * ) clear
                                   echo "${RED}Sorry but I am not sure what you meant..."
                                   sleep 1
                                   echo "I am just a machine...Please, Do not confuse me!"
                                   sleep 2
                                   echo "it is a Yes or No question! ${MGN}:)${DEF}"
                                   sleep 3
                                   ;;   
                                esac
                          done
        fi

;;
                3) clear
                        echo "Leave it on me!"
                        sleep 1
                        echo "Before I start, I must let you know that I Just can copy files from your current directory."

                while [ $n = 0 ]                                                    ## First loop to don't leave the option until the file is sent
                do 

                        read -p "Which file would you like me to copy?:" source
                        if [[ -f $source  ]]; then                                      ## This conditional makes a loop to if the file exist

                                while [ $p = 0 ]                                       ## Second loop to let the user choose again the directory if the  directory dies not exit
                                do
                                read -p "Where do you want me to send it?: " destiny
                                        if [[ ! -d $destiny ]]; then                            ## This conditional makes a loop to check if the directory exist
                                                clear
                                                sleep 1
                                                echo "I can't find the directory ${RED}$destiny${DEF}"
                                                sleep 1
                                                echo "${BLU}Remember, Linux is case sensitive!${DEF}"
                                                come_back
                                                sleep 2
                                                clear
                                        else
                                                if [[ ! -f $destiny/$source ]]; then
                                                        n=1
                                                        m=1
                                                        p=1
                                                        echo "I can do that!"                                           #####
                                                        cp $source $destiny                                           ##the copy is successfull
                                                        sleep 1                                                         #####
                                                        echo "done!"
                                                        sleep 1
                                                        bye_bye
                                                else
                                                        echo "${RED}Sorry, this file already exist!${DEF}"
                                                        sleep 1
                                                        come_back
                                                fi
                                         fi
                                         done           
                        else
                                clear
                                echo "The ${RED}$source${DEF} file does not exist"
                                sleep 2
                                echo "Remember! I just can copy files from your current directory!!"
                                sleep 1
                                echo "${BLU}Also, keep in mind that Linux is case sensitive!${DEF}"
                                sleep 1
                                come_back                                                                   #####loop back because the file does not exist 
                                sleep 2
                                clear
                        fi
        done
                        ;;

                4) clear
                   echo "That's a piece of cake!"
                   sleep 2

                   while [ $n = 0  ]                                                                      ## First loop in case the input does not match with a file in the directory
                   do
                   echo "Keep in mind that I just can move files located in your current directory!"
                   sleep 1
                   read -p  "Which file would you like me to move?..." move
                   if [[ -f $move ]]; then                                                                      ## This conditional makes a loop to check if the file exist
                                while [ $p = 0 ]                                                         ##Second loop if the input does not matcho with a directory
                                do
                                read -p "where do you want me to move it?..." where
                                   if [[ -d $where ]]; then                                               ## This conditional makes a loop to check if the directory exist
                                        if  [[ ! -f  $where/$move ]]; then                                ##This conditional makes a loop if the file already exist in the destination
                                                mv $move $where
                                                sleep 1
                                                clear
                                                echo "done!"
                                                sleep 1
                                                bye_bye
                                                m=1
                                                n=1
                                                p=1
                                        else
                                           echo "Sorry, This file already exist in this directory..." 
                                           sleep 1
                                          come_back

                                        fi
                                   else
                                        clear
                                        echo "Sorry, this directory does not exist, just double check the spelling"
                                        sleep 1
                                        echo "${BLU}Remember, Linux is case sensitive ${GRN};)${DEF}"
                                        sleep 1
                                        come_back
                                   fi
                                   done
                        else
                             echo "Sorry, this file does not exist, just double check the spelling"
                             sleep 1
                             echo "${RED}Remember, Linux is case sensitive${BLU};)${DEF}"
                             sleep 1 
                             come_back
                        fi
                        done
;;
                0) bye_bye      
                        m=1
;;
                *) 
                clear    
                echo  "${RED}Oups! I can't do that!"
                sleep 1
                echo "${MGN}Unfortunately, I am not as fancy as Cortana or Siri...${DEF}"
                sleep 1
                echo "I am going to remind you the options:"
                sleep 1
                 ;;
                esac

done

