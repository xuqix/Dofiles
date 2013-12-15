# Init parameters,ms style for asm
set output-radix 0x10
#set disassembly-flavor intel


define go
break main
#display /4xw $esp
#disable display 1
#display /5i $pc
run
regs
#st  8
printf "stackwin:\n"
stackwin
printf "\n"
x/6i $pc
end

define logon
    set logging file $arg0
    set logging on
end
document logon
    output to file
    usag:logon file
end

define logoff
    set logging off
end
document logoff
    shut off logon
end

define relogon
    set logging redirect on
    logon $arg0
end
document relogon
    redirect output to file
    usag:relogon file
end

define relogoff
    set logging redirect off
    logoff
end
document relogoff
    shut off redirect output
end

define to
    set pagination off
    disable display
    set $flag=0
#    relogon /dev/null
    while( $flag==0 )
        ni
        set $addr=(unsigned int)$eip
        if( (($addr) & 0x08000000 ) )
            set $flag=1
        end
    end
#    relogoff
    enable display
    set pagination on
    x/i $pc
end
document to
    if $eip not in your programe,the debug will auto run 
    until in your programe(through 'ni')
end

define argv
    show args
end
document argv
    Print program arguments
end

define sdis
    display /$arg0i $pc
end
document sdis
    print arg0 line disassemble
end

define split
    layout split
    layout regs
end


define mappings
    info proc mappings
end


define st
    x /$arg0xw $esp
end
document st
    display stack len*4 byte
    usage: st 4
end


define cls
    shell clear
end
document cls
    Clears the screen.
end


define dis
    disassemble $arg0
end
document dis
    Disassemble address
    Usage: dis addr;dis start,end;dis start,+length
end



define bpl
    info breakpoints
end
document bpl
    List breakpoints
end

define bp
    break *$arg0
end
document bp
    Set a breakpoint on address
    Usage: bp addr
end

define bpc
    clear $arg0
end
document bpc
    Clear breakpoint at function/address
    Usage: bpc addr
end

define bpe
    enable $arg0
end
document bpe
    Enable breakpoint #
    Usage: bpe num
end

define bpd
    disable $arg0
end
document bpd
    Disable breakpoint #
    Usage: bpd num
end

define bpt
    tbreak *$arg0
end
document bpt
    Set a temporary breakpoint on address
    Usage: bpt addr
end

define bpm
    awatch $arg0
end
document bpm
    Set a read/write breakpoint on address
    Usage: bpm addr
end


define flags
if (($eflags >> 0xB) & 1 )
printf "O "
else
printf "o "
end
if (($eflags >> 0xA) & 1 )
printf "D "
else
printf "d "
end
if (($eflags >> 9) & 1 )
printf "I "
else
printf "i "
end
if (($eflags >> 8) & 1 )
printf "T "
else
printf "t "
end
if (($eflags >> 7) & 1 )
printf "S "
else
printf "s "
end
if (($eflags >> 6) & 1 )
printf "Z "
else
printf "z "
end
if (($eflags >> 4) & 1 )
printf "A "
else
printf "a "
end
if (($eflags >> 2) & 1 )
printf "P "
else
printf "p "
end
if ($eflags & 1)
printf "C "
else
printf "c "
end
printf "\n"
end
document flags
Print flags register
end


define eflags
printf "     OF <%d>  DF <%d>  IF <%d>  TF <%d>",\
        (($eflags >> 0xB) & 1 ), (($eflags >> 0xA) & 1 ), \
        (($eflags >> 9) & 1 ), (($eflags >> 8) & 1 )
printf "  SF <%d>  ZF <%d>  AF <%d>  PF <%d>  CF <%d>\n",\
        (($eflags >> 7) & 1 ), (($eflags >> 6) & 1 ),\
        (($eflags >> 4) & 1 ), (($eflags >> 2) & 1 ), ($eflags & 1)
printf "     ID <%d>  VIP <%d> VIF <%d> AC <%d>",\
        (($eflags >> 0x15) & 1 ), (($eflags >> 0x14) & 1 ), \
        (($eflags >> 0x13) & 1 ), (($eflags >> 0x12) & 1 )
printf "  VM <%d>  RF <%d>  NT <%d>  IOPL <%d>\n",\
        (($eflags >> 0x11) & 1 ), (($eflags >> 0x10) & 1 ),\
        (($eflags >> 0xE) & 1 ), (($eflags >> 0xC) & 3 )
end
document eflags
Print entire eflags register
end


define regs
printf "     eax:%08X ebx:%08X  ecx:%08X ",  $eax, $ebx, $ecx
printf " edx:%08X     eflags:%08X\n",  $edx, $eflags
printf "     esi:%08X edi:%08X  esp:%08X ",  $esi, $edi, $esp
printf " ebp:%08X     eip:%08X\n", $ebp, $eip
printf "     cs:%04X  ds:%04X  es:%04X", $cs, $ds, $es
printf "  fs:%04X   gs:%04X  ss:%04X     ", $fs, $gs, $ss
flags
end
document regs
Print CPU registers
end


define func
info functions
end
document func
Print functions in target
end

define var
info variables
end
document var
Print variables (symbols) in target
end

define lib
info sharedlibrary
end
document lib
Print shared libraries linked to target
end

define sig
info signals
end
document sig
Print signal actions for target
end

define thread
info threads
end
document thread
Print threads in target
end


define chr
    set $_c=*(unsigned char *)($arg0)
    if ( $_c < 0x20 || $_c > 0x7E )
        printf "."
    else
        printf "%c", $_c
    end
end
document chr
    Print the ASCII value of arg0 or '.' if value is unprintable
    usag:chr 0x8048480
end

