# Open Redirect Payloads
Payloads from BB reports for Open Redirect

***

### Replace www.whitelisteddomain.tld with a specific white listed domain in your test case

To to this simply modify the WHITELISTEDDOMAIN with value www.test.com to your test case URL.

`WHITELISTEDDOMAIN="www.test.com" && sed 's/www.whitelisteddomain.tld/'"$WHITELISTEDDOMAIN"'/' Open-Redirect-payloads.txt > Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".tmp && sed 's/@www.whitelisteddomain.tld/@'"$WHITELISTEDDOMAIN"'/' Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".tmp > Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt && echo "$WHITELISTEDDOMAIN" | awk -F. '{if ($1 =="www")print "//not"$2"."$NF"/"; else print "//not"$1"."$NF"/";}' >> Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt && echo "$WHITELISTEDDOMAIN" | awk -F. '{if ($1 =="www")print "http://not"$2"."$NF"/"; else print "http://not"$1"."$NF"/";}' >> Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt && echo "$WHITELISTEDDOMAIN" | awk -F. '{print "http://"$0"."$NF"/"}' >> Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt && rm -f Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".tmp && echo -e "\nDone. Filename: $(pwd)/Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt"`

***
