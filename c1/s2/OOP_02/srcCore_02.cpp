// For M_PI constant
#define _USE_MATH_DEFINES

#include <cstdio>
#include <cmath>

constexpr auto MY_FAIL_READ_CYLINDERS_NUMBER = -1;
constexpr auto MY_FAIL_READ_CYLINDERS_HEIGHT = -2;
constexpr auto MY_FAIL_READ_FIRST_CYLINDER_RADIUS = -3;

constexpr double METAL_SHEET_THICKNESS = 0.2;
constexpr int METAL_SHEET_DENSITY = 5000;

double getCylinderVolume(double radius, double height) {
	return radius * radius * M_PI * height;
}

double calculateReservoirWallsVolume(double firstReservoirRadius, int i, double cylindersHeight) {
	double innerRadius = firstReservoirRadius * sqrt((double)i);
	double externalRadius = innerRadius + METAL_SHEET_THICKNESS;
	double innerHeight = cylindersHeight - METAL_SHEET_THICKNESS * 2;
	return getCylinderVolume(externalRadius, cylindersHeight) - getCylinderVolume(innerRadius, innerHeight);
}

double calculateTotalReservoirsVolume(int reservoirsNumber, double firstReservoirRadius, double cylindersHeight) {
	double totalReservoirsVolume = 0.0;
	for (int i = 1; i <= reservoirsNumber; ++i)
	{
		double currentReservoirVolume = calculateReservoirWallsVolume(firstReservoirRadius, i, cylindersHeight);
		printf("Volume of walls of reservoir #%i: %12.2lf\n", i, currentReservoirVolume);
		totalReservoirsVolume += currentReservoirVolume;
	}
	return totalReservoirsVolume;
}

int askForInteger(const char* prompt, const char* errorMessage, int errorExitCode) {
	printf(prompt);
	int value;
	int entriesRead = scanf("%i", &value);
	if (entriesRead < 1) {
		printf(errorMessage);
		exit(errorExitCode);
	}
	return value;
}

int askForReservoirsNumber() {
	return askForInteger(
		"Enter number of cylinders:\n",
		"Error reading number of cylinders",
		MY_FAIL_READ_CYLINDERS_NUMBER
	);
}

int askForReservoirsHeight() {
	return askForInteger(
		"Enter height of cylinders (it equals for each):\n",
		"Error reading height of cylinders",
		MY_FAIL_READ_CYLINDERS_HEIGHT
	);
}

int askForFirstReservoirRadius() {
	return askForInteger(
		"Enter inner radius of 1st cylinder: \n",
		"Error reading inner radius of the 1st cylinder",
		MY_FAIL_READ_FIRST_CYLINDER_RADIUS
	);
}

int main()
{
	int reservoirsNumber = askForReservoirsNumber();

	int reservoirsHeight = askForReservoirsHeight();

	int firstReservoirRadius = askForFirstReservoirRadius();

	printf("Cylinder wall thickness equals %3.1f\n", METAL_SHEET_THICKNESS);
	printf("Metal density equals %i\n", METAL_SHEET_DENSITY);

	double totalReservoirsVolume = calculateTotalReservoirsVolume(reservoirsNumber, firstReservoirRadius, reservoirsHeight);
	printf("Summary volume of reservoirs' walls: %12.2f\n", totalReservoirsVolume);

	double totalMass = totalReservoirsVolume * METAL_SHEET_DENSITY;
	printf("Summary mass of reservoirs' walls: %12.2f\n", totalMass);

	return 0;
}
