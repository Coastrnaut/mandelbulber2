/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2023 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * formula by TGlad,
 * https://fractalforums.org/fractal-mathematics-and-new-theories/28/fractal-clusters/5107

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_menger_v7.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MengerV7Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL t = 0.0f;
	REAL4 tV = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
	REAL4 oldZ = z;
	REAL col = 0.0f;
	REAL d;
	REAL scale = fractal->transformCommon.scale3;
	REAL4 ColV = tV;

	z *= fractal->transformCommon.scale015; // master scale
	aux->DE *= fractal->transformCommon.scale015;

//	REAL min_dist = 100000.0f;
	for (int n = 0; n < fractal->transformCommon.int8X; n++)
	{
		z = fabs(z);

		if (fractal->transformCommon.functionEnabledPFalse
				&& n >= fractal->transformCommon.startIterationsP
				&& n < fractal->transformCommon.stopIterationsP1)
		{
			z += fractal->transformCommon.offset000;
		}
		// rotation
		if (n >= fractal->transformCommon.startIterationsR
				&& n < fractal->transformCommon.stopIterationsR)
		{
			z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
		}

		if (z.y > z.x)
		{
			t = z.x;
			z.x = z.y;
			z.y = t;
		}

		if (z.z > z.x)
		{
			t = z.x;
			z.x = z.z;
			z.z = t;
		}

		if (fractal->transformCommon.functionEnabled
				&& n >= fractal->transformCommon.startIterations
				&& n < fractal->transformCommon.stopIterations
				&& z.z > z.y)
		{
			t = z.y;
			z.y = z.z;
			z.z = t;
		}

		tV = fractal->transformCommon.offsetA111; // mmmmmmmmmmmmm
		if (fractal->transformCommon.functionEnabledAFalse
				&& n >= fractal->transformCommon.startIterationsA
				&& n < fractal->transformCommon.stopIterationsA)
		{
			tV = fractal->transformCommon.offsetA000;
		}
		REAL4  p1 = z - tV;

		tV = fractal->transformCommon.offset101;
		if (fractal->transformCommon.functionEnabledEFalse
				&& n >= fractal->transformCommon.startIterationsE
				&& n < fractal->transformCommon.stopIterationsE)
		{
			tV = fractal->transformCommon.offsetA200;
		}
		REAL4 p2 = z - tV;

		tV = fractal->transformCommon.offset110;
		if (fractal->transformCommon.functionEnabledDFalse
				&& n >= fractal->transformCommon.startIterationsD
				&& n < fractal->transformCommon.stopIterationsD)
		{
			tV = fractal->transformCommon.offsetF000;
		}
		REAL4 p3 = z - tV;

		REAL4 p4 = z; //- (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
				if (fractal->transformCommon.functionEnabledFFalse
				&& n >= fractal->transformCommon.startIterationsF
				&& n < fractal->transformCommon.stopIterationsF)
		{
			p4 = z - fractal->transformCommon.offset200;
		}

		if (fractal->transformCommon.functionEnabledIFalse
				&& n >= fractal->transformCommon.startIterationsI
				&& n < fractal->transformCommon.stopIterationsI)
		{
			if (z.x <= 1.5f)
			{
				// f = (p.x - 1.5f) / aux->DE;
				// on = true;
				break;
			}
		}

		REAL d1, d2, d3, d4;
		d1 = dot(p1, p1);
		d2 = dot(p2, p2);
		d3 = dot(p3, p3);
		d4 = dot(p4, p4);

		if (d1 < d2 && d1 < d3 && d1 < d4)
		{
			z = p1;
			ColV.x = 1.0f;
		}
		else if (d2 < d1 && d2 < d3 && d2 < d4)
		{
			z = p2;
			ColV.y = 1.0f;
		}
		else if (d3 < d1 && d3 < d2 && d3 < d4)
		{
			z = p3;
			ColV.z = 1.0f;
		}
		else if(fractal->transformCommon.functionEnabledGFalse
				&& n >= fractal->transformCommon.startIterationsG
				&& n < fractal->transformCommon.stopIterationsG)
		{
			z = p4;
			ColV.w = 1.0f;

		}
		else if(fractal->transformCommon.functionEnabledJFalse
				&& n >= fractal->transformCommon.startIterationsJ
				&& n < fractal->transformCommon.stopIterationsJ)
		{
			z = p4;
			ColV.w = 1.0f;

			{
				z *= scale;
				aux->DE *= scale;
				break;
			}
		}

		if (n >= fractal->transformCommon.startIterationsT
				&& n < fractal->transformCommon.stopIterationsT)
		{
			z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix2, z);
		}
	//	z.z = fabs(z.z - FRAC_1_3_F * 1.) + FRAC_1_3_F * Offset.z;
	//	z = z * Scale - Offset * (Scale - 1.0f);
	//	aux->DE = aux->DE * Scale;

	//	z.z = fabs(z.z - FRAC_1_3_F * 1.) + FRAC_1_3_F * 1.;

	//	z = z * scale - 1. * (scale - 1.0f);
		z *= scale;
		aux->DE *= scale;

		// DE tweaks
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

		if (fractal->foldColor.auxColorEnabled && n >= fractal->foldColor.startIterationsA
				&& n < fractal->foldColor.stopIterationsA)
		{
			col += ColV.x * fractal->foldColor.difs0000.x + ColV.y * fractal->foldColor.difs0000.y
						 + ColV.z * fractal->foldColor.difs0000.z + ColV.w * fractal->foldColor.difs0000.w;
			//	if (fractal->foldColor.difs1 > dist) col += fractal->foldColor.difs0000.w;
		}
	}

	if (!fractal->transformCommon.functionEnabledOFalse)
	{
		if (!fractal->transformCommon.functionEnabledSwFalse)
		{
			d = max(fabs(z.x), max(fabs(z.y), fabs(z.z))) - fractal->transformCommon.offset0;
		}
		else
		{
			d = length(z) - fractal->transformCommon.offset0;
		}
	}
	else
	{
		double r = length(z) - fractal->transformCommon.offsetA0;
		double m = (max(fabs(z.x), max(fabs(z.y), fabs(z.z)))) - fractal->transformCommon.offsetB0;
		d = r + (m - r) * fractal->transformCommon.scale0;
	}

	d = d * fractal->transformCommon.scaleB1 / aux->DE;

	if (fractal->transformCommon.functionEnabledYFalse)
	{
		REAL dst1 = length(aux->const_c) - fractal->transformCommon.offsetR1;
		d = max(d, dst1);
		d = fabs(d);
	}

	if (!fractal->transformCommon.functionEnabledXFalse)
		aux->dist = min(aux->dist, d);
	else
		aux->dist = d;

	if (fractal->analyticDE.enabledFalse) z = oldZ;


	if (!fractal->foldColor.auxColorEnabledFalse) aux->color = col;
	else aux->color += col;

	return z;
}
