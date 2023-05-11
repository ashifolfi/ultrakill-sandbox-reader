# ULTRAKILL Sandbox Reader
Simple Lua utility to create extremely human readable variants of ULTRAKILL Sandbox save data in Valve KeyValues Format

## How to use
1. Open the script in a code/text editor and modify FILENAME to match the name of the sandbox file you want to edit
> NOTE: make sure the file is actually in the folder you're running the script from
2. run the script with Lua

you should now have 4 files:
- SB_Meta.txt
- SB_Blocks.txt
- SB_Props.txt
- SB_Enemies.txt

## why Valve KeyValues
the KV format is one of the most human readable and easily digestable data formats in my honest opinion. thus it's a perfect fit for visualizing a minified json file in a much more digestable manner than purely formatting the original json file.

## why does this exist
I created this tool to assist with documenting various object properties for the [ULTRAKILL Sandbox Editor](https://github.com/kaypooma/ultrakill-sandbox-viewer) and thought I'd release it as some people might find it useful.
