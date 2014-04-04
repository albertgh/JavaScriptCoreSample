//计算阶乘  
var factorial = function(n)
{
	if (n < 0)
    {
		return;
    }
	if (n === 0)
    {
		return 1;
    }
	return n * factorial(n - 1)
};


//计算阶乘
function test(n) {
	if (n < 0)
		return;
	if (n === 0)
		return 1;
	return n * test(n - 1)
};

