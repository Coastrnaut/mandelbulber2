/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * mandelbulbPow2V3 reference trafassel
 * https://fractalforums.org/fractal-mathematics-and-new-theories/28/fake-3d-mandelbrot-set/1787/msg17956#msg17956

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_mandelbulb_pow2_v3.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MandelbulbPow2V3Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{
		if (fractal->transformCommon.functionEnabledBxFalse)
			z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
						- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
		if (fractal->transformCommon.functionEnabledByFalse)
			z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
						- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
		if (fractal->transformCommon.functionEnabledBzFalse)
			z.z = fabs(z.z + fractal->transformCommon.additionConstant111.z)
						- fabs(z.z - fractal->transformCommon.additionConstant111.z) - z.z;
	}

	if (fractal->transformCommon.functionEnabledAFalse
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledAyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledAzFalse) z.z = fabs(z.z);
	}

	z *= fractal->transformCommon.scaleA1;
	aux->DE *= fabs(fractal->transformCommon.scaleA1);

	aux->DE = aux->DE * 2.0f * length(z) + 1.0f;
	REAL rr = z.x * z.x + z.y * z.y;
	REAL theta = atan2(z.z, native_sqrt(rr));
	rr += z.z * z.z;
	REAL phi = atan2(z.y, z.x);
	REAL thetatemp = theta;

	REAL phi_pow = 2.0f * phi + M_PI_F;
	REAL theta_pow = theta + M_PI_F + M_PI_2_F;

	if (fractal->transformCommon.functionEnabledBFalse) theta_pow = theta + thetatemp + M_PI_4_F;

	if (fractal->transformCommon.functionEnabledCFalse) theta_pow = theta + thetatemp + M_PI_2_F;

	if (fractal->transformCommon.functionEnabledDFalse) theta_pow = theta + thetatemp + M_PI_F;

	REAL rn_sin_theta_pow = rr * native_sin(theta_pow);
	z.x = rn_sin_theta_pow * native_cos(phi_pow);
	z.y = rn_sin_theta_pow * native_sin(phi_pow);
	z.z = rr * native_cos(theta_pow) * fractal->transformCommon.scale1; // ,

	z += fractal->transformCommon.offset000;

	if (fractal->transformCommon.rotation2EnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}

	// DE tweak
	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
	return z;
}
