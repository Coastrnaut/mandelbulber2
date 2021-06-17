/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Quaternion4D

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_quaternion4d.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TestingLogIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	aux->DE = aux->DE * 2.0f * aux->r + 1.0f;

	if (fractal->transformCommon.functionEnabledFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}

	REAL4 Mul = fractal->transformCommon.constantMultiplier122;
	if (!fractal->transformCommon.functionEnabledAFalse)
	{
		REAL temp = z.x * z.x + z.y * z.y + fractal->transformCommon.offset0;
		if (temp == 0.0) z = aux->const_c;
		else if (temp < 0.0) z = (REAL4){0.0, 0.0, 0.0, 0.0};
		else
		{
			REAL ZR  = fractal->transformCommon.offset1;
			Mul.z = -Mul.z * z.z * sqrt(temp);
			temp = ZR - z.z * z.z / temp;
			Mul.x = Mul.x * (z.x * z.x - z.y * z.y) * temp;
			Mul.y = Mul.y * z.x * z.y * temp;
			z = Mul;
		}
	}
	else
	{
		REAL temp = z.z * z.z + z.y * z.y + fractal->transformCommon.offset0;
		if (temp == 0.0) z = aux->const_c;
		else if (temp < 0.0) z = (REAL4){0.0, 0.0, 0.0, 0.0};
		else
		{
			REAL ZR  = fractal->transformCommon.offset1;
			Mul.x = -Mul.x * z.x * sqrt(temp);
			temp = ZR - z.x * z.x / temp;
			Mul.z = Mul.z * (z.z * z.z - z.y * z.y) * temp;
			Mul.y = Mul.y * z.z * z.y * temp;
			z = Mul;
		}
	}

	// offset (Julia)
	z += fractal->transformCommon.additionConstant000;

	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	 // DE tweak
	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

	return z;
}
