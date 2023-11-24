# #!/bin/bash
# -------------------------------PRACTICAL TASK 6------------------------------ #
# Create script, that generates report file with following information:         #
#     - current date and time;                                                  #
#     - name of current user;                                                   #
#     - internal IP address and hostname;                                       #
#     - external IP address;                                                    #
#     - name and version of Linux distribution;                                 #
#     - system uptime;                                                          #
#     - information about used and free space in / in GB;                       #
#     - information about total and free RAM;                                   #
#     - number and frequency of CPU cores                                       #
# ----------------------------------------------------------------------------- #

# Global Variables / Default Values
# *--------------------------------------------------------------------------*

# *--------------------------------------------------------------------------*

# Functions*INIT*------------------------------------------------------------*
# funcReportFile() {

# }

funcInfo() {
    adate="Report Date: $(date)"
    usr="User: $USER"
    intIP="Internal IP: $(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"
    # The dig command in Linux is used to gather DNS information. It stands for
    # Domain Information Groper, and it collects data about Domain Name Servers.
    # dig [server] [name] [type]
    # dig @8.8.8.8 google.com
    extIP="External IP: $(dig @resolver1.opendns.com myip.opendns.com +short)"
    linuxDist="Name and Version: $(uname -v)"
    uptime="Uptime: $(uptime | awk -F, '{sub(".*up ",x,$1);print $1,$2}')"
    freespace0=$(df $PWD | awk '/[0-9]%/{print $(NF-2)}')
    freespace="$(($freespace0 / 1000000)) GB"
    usedspace0=$(df $PWD | awk '/[0-9]%/{print $(NF-3)}')
    freeram="Free ram: $(free -m)"
    cores="Number of cores: $(nproc)"
    corefreq="$(sudo dmesg | grep MHz)"

    echo -e "$adate\n$usr\n$intIP\n$extIP\n$linuxDist\n$uptime\n$freespace\n$usedspace0\n$freeram\n$cores\n$corefreq"

}

functest() (
    echo "test"
)
# Functions*END*------------------------------------------------------------*

# Script*INIT*--------------------------------------------------------------*
clear
funcInfo
functest
# Script*END*---------------------------------------------------------------*
