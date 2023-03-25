/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2023 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Based on MsltoeJuliaBulb Eiffie. Refer post by Eiffie  Reply #69 on: January 27, 2015
 * @reference http://www.fractalforums.com/theory/choosing-the-squaring-formula-by-location/60/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_msltoe_sym4_mod1.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MsltoeSym4Mod1Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (aux->i >= fractal->transformCommon.startIterationsK
			&& aux->i < fractal->transformCommon.stopIterationsK)
	{
		if (fractal->transformCommon.functionEnabledBx) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledBy) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledBz) z.z = fabs(z.z);
		REAL4 pfive = fractal->transformCommon.additionConstant0555;
		REAL t;
		if (fractal->transformCommon.functionEnabledAx)
		{
			t = z.x - z.z;
			t = pfive.x * (t - fabs(t));
			z.x = z.x - t;
			z.z = z.z + t;
		}

		if (fractal->transformCommon.functionEnabledAy)
		{
			t = z.x - z.y;
			t = pfive.y * (t - fabs(t));
			z.x = z.x - t;
			z.y = z.y + t;
		}

		if (fractal->transformCommon.functionEnabledAz)
		{
			t = z.y - z.z;
			t = pfive.z * (t - fabs(t));
			z.y = z.y - t;
			z.z = z.z + t;
		}

		z += fractal->transformCommon.offsetA000;
	}

	REAL4 c = aux->const_c;
	aux->DE = aux->DE * 2.0f * aux->r;

	REAL psi = fractal->transformCommon.int8Y;
	if (fractal->transformCommon.functionEnabledBFalse
			&& aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{
		psi += fractal->transformCommon.int1;
	}
	psi = M_PI_F / psi;
	psi = fabs(fmod(atan2(z.z, z.y) + M_PI_F + psi, 2.0f * psi) - psi);
	REAL len = native_sqrt(z.y * z.y + z.z * z.z);
	z.y = native_cos(psi) * len;
	z.z = native_sin(psi) * len;

	REAL4 z2 = z * z;
	REAL rr = z2.x + z2.y + z2.z;
	REAL m = 1.0f - z2.z / rr;
	REAL4 temp;
	temp.x = (z2.x - z2.y) * m * fractal->transformCommon.scaleB1;
	temp.y = 2.0f * z.x * z.y * m * fractal->transformCommon.scale; // scaling y;
	temp.z = 2.0f * z.z * native_sqrt(z2.x + z2.y);
	temp.w = z.w;
	z = temp + fractal->transformCommon.additionConstantNeg100;

	if (fractal->transformCommon.addCpixelEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		REAL4 tempFAB = c;
		if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
		if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
		if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

		tempFAB *= fractal->transformCommon.constantMultiplier000;
		z.x += sign(z.x) * tempFAB.x;
		z.y += sign(z.y) * tempFAB.y;
		z.z += sign(z.z) * tempFAB.z;
	}
	REAL lengthTempZ = -length(z);
	z *= 1.0f + fractal->transformCommon.offset / lengthTempZ;
	z *= fractal->transformCommon.scale1;
	aux->DE *= fabs(fractal->transformCommon.scale1);

	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

	if (fractal->transformCommon.functionEnabledOFalse)
	{
		aux->DE0 = length(z);
		if (aux->DE0 > 1.0f)
			aux->DE0 = 0.5f * log(aux->DE0) * aux->DE0 / aux->DE;
		else
			aux->DE0 = 0.0f;
		if (!fractal->transformCommon.functionEnabledYFalse)
			aux->dist = aux->DE0;
		else
			aux->dist = min(aux->dist, aux->DE0);
	}
	return z;
}