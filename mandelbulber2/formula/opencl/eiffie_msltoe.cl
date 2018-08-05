/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2018 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * MsltoeJuliaBulb Eiffie. Refer post by Eiffie    Reply #69 on: January 27, 2015
 * @reference http://www.fractalforums.com/theory/choosing-the-squaring-formula-by-location/60/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "EiffieMsltoeIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 EiffieMsltoeIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;
	REAL psi = fabs(fmod(atan2(z.z, z.y) + M_PI_F + M_PI_8, M_PI_4) - M_PI_8);
	REAL lengthYZ = native_sqrt(mad(z.y, z.y, z.z * z.z));

	z.y = native_cos(psi) * lengthYZ;
	z.z = native_sin(psi) * lengthYZ;
	aux->DE = aux->DE * 2.0f * aux->r;

	REAL4 z2 = z * z;
	REAL rr = z2.x + z2.y + z2.z;
	REAL m = 1.0f - native_divide(z2.z, rr);
	REAL4 temp;
	temp.x = (z2.x - z2.y) * m;
	temp.y = 2.0f * z.x * z.y * m * fractal->transformCommon.scale; // scaling y;;
	temp.z = 2.0f * z.z * native_sqrt(z2.x + z2.y);
	temp.w = z.w;
	z = temp + fractal->transformCommon.additionConstant000;

	if (fractal->transformCommon.addCpixelEnabledFalse)
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
	// if (lengthTempZ > -1e-21f) lengthTempZ = -1e-21f;   //  z is neg.)
	z *= 1.0f + native_divide(fractal->transformCommon.offset, lengthTempZ);
	z *= fractal->transformCommon.scale1;
	/*aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale1), 1.0f);
	// aux->DE *= fabs(fractal->transformCommon.scale1);

	if (fractal->analyticDE.enabledFalse)
	{ // analytic DE adjustment
		aux->DE *= fabs(fractal->transformCommon.scale1) * fractal->analyticDE.scale1;
	}
	else
	{
		aux->DE *= fabs(fractal->transformCommon.scale1);
	}*/
	if (!fractal->analyticDE.enabledFalse)
		aux->DE = mad(aux->DE, fabs(fractal->transformCommon.scale1), 1.0f);
	else
		aux->DE = mad(aux->DE * fabs(fractal->transformCommon.scale1), fractal->analyticDE.scale1,
			fractal->analyticDE.offset1);

	return z;
}