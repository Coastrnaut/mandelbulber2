/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2023 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * formula by TGlad,
 * https://https://fractalforums.org/fractal-mathematics-and-new-theories/28/sphere-inversion-trees/5113

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_spheretree_v5.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 SpheretreeV5Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL t = 0.0f;												// temp
	REAL4 tv = (REAL4){0.0f, 0.0f, 0.0f, 0.0f}; // temp vector
	REAL4 oldZ = z;
	REAL col = 0.0f;
	REAL4 ColV = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};

	if (fractal->transformCommon.functionEnabledJFalse)
	{
		aux->DE = 1.0f;
		z = aux->const_c;
	}

	z *= fractal->transformCommon.scaleG1; // master scale
	aux->DE *= fractal->transformCommon.scaleG1;

	REAL4 K3 = tv;

	int NumChildren = fractal->transformCommon.int8X;
	int n = NumChildren;
	REAL ang1 = M_PI_F / n;

	REAL o1 = 3.0f;
	if (NumChildren <= 4)
		o1 = 5.0f;
	else if (NumChildren <= 6)
		o1 = 4.0f;
	REAL sec = 1.0f / native_cos(M_PI_F / o1);
	REAL csc = 1.0f / native_sin(M_PI_F / n);
	REAL r = sec / native_sqrt(csc * csc - sec * sec);
	REAL l = native_sqrt(1.0f + r * r);

	REAL o2 = fractal->transformCommon.offset3;
	t = native_sin(M_PI_F - M_PI_F / o2);
	REAL theta = asin(r * t / l);
	REAL L4 = l * native_sin(M_PI_F / o2 - theta) / t;
	REAL minr = L4 * L4 * fractal->transformCommon.scaleD1;
	REAL bend = fractal->transformCommon.scale08;
	REAL omega = 0.0f;
	REAL bigR = 0.0f;
	REAL d = 0.0f;

	if (!fractal->transformCommon.functionEnabledzFalse)
	{
		omega = M_PI_2 - bend;
		bigR = 1.0f / native_cos(omega);
		d = tan(omega);
	}
	// iteration loop
	bool recurse = true;
	if (fractal->transformCommon.functionEnabledFalse) recurse = false;
	for (int c = 0; c < fractal->transformCommon.int16; c++)
	{
		if (fractal->transformCommon.functionEnabledzFalse)
		{
			omega = M_PI_2 - bend;
			bigR = 1.0f / native_cos(omega);
			d = tan(omega);
		}

		if (fractal->transformCommon.functionEnabledPFalse
				&& c >= fractal->transformCommon.startIterationsP
				&& c < fractal->transformCommon.stopIterationsP1)
		{
			if (fractal->transformCommon.functionEnabledCxFalse)
				z.x = fabs(z.x) + fractal->transformCommon.offsetA000.x;
			if (fractal->transformCommon.functionEnabledCyFalse)
				z.y = fabs(z.y) + fractal->transformCommon.offsetA000.y;
			if (fractal->transformCommon.functionEnabledCzFalse)
				z.z = fabs(z.z) + fractal->transformCommon.offsetA000.z;
		}

		if (recurse == true && c >= fractal->transformCommon.startIterationsC
				&& c < fractal->transformCommon.stopIterationsC)
		{
			z.z += d + bigR;
			REAL inv = 1.0f / dot(z, z);
			K3 += z * aux->DE * inv;
			K3 -= 2.0f * z * dot(K3, z) * inv;
			REAL sc = 4.0f * bigR * bigR * inv;

			z *= sc;
			aux->DE *= sc;
			z.z += -2.0f * bigR;
			z.z = -z.z;
			REAL invSize = (bigR + d) / (2.0f * bigR);
			aux->DE *= invSize;
			z *= invSize;
			recurse = false;
		}
		REAL angle = atan2(z.y, z.x);
		if (angle < 0.0f) angle += M_PI_2x_F;

		angle = fmod(angle, M_PI_2x_F / n);
		REAL mag = native_sqrt(z.x * z.x + z.y * z.y);
		z.x = mag * native_cos(angle);
		z.y = mag * native_sin(angle);

		REAL4 circle_centre = l * (REAL4){native_cos(ang1), native_sin(ang1), 0.0f, 0.0f};
		tv = z - circle_centre;
		REAL len = length(tv);
		if (len < r)
		{
			ColV.x += 1.0f;
			REAL sc = r * r / (len * len);
			tv *= sc;
			aux->DE *= sc;
		}
		z = tv + circle_centre;

		o2 = bend / 2.0f;
		//	REAL d2 = minr * tan(o2);
		REAL R2 = minr / native_cos(o2);
		//	REAL3 mid_offset = (REAL3) {0.0f, 0.0f, d2};
		tv = z; // - mid_offset * fractal->transformCommon.scaleA1;
		tv.z -= minr * tan(o2) * fractal->transformCommon.scaleA1;
		REAL amp = length(tv);
		//   REAL mag4 = native_sqrt(p[0]*p[0] + p[1]*p[1]);
		if (amp <= R2 - fractal->transformCommon.offsetA0
				&& c >= fractal->transformCommon.startIterationsB
				&& c < fractal->transformCommon
								 .stopIterationsB) // || mag4 <= minr)
		{
			ColV.z += 1.0f;
			t = 1.0f / minr;
			z *= t;
			aux->DE *= t;
			recurse = true;
		}
		else if (length(z) < L4)
		{
			REAL inv = 1.0f / dot(z, z);
			K3 += z * aux->DE * inv;
			K3 -= 2.0f * z * dot(K3, z) * inv;
			REAL sc = L4 * L4 * inv;

			z *= sc;
			aux->DE *= sc;
		}
		if (c >= fractal->transformCommon.startIterationsA
				&& c < fractal->transformCommon.stopIterationsA)
		{
			bend *= fractal->transformCommon.scaleB1;
			bend += fractal->transformCommon.offsetB0;
		}

		// post scale
		z *= fractal->transformCommon.scaleC1;
		aux->DE *= fabs(fractal->transformCommon.scaleC1);

		// DE tweaks
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

		if (fractal->foldColor.auxColorEnabled && c >= fractal->foldColor.startIterationsA
				&& c < fractal->foldColor.stopIterationsA)
		{
			t = length(z);
			aux->temp1000 = min(aux->temp1000, t);
			ColV.y = aux->temp1000;
			ColV.w = t;

			col += ColV.x * fractal->foldColor.difs0000.x + ColV.y * fractal->foldColor.difs0000.y
						 + ColV.z * fractal->foldColor.difs0000.z + ColV.w * fractal->foldColor.difs0000.w;
		}
	}

	REAL dt = 0.0f;
	if (!fractal->transformCommon.functionEnabledDFalse)
	{
		if (!fractal->transformCommon.functionEnabledOFalse)
		{
			if (!fractal->transformCommon.functionEnabledEFalse)
				dt = length(z);
			else
				dt = z.z + (length(z) - z.z) * fractal->transformCommon.scaleC0;
		}
		else
		{
			bool negate = false;
			REAL den = length(K3);
	//		REAL radius = bend;
			REAL radius = bend + (length(z)- bend) * fractal->transformCommon.scaleB0;
			REAL4 target = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
			if (den > 1e-13f)
			{
				REAL4 offset = K3 / den;
				offset *= aux->DE; // since K is normalised to the scale
				REAL rad = length(offset);
				offset += z;

				target -= offset;
				REAL mag = length(target);
				if ((radius / mag) > 1.0f) negate = true;
				t = radius / mag;

				REAL4 t1 = target * (1.0f - t);
				REAL4 t2 = target * (1.0f + t);
				t1 *= rad * rad / dot(t1, t1);
				t2 *= rad * rad / dot(t2, t2);
				REAL4 mid = (t1 + t2) / 2.0f;
				tv = t1 - t2;
				radius = length(tv) / 2.0f;
				target = mid + offset;
			}
			tv = z - target;
			REAL dist = length(tv) - radius;

			if (negate) dist = -dist;

			dt = dist + 1.0f; // mmmmmmmmmm
		}
	}
	else
	{
		REAL4 zc = z - fractal->transformCommon.offset000;
		if (!fractal->transformCommon.functionEnabledFFalse) zc = fabs(zc);
		dt = max(max(zc.x, zc.y), zc.z);
	}

	dt -= fractal->transformCommon.offset0;

	if (!fractal->transformCommon.functionEnabledGFalse) dt /= aux->DE;
	if (fractal->transformCommon.functionEnabledCFalse) // clip
	{
		aux->const_c.z += fractal->transformCommon.offsetF0;
		REAL dst1 = length(aux->const_c) - fractal->transformCommon.offsetR1;
		dt = max(dt, dst1);
		// dt = fabs(dt);
		if (fractal->transformCommon.functionEnabledGFalse) dt /= aux->DE;
	}

	if (!fractal->transformCommon.functionEnabledXFalse)
		aux->dist = min(aux->dist, dt);
	else
		aux->dist = dt;

	if (fractal->analyticDE.enabledFalse) z = oldZ;

	if (!fractal->transformCommon.functionEnabledKFalse)
		aux->color += col;
	else
		aux->color = col;
	return z;
}
