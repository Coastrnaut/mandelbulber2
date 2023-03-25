/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2022 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Menger Sponge code by Knighty

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_menger3.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 Menger3Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 Offset = fractal->transformCommon.offset111;
	REAL Scale = fractal->transformCommon.scale3;

	z = fabs(z);
	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);

	REAL temp;
	REAL col = 0.0f;
	if (z.x < z.y)
	{
		temp = z.y;
		z.y = z.x;
		z.x = temp;
		col += fractal->foldColor.difs0000.x;
	}
	if (z.x < z.z)
	{
		temp = z.z;
		z.z = z.x;
		z.x = temp;
		col += fractal->foldColor.difs0000.y;
	}
	if (z.y < z.z)
	{
		temp = z.z;
		z.z = z.y;
		z.y = temp;
		col += fractal->foldColor.difs0000.z;
	}
	if (fractal->foldColor.auxColorEnabledFalse && aux->i >= fractal->foldColor.startIterationsA
			&& aux->i < fractal->foldColor.stopIterationsA)
	{
		aux->color += col;
	}

	z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix2, z);

	z.z = fabs(z.z - FRAC_1_3_F * Offset.z) + FRAC_1_3_F * Offset.z;
	z = z * Scale - Offset * (Scale - 1.0f);
	aux->DE = aux->DE * Scale;

	// Analytic DE tweak
	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
	return z;
}