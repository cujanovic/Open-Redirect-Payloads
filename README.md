# Open Redirect Payloads
Payloads from BB reports for Open Redirect

***

### Replace www.whitelisteddomain.tld with a specific white listed domain in your test case

To to this simply modify the WHITELISTEDDOMAIN with value www.test.com to your test case URL.

`WHITELISTEDDOMAIN="www.test.com" && sed 's/www.whitelisteddomain.tld/'"$WHITELISTEDDOMAIN"'/' Open-Redirect-payloads.txt > Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt && echo "$WHITELISTEDDOMAIN" | awk -F. '{print "https://"$0"."$NF}' >> Open-Redirect-payloads-burp-"$WHITELISTEDDOMAIN".txt`

***
