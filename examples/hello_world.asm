includelib          kernel32.lib                                        ; Windows kernel interface

GetStdHandle        proto                                               ; Function to retrieve I/O handle
WriteConsoleA       proto                                               ; Function writes to command window
Console             equ             -11                                 ; Device code for console text output
ExitProcess         proto

.code
        main        proc                                           

        sub         RSP, 40                                             ; Reserve "shadow space" on stack

;       Obtain "handle" for console display monitor I/O Streams
        mov         RCX, Console                                        ; Console standard output handle
        call        GetStdHandle                                        ; Returns handle in register RAX
        mov         stdout, RAX                                         ; Save handle for text display

;       Display the "Hello, World!" Message
        mov         RCX, stdout                                         ; Handle to standard output device
        lea         RDX, msg                                            ; Pointer to message (byte array)
        mov         R8, lengthof msg                                    ; Number of characters to display
        lea         R9, nbwr                                            ; Number of btes actually written
        call        WriteConsoleA                                       ; Write text to command window

        add         RSP, 40                                             ; Replace "shadow space" on stack
        mov         RCX, 0                                              ; Set exit status code to zero
        call        ExitProcess                                         ; Return control to Windows

        main        endp

.data
        msg         byte             "Hello, World!"
        stdout      qword            ?                                  ; Handle to standard output device
        nbwr        qword            ?                                  ; Number of bytes actually written

        end