// For M_PI constant
#define _USE_MATH_DEFINES

#include <cstdio>
#include <cmath>

constexpr double MIN_X = 0.1;
constexpr double MAX_X = 0.6;

bool is_not_in_valid_range(const double &x)
{
	return (x < MIN_X) || (x > MAX_X);
}

double calculate_target_function(const double& x)
{
	return (abs(sin(sqrt(10.5 * x))))
		/ (pow(x, (3.0 / 2.0)) - 0.143)
		+ (2 * M_PI * x);
}

void print_prompt()
{
	printf("Enter number in the range [%.1f .. %.1f]: ", MIN_X, MAX_X);
}

void print_result(const double& result)
{
	printf("Result is: % 8.2f\n", result);
}

void read_input(double& x)
{
	scanf("%lf", &x);
}

/**
 * Программа запрашивает у пользователя значение X и сразу же выводит на консоль
 * значение y(X), где y - заранее оговорённая функция из задания.
 * Значение X должно быть из заранее оговорённого интервала.
 * 
 * Если введённое пользователем значение не входит в интервал, повторяем запрос ввода.
 */
int main()
{
	double x{ MIN_X - 1 };
	while (is_not_in_valid_range(x))
	{
		print_prompt();
		read_input(x);
	}
	
	print_result(calculate_target_function(x));

	return 0;
}
