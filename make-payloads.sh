#!/usr/bin/env bash

#If terminal add collors
if [[ -t 1 ]]; then
	#Colors
	red='\e[0;31m'
	green='\e[0;32m'
	blue='\e[0;36m'
	yellow='\e[0;33m'
	errorredline='\e[0;41m'
	greenbgblacktext='\e[30;48;5;82m'
	NC='\e[0m'
else
	#NoColors
	red=''
	green=''
	blue=''
	yellow=''
	errorredline=''
	greenbgblacktext=''
	NC=''
fi

WHITELISTEDDOMAIN="$1"

function PRINT_CORRECT_USAGE_EXAMPLE () {
	echo -e "$0 www.whitelisteddomain.pw\n"
	echo -e "${green}$0 www.google.com\n${NC}"
	echo -e "${blue}$0 app.domain.com\n${NC}"
}

function CHECK_PREVIOUS_CMD () {
if [ $? -ne 0 ]; then
	echo -e "${errorredline}Build error${NC}"
	echo -e "${red}$0 script error at line: $1 ${NC}"
	echo -e "${yellow}View the last log above.${NC}"
	exit 1
fi
}

function MAKE_REDIRECT_PAYLOADS () {
	sed 's/www.whitelisteddomain.tld/'"$WHITELISTEDDOMAIN"'/' Open-Redirect-payloads.txt > Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".tmp
	CHECK_PREVIOUS_CMD $LINENO
	sed 's/@www.whitelisteddomain.tld/@'"$WHITELISTEDDOMAIN"'/' Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".tmp > Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt
	CHECK_PREVIOUS_CMD $LINENO
	echo "$WHITELISTEDDOMAIN" | awk -F\. '{print "//not"$(NF-1) FS $NF}' >> Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt
	CHECK_PREVIOUS_CMD $LINENO
	echo "$WHITELISTEDDOMAIN" | awk -F\. '{print "http://not"$(NF-1) FS $NF}' >> Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt
	CHECK_PREVIOUS_CMD $LINENO
	echo "$WHITELISTEDDOMAIN" | awk -F. '{print "http://"$0"."$NF"/"}' >> Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt
	rm -f Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".tmp
	echo -e "\n${greenbgblacktext}Done.${NC} Filename: $(pwd)/Open-Redirect-payloads-burp-$WHITELISTEDDOMAIN.txt"
}

if [ $# -eq 0 ] || [ $# -gt 1 ] || [ $# -lt 1 ]; then
	echo -e "${NC}"
	echo -e "${red}Invalid number of arguments. Usage:\n${NC}"
	PRINT_CORRECT_USAGE_EXAMPLE
	exit 1
else
	MAKE_REDIRECT_PAYLOADS
fi