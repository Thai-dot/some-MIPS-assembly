.data
        #Khai bao 2 bien so nguyen 32 bit
        a: .word 
	b: .word 
	
	#Khai bao cac bien kieu string de xuat thong bao ra man hinh
	string: .asciiz "\nChuong trinh + - * / 2 so nguyen co ban"
	string_1:  .asciiz "\nHay nhap so a (32 bit): "
	string_2: .asciiz "\nHay nhap so b (32 bit): "	
	string_3:  .asciiz "\nTong cua a, b: "
	string_4: .asciiz "\nHieu cua a, b: "
	string_5: .asciiz "\nTich cua a, b: "
	string_6: .asciiz "\nThuong cua a, b: "
	string_7: .asciiz "\nPhan Du cua a, b: "
	
.text
main:

li $v0, 4
la $a0, string
syscall

li $v0, 4        #Goi kieu string
la $a0, string_1  #Xuat dong string_1 ra man hinh
syscall         #Keu he thong lam ngay lap tu

li $v0, 5   #Dung de nhap so A
syscall 
sw $v0, a   #Dung de luu so vua nhap vao bien a
	
lw $s0, a   #Cho a vao bo nho s0
	
li $v0, 4
la $a0, string_2 #Xuat thong bao ra man hinh
syscall

li $v0, 5    #Nhap vao so B
syscall
sw $v0, b
	
lw $s1, b   # Luu so B vao s1

li $v0, 4
la $a0, string_3
syscall
	
add $s2, $s0, $s1  #Tinh tong a + b
li $v0, 1
move $a0, $s2
syscall

li $v0, 4
la $a0, string_4 ##Xuat thong bao
syscall

sub $s2, $s0, $s1  	# Tinh hieu a- b
li $v0, 1
move $a0, $s2
syscall

li $v0, 4
la $a0, string_5
syscall
	
mult $s0, $s1   # Tinh tich a*b
mflo $s2
li $v0, 1
move $a0, $s2
syscall
	
li $v0, 4
la $a0, string_6
syscall
	
div $s0, $s1    # Tinh thuong a/b
mflo $s2
li $v0, 1
move $a0, $s2
syscall
	
li $v0, 4
la $a0, string_7
syscall
	
div $s0, $s1   # Tinh modulo a&b
mfhi $s2
li $v0, 1
move $a0, $s2
syscall	