define hex_quad
    if( ($arg1!=1) && ($arg1!=2) && ($arg1!=4) )
        printf "command hex_quad need arg1 in [1,2,4]\n"
    end
    if ($arg1==1)
printf "%02X %02X %02X %02X  %02X %02X %02X %02X",                          \
               *(unsigned char*)($arg0), *(unsigned char*)($arg0 + 1),      \
               *(unsigned char*)($arg0 + 2), *(unsigned char*)($arg0 + 3),  \
               *(unsigned char*)($arg0 + 4), *(unsigned char*)($arg0 + 5),  \
               *(unsigned char*)($arg0 + 6), *(unsigned char*)($arg0 + 7)
    end
    if ($arg1==2)
printf "0x%04X 0x%04X 0x%04X 0x%04X",                          \
               *(unsigned short*)($arg0),      \
               *(unsigned short*)($arg0 + 2),  \
               *(unsigned short*)($arg0 + 4),   \
               *(unsigned short*)($arg0 + 6)
    end
    if ($arg1==4)
printf "0x%08X  0x%08X",\
               *(unsigned int*)($arg0),      \
               *(unsigned int*)($arg0 + 4)
    end
end
document hex_quad
    Print eight hexadecimal bytes starting at arg0,size at arg1
    usag:hex_quad ADDRESS [1,2,4]
end

define hexdump
printf "%08X : ", $arg0
hex_quad $arg0 1
printf " - "
hex_quad ($arg0+8) 1
printf " "

chr ($arg0)
chr ($arg0+1)
chr ($arg0+2)
chr ($arg0+3)
chr ($arg0+4)
chr ($arg0+5)
chr ($arg0+6)
chr ($arg0+7)
chr ($arg0+8)
chr ($arg0+9)
chr ($arg0+0xA)
chr ($arg0+0xB)
chr ($arg0+0xC)
chr ($arg0+0xD)
chr ($arg0+0xE)
chr ($arg0+0xF)

printf "\n"
end
document hexdump
    Display a 16-byte hex/ASCII dump of arg0
end

define ddump
printf "[%08X]------------------------",$arg0
printf "---------------------------------[ data]\n"
set $_count=0
while ( $_count < $arg1 )
    set $_i=($_count*0x10)
    hexdump ($arg0+$_i)
    set $_count++
end
end
document ddump
    Display $arg1 lines of hexdump for address $arg0
end

define dd
if ( ($arg0 & 0x40000000) || ($arg0 & 0x08000000) || ($arg0 & 0xBF000000) )
ddump $arg0 10
else
printf "Invalid address: %08X\n", $arg0
end
end
document dd
    Display 10 lines of a hex dump for $arg0,you can change it
end

define stackwin
    ddump $esp 2
end
document stackwin
    Display esp(stack) in the data window
end

define dump_to
    relogon _dump_to
    set pagination off
    set $_count=0
    set $_add=$arg0
    while ( $_count<$arg1 )
        printf "%02X ",*(unsigned char*)($_add)
        set $_add++
        set $_count++
        if ( ($_count%16) == 0 )
            printf "\n"
        end
    end
    set pagination on
    relogoff
    printf "dump to file ./_dump_to successful\n"
end
document dump_to
    dump hex data to file
    usag:dump_to ADDRESS BYTE_LEN
end

define dump_bin
    dump binary memory $arg0 $arg1 $arg2
end
document dump_bin
    dump memory data to file
    usag: dump_bin FILE_NAME START_ADDRESS END_ADDRESS 
end

define xdd
    if( ($arg2!=1) && ($arg2!=2) && ($arg2!=4) )
        printf "command need arg1 in [1,2,4]\n"
    else
    printf "--------------------------------------\n"
    set $_count=0
    while ( $_count < $arg1 )
        set $_i=($_count*0x10)
        printf "%08X : ", ($arg0+$_i)
        hex_quad ($arg0+$_i) $arg2
        printf " - "
        hex_quad ($arg0+$_i+4) $arg2
        printf "\n"
        set $_count++
    end
    end
end
document xdd
    advanced dd command,you can control line number in arg1 and byte-size in arg2
    usag: xdd ADDRESS LINE-NUMBER [1,2,4]
end


define mset
    set $i=0
    set $data=(char*)$arg0
    while( $arg1[$i] != 0 )
        set $data[$i]=$arg1[$i]
        set $i++
    end
end
document mset
    memory set command,set memory value in ADDRESS(arg0)
    usag: set 0xbffff308 "hello",set 0xbffff308 "\x65\x66"
end

define esp
    set $i=5
    while($i>=0)
        if($i==0)
            printf "esp:"
        else
            printf "    "
        end
        printf "%08X : ", $esp+$i*4
        printf " 0x%08X   ",*(unsigned int*)($esp+$i*4)      
        chr ($esp+$i*4)
        chr ($esp+$i*4+1)
        chr ($esp+$i*4+2)
        chr ($esp+$i*4+3)
        chr ($esp+$i*4+4)
        printf "\n"
        set $i--
    end
end
document esp
    print stack memory for esp
    usag: esp
end

define ebp
    set $i=5
    while($i>=0)
        if($i==0)
            printf "ebp:"
        else
            printf "    "
        end
        printf "%08X : ", $ebp+$i*4
        printf " 0x%08X   ",*(unsigned int*)($ebp+$i*4)      
        chr ($ebp+$i*4)
        chr ($ebp+$i*4+1)
        chr ($ebp+$i*4+2)
        chr ($ebp+$i*4+3)
        chr ($ebp+$i*4+4)
        printf "\n"
        set $i--
    end
end
document ebp
    print stack memory for ebp
    usag: ebp
end

define stop
    bpt $arg0
    continue
end
document stop
    bpt ADDRESS and run to ADDRESS
    usage: stop 0x123456
end
