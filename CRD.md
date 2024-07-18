### Order life cycle
Create order - this will move to pre lim
run pre trade compliance
        pre warning /pre alert - 4 eye check
if no alert or warning it will go to pre ok
send to trading: it goes to the trading blotter with new status
trader take owner ship - open
trader place the order  - work 
trade order is filled - ready
confim the order
ACCT - Trade export
prelimilinary -> check compliance

trade export prcess get triggered when it is ready state. equity order
for equity orders we mark it as acct and then send it to transaction service
ts_export - ts service


### how data is loaded in CRD
doFeed process: import data
intermediate table, csm_security, csm_position there is an equivalent import table and from there
if the process in the cs_message_log table which will have high level details
cs_data_log
doExport Process:
DoCompliance:

Position service
security service

Kettle tool - it comes in the CR