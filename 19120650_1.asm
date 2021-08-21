.data

newLine:  .asciiz  "\n"
prompt: .asciiz "Enter the number of element (Max=49): "
string1:  .asciiz "Enter the element: "
string2:  .asciiz "\nElements of the array: \n"
char1:    .asciiz " "     #Khoang trang
string3:  .asciiz "\nSum of elements in a array: \n"

.text

main:

sub $sp, $sp, 200  #Kai bao mang co 50 phan tu su dung stack
move $a1, $sp  #Luu stack mang vao thanh ghi a1

addi $t6,$zero, 50

check_size:   #Nhap so luong phan tu mang
li $v0, 4
la $a0, prompt
syscall

li $v0, 5
syscall
move $s0, $v0
slt $t1, $s0 , $0 #neu n <0 thi nhap lai
beq  $t1, 1 , check_size  #neu t1=0 thi tro lai check_size
slt $t1, $s0, $t6    #neu n>50 thi nhap lai
beq $t1, 0 , check_size
beq $s0, 0, check_size  #neu n=0 thi quay lai 

sub $sp, $sp, 8
sw $s0, 4($sp)
sw $a1, 0($sp)

##Input cac phan tu do user nhap vao mang##
addi $t7, $t7,0  #Cho i=0
sub $sp, $sp, 8
sw $s0, 4($sp)
sw $a1, 0($sp)

move $t4, $a1
while_input:
    beq $t7, $s0, exit_input   #if (i == n) -> thoat khoi vong lap
        li $v0, 4
        la $a0, string1  #In chuoi string1
        syscall
        
        li $v0,5   #Lenh nhap cac phan tu
        syscall
        sw $v0, 0($t4)
        
        addi $t7,$t7,1   #i=i+1
        addi $t4, $t4, 4   # chuyen sang a[i] ke tiep
    j while_input
exit_input:    
#Tra ve cac thanh ghi $s0 va $ a1
lw $s0, 4($sp)
addi $t7, $zero, 4
mul $t5, $t7, $s0
sub $a1, $t4, $t5
addi $sp, $sp, 8

addi $t7, $zero, 0  #Gan lai i=0
#output mang ra man hinh
sub $sp, $sp, 8
sw $s0, 4($sp)
sw $a1, 0($sp)

li $v0,4
la $a0, string2  #in chuoi string 2
syscall
move $t4, $a1
while_output:
   beq $t7, $s0, exit_output   #if (i == n) -> thoat khoi vong lap
     li $v0, 1
     lw $a0, 0($t4)
     syscall
     
     li $v0, 4
     la $a0, char1  #In khoang trang
     syscall
     addi $t7, $t7,1
     addi $t4, $t4, 4
     j while_output
exit_output:
lw $s0, 4($sp)
addi $t7, $zero, 4
mul $t5, $t7, $s0
sub $a1, $t4, $t5
addi $sp, $sp, 8

jal sum   #Goi ham sum

addi $sp, $sp, 8   #Giai phong stack
addi $sp,$sp,200     #Giai phong mang
j endprogram    # jump xuong endprogram de ket thuc chuong trinh

#sum:    #Tinh tong cac phan tu cua mang
sum:
addi $t7, $zero, 0  #Gan lai i=0
addi $s1, $zero, 0  #Gan sum=0

sub $sp, $sp, 12
sw $ra, 8($sp)
sw $s0, 4($sp)
sw $a1, 0($sp)

move $t4, $a1
li $v0, 4
la $a0, string3   #Xuat chuoi string3 ra man hinh
syscall
while_sum:
    beq $t7, $s0, exit_sum   #Dieu kien dung
    lw $s3, 0($t4)
    add $s1, $s1, $s3 # sum= sum + a[i]
    addi $t7, $t7,1
    addi $t4, $t4, 4  
    j while_sum
exit_sum:

li $v0, 1
move $a0, $s1
syscall   #Xuat tong ra man hinh

lw $ra, 8($sp)
lw $s0, 4($sp)
addi $sp, $sp, 12
jr $ra

endprogram:   #Ket thuc chuong trinh
   li $v0, 10
   syscall
