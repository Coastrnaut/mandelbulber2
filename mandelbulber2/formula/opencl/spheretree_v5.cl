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
	REAL t = 0.0f; // temp
	REAL3 tv = (REAL3){0.0f, 0.0f, 0.0f}; // temp vector
	REAL4 oldZ = z;
	REAL col = 0.0f;
	REAL4 ColV = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};

	if (fractal->transformCommon.functionEnabledJFalse)
	{
		aux->DE = 1.0f;
		z = aux->const_c;
	}
	REAL dist_to_sphere = length(z);

	REAL3 p = (REAL3){z.x, z.y, z.z}; // convert to vec3
	if (fractal->transformCommon.functionEnabledDFalse) aux->DE = 1.0f;

	p *= fractal->transformCommon.scaleG1; // master scale
	aux->DE *= fractal->transformCommon.scaleG1;

	REAL3 K3 = tv;

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
			if (fractal->transformCommon.functionEnabledCxFalse) p.x = fabs(p.x) + fractal->transformCommon.offsetA000.x;
			if (fractal->transformCommon.functionEnabledCyFalse) p.y = fabs(p.y) + fractal->transformCommon.offsetA000.y;
			if (fractal->transformCommon.functionEnabledCzFalse) p.z = fabs(p.z) + fractal->transformCommon.offsetA000.z;
		}

		if (recurse == true && c >= fractal->transformCommon.startIterationsC
				&& c < fractal->transformCommon.stopIterationsC)
		{
			p.z += d + bigR;
			// REAL sc = 4.0f * bigR * bigR / dot(p, p);

			REAL inv = 1.0f / dot(p, p);
			K3 += p * aux->DE * inv;
			K3 -= 2.0f * p * dot(K3, p) * inv;
			REAL sc = 4.0f * bigR * bigR * inv;

			p *= sc;
			aux->DE *= sc;
			p.z += -2.0f * bigR;
			p.z = -p.z;
			REAL invSize = (bigR + d) / (2.0f * bigR);
			aux->DE *= invSize;
			p *= invSize;
			recurse = false;
		}
		REAL angle = atan2(p.y, p.x);
		if (angle < 0.0f) angle += M_PI_2x_F;

		angle = fmod(angle, M_PI_2x_F / n); // mmmmmmmmmmmmmmmm??? x - y * trunc (x/y).
		REAL mag = native_sqrt(p.x * p.x + p.y * p.y);
		p.x = mag * native_cos(angle);
		p.y = mag * native_sin(angle);

		REAL3 circle_centre = l * (REAL3){native_cos(ang1), native_sin(ang1), 0.0f};
		tv = p - circle_centre;
		REAL len = length(tv);
		if (len < r)
		{
			ColV.x += 1.0f;
			REAL sc = r * r / (len * len);
			tv *= sc;
			aux->DE *= sc;
		}
		p = tv + circle_centre;

		o2 = bend / 2.0f;
		//	REAL d2 = minr * tan(o2);
		REAL R2 = minr / native_cos(o2);
		//	REAL3 mid_offset = (REAL3) {0.0f, 0.0f, d2};
		tv = p; // - mid_offset * fractal->transformCommon.scaleA1;
		tv.z -= minr * tan(o2) * fractal->transformCommon.scaleA1;
		REAL amp = length(tv);
		//   REAL mag4 = native_sqrt(p[0]*p[0] + p[1]*p[1]);
		if (amp <= R2 - fractal->transformCommon.offsetA0
				&& c >= fractal->transformCommon.startIterationsB
				&& c < fractal->transformCommon.stopIterationsB) // mmmmmmmmmmmmmmmmmmmmmmm // || mag4 <= minr)
		{
			ColV.z += 1.0f;
			t = 1.0f / minr;
			p *= t;
			aux->DE *= t;
			recurse = true;
		}
		else if (length(p) < L4)
		{

			// REAL sc = L4 * L4 / dot(p, p);

			REAL inv = 1.0f / dot(p, p);
			K3 += p * aux->DE * inv;
			K3 -= 2.0f * p * dot(K3, p) * inv;
			REAL sc = L4 * L4 * inv;

			p *= sc;
			aux->DE *= sc;
		}
		if (c >= fractal->transformCommon.startIterationsA
				&& c < fractal->transformCommon.stopIterationsA)
		{
			bend *= fractal->transformCommon.scaleB1;
			bend += fractal->transformCommon.offsetB0;
		}

		// post scale
		p *= fractal->transformCommon.scaleC1;
		aux->DE *= fabs(fractal->transformCommon.scaleC1);

		// DE tweaks
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;



		if (fractal->foldColor.auxColorEnabled && c >= fractal->foldColor.startIterationsA
				&& c < fractal->foldColor.stopIterationsA)
		{
			t = length(p);

			aux->temp1000 = min(aux->temp1000, t);
			ColV.y = aux->temp1000;
			ColV.w  = t;

			col += ColV.x * fractal->foldColor.difs0000.x + ColV.y * fractal->foldColor.difs0000.y
						 + ColV.z * fractal->foldColor.difs0000.z + ColV.w * fractal->foldColor.difs0000.w;
		}
	}

	z = (REAL4){p.x, p.y, p.z, z.w};

	REAL dt = 0.0f;

	if (!fractal->transformCommon.functionEnabledOFalse)
	{
		if (!fractal->transformCommon.functionEnabledEFalse)
			dt = length(z) - fractal->transformCommon.offset0;
		else
			dt = p.z - fractal->transformCommon.offset0;
	}
	else
	{
		bool negate = false;

		REAL den = length(K3);

		REAL radius = bend;

		REAL3 target = (REAL3){0.0f, 0.0f, 0.0f};
		if (den > 1e-13f)
		{
			REAL3 offset = K3 / den;
			offset *= aux->DE; // since K is normalised to the scale
			REAL rad = length(offset);
			offset += p;

			target -= offset;
			REAL mag = length(target);
			if (fabs(radius / mag) > 1.0f) negate = true;
			t = radius / mag;

			REAL3 t1 = target * (1.0f - t);
			REAL3 t2 = target * (1.0f + t);
			t1 *= rad * rad / dot(t1, t1);
			t2 *= rad * rad / dot(t2, t2);
			REAL3 mid = (t1 + t2) / 2.0f;
			tv = t1 - t2;
			radius = length(tv) / 2.0f;
			target = mid + offset;
		}
		tv = p - target;
		REAL dist = length(tv) - radius;

		if (negate) dist = -dist;

		dt = dist;
		// if (fractal->transformCommon.functionEnabledYFalse) dt = max(dist_to_sphere -
		// fractal->transformCommon.radius1, dt);
	}
	if (fractal->transformCommon.functionEnabledDFalse)
	{
		REAL4 zc = z - fractal->transformCommon.offset000;
		if (fractal->transformCommon.functionEnabledFFalse) zc = fabs(zc);
		dt = max(max(zc.x, zc.y), zc.z);
		//d = (d - minr * k) / aux->DE;
	}

	if (fractal->transformCommon.functionEnabledGFalse) dt /= aux->DE;
	if (fractal->transformCommon.functionEnabledCFalse)
	{
		aux->const_c.z += fractal->transformCommon.offsetF0;
		REAL dst1 = length(aux->const_c) - fractal->transformCommon.offsetR1;
		dt = max(dt, dst1);
		// dt = fabs(dt);
	}
	if (fractal->transformCommon.functionEnabledYFalse) dt = max(dist_to_sphere - fractal->transformCommon.radius1, dt); //delete after

	if (!fractal->transformCommon.functionEnabledGFalse) dt /= aux->DE;




	if (!fractal->transformCommon.functionEnabledXFalse)
		aux->dist = min(aux->dist, dt);
	else
		aux->dist = dt;

	if (fractal->analyticDE.enabledFalse) z = oldZ;

	aux->color += col;
	return z;
}
