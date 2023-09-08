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
 * from the file "fractal_spheretree_v2.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 SpheretreeV2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	if (fractal->transformCommon.functionEnabledCFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		REAL4 signs = z;
		signs.x = sign(z.x);
		signs.y = sign(z.y);
		signs.z = sign(z.z);
		signs.w = sign(z.w);

		z = fabs(z);
		REAL4 tt = fractal->transformCommon.offsetA000;
		z -= tt;

		REAL m = 1.0f;
		REAL rr = dot(z, z);
		if (rr < fractal->transformCommon.invert0)
			m = fractal->transformCommon.inv0;
		else if (rr < fractal->transformCommon.invert1)
			m = 1.0f / rr;
		else
			m = fractal->transformCommon.inv1;

		z += tt;
		z *= m;
		aux->DE *= m;

		z *= signs;
		z += fractal->transformCommon.additionConstant000 * signs;
	}

	REAL Dd;
	if (!fractal->transformCommon.functionEnabledByFalse)
		Dd = 1.0f;
	else
		Dd = aux->DE;

	REAL4 oldZ = z;
	REAL4 ColV = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};

	REAL t = fractal->transformCommon.minR06;
	REAL4 t1 = (REAL4){SQRT_3_4_F, -0.5f, 0.0f, 0.0f};
	REAL4 t2 = (REAL4){-SQRT_3_4_F, -0.5f, 0.0f, 0.0f};

	REAL4 n1 = (REAL4){-0.5f, -SQRT_3_4_F, 0.0f, 0.0f};
	REAL4 n2 = (REAL4){-0.5f, SQRT_3_4_F, 0.0f, 0.0f};

	REAL scl = fractal->transformCommon.functionEnabledwFalse ? SQRT_3_F : 1.0f;
	REAL k = fractal->transformCommon.scaleA1;
	REAL kk = k * k;
	REAL innerScale = k * scl / (kk + scl);
	REAL innerScaleB = innerScale * innerScale * 0.25f;
	REAL shift = (kk + scl) / (k * (1.0f + scl));
	//	REAL mid = 0.5f * (k + 1.0f) / 2.0f;
	REAL mid = 0.25f * (k + 1.0f);
	// (k + 1.0f) * .25f mmmmmmmmmmmmmmmmmmmmmmmmmmmm
	REAL bufferRad = t * k;

	for (int n = 0; n < fractal->transformCommon.int8X; n++)
	{
		if (!fractal->transformCommon.functionEnabledBxFalse)
		{
			REAL4 zB = z - (REAL4){0.0f, 0.0f, innerScale * 0.5f, 0.0f};
			if (dot(zB, zB) < innerScaleB) break; // definitely inside
		}

		REAL maxH = 0.4f * fractal->transformCommon.scaleG1;
		if (n == 0) maxH = -100.0f;

		REAL4 zC = z - (REAL4){0.0f, 0.0f, bufferRad, 0.0f};
		if (z.z > maxH && dot(zC, zC) > bufferRad * bufferRad) break; // definitely outside

		REAL4 zD = z - (REAL4){0.0f, 0.0f, mid, 0.0f};
		REAL invSC = fractal->transformCommon.scaleF1 / dot(z, z);
		// REAL invSC = 1.0f / dot(z, z) * fractal->transformCommon.scaleF1; // mmmmmmmmmmmmmmmmmmmmmmm
		if (z.z < maxH && dot(zD, zD) > mid * mid)
		{
			// needs a sphere inverse
			Dd *= invSC;
			z *= invSC;
			ColV.x += 1.0f;
		}
		else
		{
			// stretch onto a plane at zero
			ColV.y += 1.0f;
			Dd *= invSC;
			z *= invSC;
			z.z -= shift;
			z.z *= -1.0f;
			z *= scl;
			Dd *= scl;
			z.z += shift;

			// and rotate it a twelfth of a revolution
			if (fractal->transformCommon.functionEnabledwFalse)
			{
				REAL a = M_PI_F / fractal->transformCommon.scale6;
				REAL cosA = native_cos(a);
				REAL sinA = native_sin(a);
				REAL xx = z.x * cosA + z.y * sinA;
				REAL yy = -z.x * sinA + z.y * cosA;
				z.x = xx;
				z.y = yy;
			}
		}

		// now modolu the space so we move to being in just the central hexagon, inner radius 0.5f
		REAL h = z.z * fractal->transformCommon.scaleE1;
		z *= fractal->transformCommon.scaleC1;
		Dd *= fractal->transformCommon.scaleC1;

		REAL x = dot(z, -1.0f * n2) * fractal->transformCommon.scaleA2 / SQRT_3_F;
		REAL y = dot(z, -1.0f * n1) * fractal->transformCommon.scaleA2 / SQRT_3_F;
		x = x - floor(x);
		y = y - floor(y);

		if (x + y > 1.0f)
		{
			x = 1.0f - x;
			y = 1.0f - y;
			ColV.z += 1.0f;
		}

		z = x * t1 - y * t2;
		// fold the space to be in a kite
		REAL l0 = dot(z, z);
		REAL4 zt1 = z - t1;
		REAL4 zt2 = z + t2;
		REAL l1 = dot(zt1, zt1);
		REAL l2 = dot(zt2, zt2);

		if (l1 < l0 && l1 < l2)
		{
			z -= t1 * (2.0f * dot(z, t1) - 1.0f);
		}

		else if (l2 < l0 && l2 < l1)
		{
			z -= t2 * (2.0f * dot(z, t2) + 1.0f);
		}
		z.z = h;
		z *= fractal->transformCommon.scaleD1;
		Dd *= fractal->transformCommon.scaleD1;
		z += fractal->transformCommon.offset000;

		aux->temp1000 = min(aux->temp1000, dot(z, z));
	}
	// aux->DE
	aux->DE = Dd;

	REAL4 len = z - (REAL4){0.0f, 0.0f, 0.5f * k, 0.0f};
	REAL d = (length(len) - 0.5f * k);
	ColV.w = d;
	d /= fractal->analyticDE.scale1 * 2.0f * aux->DE;

	if (!fractal->transformCommon.functionEnabledXFalse)
		aux->dist = min(aux->dist, d);
	else
		aux->dist = d;

	if (fractal->analyticDE.enabledFalse) z = oldZ;

	// aux->color
	if (fractal->foldColor.auxColorEnabled)
	{
		REAL colorAdd = 0.0f;
		colorAdd += colorAdd * fractal->foldColor.difs1;
		colorAdd += ColV.x * fractal->foldColor.difs0000.x;
		colorAdd += ColV.y * fractal->foldColor.difs0000.y;
		colorAdd += aux->temp1000 * fractal->foldColor.difs0000.z;
		colorAdd += ColV.w * fractal->foldColor.difs0000.w;

		aux->color += colorAdd;
	}
	return z;
}