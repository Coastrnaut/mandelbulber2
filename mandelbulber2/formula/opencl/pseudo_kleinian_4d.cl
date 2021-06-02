/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * formula by TGlad, extras by sabine62
 * https://fractalforums.org/fractal-mathematics-and-new-theories/28/new-sphere-tree/3557/msg22100#msg22100

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_testing_log.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 PseudoKleinian4dIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL colorAdd = 0.0f;

	// sphere inversion
	if (fractal->transformCommon.sphereInversionEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsX
			&& aux->i < fractal->transformCommon.stopIterations1)
	{
		z += fractal->transformCommon.offset0000;
		REAL rr = dot(z, z);
		z *= fractal->transformCommon.scaleG1 / rr;
		aux->DE *= (fractal->transformCommon.scaleG1 / rr);
		z += fractal->transformCommon.offsetA0000 - fractal->transformCommon.offset0000;
		z *= fractal->transformCommon.scaleA1;
		aux->DE *= fractal->transformCommon.scaleA1;
	}

	if (fractal->transformCommon.functionEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsD1)
	{
		if (fractal->transformCommon.functionEnabledAFalse)
		{
			z = (REAL4){z.x, z.y, z.z, length(z)};
			aux->DE += 0.5f;
		}
		if (fractal->transformCommon.functionEnabledBFalse)
		{
			z = (REAL4){z.x + z.y + z.z, -z.x - z.y + z.z, -z.x + z.y - z.z, z.x - z.y - z.z};
			aux->DE *= length(z) / aux->r;
		}
		// z = fabs(z - fractal->transformCommon.offsetA0000);
	}

	// box offset
	if (aux->i >= fractal->transformCommon.startIterationsM
			&& aux->i < fractal->transformCommon.stopIterationsM)
	{
		z.x -= fractal->transformCommon.scale0000.x * sign(z.x);
		z.y -= fractal->transformCommon.scale0000.y * sign(z.y);
		z.z -= fractal->transformCommon.scale0000.z * sign(z.z);
		z.w -= fractal->transformCommon.scale0000.w * sign(z.w);
	}

	REAL k = 0.0f;
	// Pseudo kleinian
	REAL4 cSize = fractal->transformCommon.offset1111;
	if (fractal->transformCommon.functionEnabledAy
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		z = fabs(z + cSize) - fabs(z - cSize) - z;
		k = max(fractal->transformCommon.scale015 / dot(z, z), 1.0f);
		z *= k;
		aux->DE *= k + fractal->analyticDE.tweak005;
	}
	aux->pseudoKleinianDE = fractal->analyticDE.scale1;
	// z += fractal->transformCommon.additionConstant0000; // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

	if (fractal->transformCommon.functionEnabledGFalse
			&& aux->i >= fractal->transformCommon.startIterationsG
			&& aux->i < fractal->transformCommon.stopIterationsG)
	{
		z.x += aux->pos_neg * fractal->transformCommon.additionConstant0000.x;
		z.y += aux->pos_neg * fractal->transformCommon.additionConstant0000.y;
		z.z += aux->pos_neg * fractal->transformCommon.additionConstant0000.z;
		z.w += aux->pos_neg * fractal->transformCommon.additionConstant0000.w;
		aux->pos_neg *= fractal->transformCommon.scaleNeg1;
	}

	if (fractal->transformCommon.functionEnabledFFalse
			&& aux->i >= fractal->transformCommon.startIterationsF
			&& aux->i < fractal->transformCommon.stopIterationsF)
	{
		z = fabs(z + fractal->transformCommon.offsetB1111)
				- fabs(z - fractal->transformCommon.offsetB1111) - z;
	}


	REAL4 zz = z * z;
	// REAL d1 = native_sqrt(min(min(zz.x + zz.y, zz.y + zz.z), zz.z + zz.x));
	REAL d1 = native_sqrt(min(min(min(zz.x + zz.y, zz.y + zz.z), zz.z + zz.w), zz.w + zz.x));
	if (fractal->transformCommon.functionEnabledKFalse) d1 = native_sqrt(zz.x + zz.y + zz.w);
	d1 -= fractal->transformCommon.offsetR0;

	REAL d2 = fabs(z.z);
	aux->DE0 = d2;
	if (d1 < d2) aux->DE0 = d1;

	aux->DE0 = 0.5f * (aux->DE0 - fractal->transformCommon.offset0) / aux->DE;

	if (fractal->transformCommon.functionEnabledDFalse) aux->DE0 = min(aux->dist, aux->DE0);

	aux->dist = aux->DE0;

	// color
	if (fractal->foldColor.auxColorEnabledFalse)
	{
		if (aux->i >= fractal->foldColor.startIterationsA
				&& aux->i < fractal->foldColor.stopIterationsA)
		{
			colorAdd += fractal->foldColor.difs0000.x * fabs(z.x);
			colorAdd += fractal->foldColor.difs0000.y * fabs(z.y);
			colorAdd += fractal->foldColor.difs0000.z * fabs(z.z);
			colorAdd += fractal->foldColor.difs0000.w * fabs(z.w);
		}
		aux->color += colorAdd;
	}
	return z;
}
