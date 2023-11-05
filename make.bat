cd .\tests\
for %%x in (*.exo) do del "%%x" 
for %%x in (*.bin) do ..\tools\exomizer.exe level -M256 -P+16-32 -c -f "%%x@0x0000" -o "%%~nx.bin.exo"

cd ..
cmd /c "BeebAsm.exe -v -i exomizer_test.s.asm -do exomizer_test.ssd -opt 3"