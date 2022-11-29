// Input
a = 1
b = 2
c = 3

// The tedious way
anwser_1 = a + b;
anwser_1 = anwser_1 / 2;
print(anwser_1);

anwser_2 = a + c;
anwser_2 = anwser_2 / 2;
print(anwser_2);


// The functional way
function doSomething(A, B) { 
	// This function adds two numbers and divides by two
	// A and B must be numeric
	anwser = A + B
	anwser = anwser / 2
	return(anwser)
}

anwser_1 = doSomething(a, b);
print(anwser_1)

anwser_2 = doSomething(a, c);
print(anwser_2)
