#@ Integer (label="Define number a") a
#@ Integer (label="Define number b") b
#@ Integer (label="Define number c") c
#@ Integer (label="Divide by", min=1, max = 100, style="slider", style="slider") divide_by

function doSomething(A, B) { 
	// This function adds two numbers and divides by two
	// A and B must be numeric
	anwser = A + B
	anwser = anwser / divide_by
	return(anwser)
}

anwser_1 = doSomething(a, b);
print(anwser_1)

anwser_2 = doSomething(a, c);
print(anwser_2)




