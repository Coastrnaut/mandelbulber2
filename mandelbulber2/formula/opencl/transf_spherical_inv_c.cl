/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2024 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * inverted sphere z & c- A transform from M3D
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/
 * updated v2.12

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_spherical_inv_c.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfSphericalInvCIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL rSqrL;
	REAL4 tempC;
	if (!fractal->transformCommon.functionEnabledFalse)
	{
		tempC = aux->const_c;
		tempC *= fractal->transformCommon.constantMultiplier111;
		rSqrL = dot(tempC, tempC);
		// if (rSqrL < 1e-21f) rSqrL = 1e-21f;
		rSqrL = 1.0f / rSqrL;
		tempC *= rSqrL;
	}
	else
	{
		tempC = aux->c;
		if (!fractal->transformCommon.functionEnabledAFalse)
		{
			tempC *= fractal->transformCommon.constantMultiplier111;
			rSqrL = dot(tempC, tempC);
			// if (rSqrL < 1e-21f) rSqrL = 1e-21f;
			rSqrL = 1.0f / rSqrL;
			tempC *= rSqrL;
			aux->c = tempC;
		}
		else
		{
			rSqrL = dot(tempC, tempC);
			// if (rSqrL < 1e-21f) rSqrL = 1e-21f;
			rSqrL = 1.0f / rSqrL;
			tempC *= rSqrL;
			aux->c = tempC;
			tempC *= fractal->transformCommon.constantMultiplier111;
		}
	}

	if (fractal->transformCommon.functionEnabledAwFalse)
	{
		rSqrL = dot(z, z);
		// if (rSqrL < 1e-21f) rSqrL = 1e-21f;
		rSqrL = 1.0f / rSqrL;
		z *= rSqrL;
		aux->DE *= rSqrL;
		z += tempC;
	}
	z += tempC;
	return z;
}