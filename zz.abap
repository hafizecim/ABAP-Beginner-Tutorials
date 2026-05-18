REPORT ZZ_14_LOOP_CONTROLS.

" While Loop
data count1 type i.
 count1 = 1.
 While count1 < 10.
    WRITE : / 'Count : ', count1.
    count1 = count1 + 1.
 endwhile.


 " Do Loop

 data count2 type i.

 do 10 times.
    count2 = count2  +1.
    WRITE : / 'Count : ', count2.
 enddo.