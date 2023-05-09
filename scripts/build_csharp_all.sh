cd /source/\[cs_modules\]/
for d in */ ; do
    [ -L "${d%/}" ] && continue
    sh /source/scripts/build_csharp.sh $d
done