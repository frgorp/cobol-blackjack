         IDENTIFICATION DIVISION.
        PROGRAM-ID.     BLACKJACK.
        AUTHOR.         FRED SHIH.

        DATA DIVISION.
        WORKING-STORAGE SECTION.
        01  PLAYER-TOTAL            PIC 9(2)    VALUE 0.
        01  HIT-OR-STAY             PIC X       VALUE "N".
        01  RANDOM-VALUE            PIC 9(2).
        01  RANDOM-SEED             PIC 9(8).
        
        PROCEDURE DIVISION.
        PROGRAM-BEGIN.
      * SEED RANDOM
            MOVE FUNCTION CURRENT-DATE(9:8) TO RANDOM-SEED.
            COMPUTE RANDOM-VALUE = FUNCTION RANDOM(RANDOM-SEED).
            DISPLAY RANDOM-SEED.

            DISPLAY "WELCOME TO BLACKJACK!".
            PERFORM PLAY-GAME UNTIL HIT-OR-STAY = 'S'.
            DISPLAY "YOU ENDED THE GAME WITH: ", PLAYER-TOTAL.
        PROGRAM-DONE.
            STOP RUN.

        PLAY-GAME.
            IF PLAYER-TOTAL < 21
                DISPLAY "YOUR CURRENT TOTAL IS: " WITH NO ADVANCING
                DISPLAY PLAYER-TOTAL
                DISPLAY "HIT OR STAY? (H/S): " WITH NO ADVANCING
                ACCEPT HIT-OR-STAY
                IF HIT-OR-STAY = "H" OR HIT-OR-STAY = "S"
                    IF HIT-OR-STAY = "H"
                        PERFORM HIT-DECK
                    END-IF
                ELSE
                    DISPLAY 'NOT VALID, PLEASE ENTER'
      -             " H or S " WITH NO ADVANCING
                END-IF
            ELSE
                IF PLAYER-TOTAL = 21
                    DISPLAY "BLACKJACK!"
                    DISPLAY "YOU WIN THE GAME!"
                ELSE
                    DISPLAY "YOU BUST!"
                END-IF
                MOVE 'S' TO HIT-OR-STAY
            END-IF.

        HIT-DECK.
            COMPUTE RANDOM-VALUE = FUNCTION RANDOM() * 12.
            COMPUTE RANDOM-VALUE = FUNCTION MOD(RANDOM-VALUE, 12).
            ADD 1 TO RANDOM-VALUE.
            ADD RANDOM-VALUE TO PLAYER-TOTAL.
            DISPLAY "GOT A CARD WITH NUMBER: ", RANDOM-VALUE.
