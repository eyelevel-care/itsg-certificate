ik := `read -e -p"Please enter ONLY THE FIRST 8 CHARS of your IK: " && echo $REPLY`

default:
  @just --list

do-it: gen-priv gen-req extract-pubkey-from-req extract-dot-pkey show-pkey-hash finally

gen-priv:
  @echo "Generating private key..."
  @openssl genrsa -out ./out/{{ik}}.prv.key.pem 4096

gen-req:
  @echo "Generating certificate request..."
  @openssl req -new -config itsg.config -key ./out/{{ik}}.prv.key.pem -sha256 -sigopt rsa_padding_mode:pss -sigopt rsa_pss_saltlen:32 -out ./out/{{ik}}.p10.req.pem

extract-pubkey-from-req:
  @echo "Extracting pubkey from request..."
  @openssl req -config itsg.config -in ./out/{{ik}}.p10.req.pem -pubkey -noout -out ./out/{{ik}}.pub.key.pem

extract-dot-pkey:
  @echo "Extract the .pkey from .pem file..."
  @openssl asn1parse -in ./out/{{ik}}.pub.key.pem -strparse 19 -out ./out/{{ik}}.pkey -noout

show-pkey-hash:
  @echo "Your pubkey hash is:"
  @openssl dgst -c -sha1 ./out/{{ik}}.pkey

show-cert-req:
  @openssl req -text -config itsg.config -in ./out/{{ik}}.p10.req.pem -nameopt multiline -noout

finally:
  @echo
  @echo
  @echo "Your data is now saved in ./out/"
  @echo "If you need to start over again run 'rm ./out/*', this will delete all generated files"
  @echo "Otherwise you can use the generated request"
  @echo "You can also show the details of your request with 'just show-cert-req'"
  @echo "If you use the generated files, it's probably a good idea to store them somewhere safe..."
