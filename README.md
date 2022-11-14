# ITSG Zertifikat generieren

If you need to create a certificate signing request for the ITSG this repo should help. The documentation from ITSG is a bit suboptimal in places, you can't copy the `itsg.config` since it is a two column layout etc.

This little script will make it easy to do it, so you just have to worry about the paperwork (which you can either send via snail mail or fax!). `just do-it` will run through all steps and ask you to input all data. Only thing you need to provide is your IK number. The needed files will be written to `./out/`, so make a backup of those once you are done. If you run the script again, it might very well overwrtie existing files - be careful! The `preflight-check` recipe should avoid that, but you can still delete it if you are not careful.

Requirements
* https://github.com/casey/just
* openssl
* IK number

Usage
```
# to see possible targets
just

# to run through the steps and create the files in ./out/``
just do-it
```
