LOAD_ADDR = &5800

\ Allocate vars in ZP
ORG &80
GUARD &9F
.zp_start
    INCLUDE ".\lib\exo.h.asm"
.zp_end

\ Main
CLEAR 0, LOAD_ADDR
GUARD LOAD_ADDR
ORG &1100
.start
    INCLUDE ".\lib\exo.s.asm"

.entry_point

    \\ Turn off cursor by directly poking crtc
    lda #&0b
    sta &fe00
    lda #&20
    sta &fe01
    
    ldx #<comp_data
    ldy #>comp_data
    lda #>LOAD_ADDR

    jsr decrunch_to_page_A

    jmp *
    
.comp_data
    INCBIN ".\tests\test_0.bin.exo"

.end

SAVE "EXO", start, end, entry_point

\ ******************************************************************
\ *	Memory Info
\ ******************************************************************

PRINT "------------------------"
PRINT "  Exomizer Decompressor "
PRINT "------------------------"
PRINT "CODE SIZE         = ", ~end-start
PRINT "DECOMPRESSOR SIZE = ", entry_point-start, "bytes"
PRINT "ZERO PAGE SIZE    = ", zp_end-zp_start, "bytes"
PRINT "------------------------"
PRINT "LOAD ADDR         = ", ~start
PRINT "HIGH WATERMARK    = ", ~P%
PRINT "RAM BYTES FREE    = ", ~LOAD_ADDR-P%
PRINT "------------------------"

PUTBASIC "loader.bas","LOADER"
PUTFILE  "BOOT","!BOOT", &FFFF  