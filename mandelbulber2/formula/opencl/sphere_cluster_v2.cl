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
 * from the file "fractal_sphere_cluster.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 SphereClusterV2Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL t = 0.0f;
	REAL4 oldZ = z;
	REAL3 p = (REAL3){z.x, z.y, z.z}; // convert to vec3
	REAL4 ColV = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
	REAL phi = (1.0f + native_sqrt(5.0f)) / fractal->transformCommon.scale2;
	// Isocahedral geometry
	REAL3 ta0 = (REAL3){0.0f, 1.0f, phi};
	REAL3 ta1 = (REAL3){0.0f, -1.0f, phi};
	REAL3 ta2 = (REAL3){phi, 0.0f, 1.0f};
	REAL3 na0 = cross(ta0, ta1 - ta0);
	na0 = na0 / length(na0);
	REAL3 na1 = cross(ta1, ta2 - ta1);
	na1 = na1 / length(na1);
	REAL3 na2 = cross(ta2, ta0 - ta2);
	na2 = na2 / length(na2);
	REAL mid_to_edgea = atan(phi / (1.0f + 2.0f * phi));
	REAL xxa = 1.0f / native_sin(mid_to_edgea);
	REAL ra = 2.0f / native_sqrt(-4.0f + xxa * xxa);
	REAL la = native_sqrt(1.0f + ra * ra);
	REAL3 mida = (ta0 + ta1 + ta2);
	mida = mida / length(mida);
	REAL minra = (la - ra * fractal->transformCommon.scaleC1) * fractal->transformCommon.scaleA1;

	// Dodecahedral geometry
	REAL3 tb0 = (REAL3){1.0f / phi, 0.0f, phi};
	REAL3 tb1 = (REAL3){1.0f, -1.0f, 1.0f};
	REAL3 tb2 = (REAL3){phi, -1.0f / phi, 0.0f};
	REAL3 tb3 = (REAL3){phi, 1.0f / phi, 0.0f};
	REAL3 tb4 = (REAL3){1.0f, 1.0f, 1.0f};

	REAL3 nb0 = (cross(tb0, tb1 - tb0));
	nb0 = nb0 / length(nb0);
	REAL3 nb1 = (cross(tb1, tb2 - tb1));
	nb1 = nb1 / length(nb1);
	REAL3 nb2 = (cross(tb2, tb3 - tb2));
	nb2 = nb2 / length(nb2);
	REAL3 nb3 = (cross(tb3, tb4 - tb3));
	nb3 = nb3 / length(nb3);
	REAL3 nb4 = (cross(tb4, tb0 - tb4));
	nb4 = nb4 / length(nb4);
	REAL3 dirb = (tb0 + tb1 + tb2 + tb3 + tb4);
	dirb = dirb / length(dirb);
	REAL mid_to_edgeb = atan(dirb.z / dirb.x);
	REAL xxb = 1.0f / native_sin(mid_to_edgeb);
	REAL rb = sqrt(2.0f) / native_sqrt(-2.0f + xxb * xxb);
	REAL lb = native_sqrt(1.0f + rb * rb);
	REAL3 midb = dirb;
	REAL minrb = (lb - rb * fractal->transformCommon.scaleD1) * fractal->transformCommon.scaleB1;

	REAL k = fractal->transformCommon.scale08; // PackRatio;
	REAL excess = fractal->transformCommon.offset105; // adds a skin width

	bool is_b = fractal->transformCommon.functionEnabledDFalse;
	REAL minr = 0.0f;
	REAL l, r;
	REAL3 mid;
	aux->DE = 1.0f; //  // ,,,,,,,,,,,,,,,,,
	int n;
	bool recurse = true;
	for (n = 0; n < fractal->transformCommon.int8X; n++)
	{
		if (fractal->transformCommon.functionEnabledPFalse
				&& n >= fractal->transformCommon.startIterationsP
				&& n < fractal->transformCommon.stopIterationsP1)
		{
			if (fractal->transformCommon.functionEnabledCxFalse) p.x = fabs(p.x) + fractal->transformCommon.offsetA000.x;
			if (fractal->transformCommon.functionEnabledCyFalse) p.y = fabs(p.y) + fractal->transformCommon.offsetA000.y;
			if (fractal->transformCommon.functionEnabledCzFalse) p.z = fabs(p.z) + fractal->transformCommon.offsetA000.z;
			// p += fractal->transformCommon.offsetA000;

		//	if (fractal->transformCommon.functionEnabledTFalse)
		//	{
		//		aux->r = length(z);
		//	}
		}
		bool is = true;
		if (n >= fractal->transformCommon.startIterationsA
				&& n < fractal->transformCommon.stopIterationsA) is = false;
		bool on = true;
		if (n >= fractal->transformCommon.startIterationsB
			&& n < fractal->transformCommon.stopIterationsB) on = false;

		k *= fractal->transformCommon.scale1; // PackRatio;

		if (recurse && n >= fractal->transformCommon.startIterationsC
				&& n < fractal->transformCommon.stopIterationsC)
		{
			if (length(p) > excess)
			{
				break;
				// p = (REAL3){0.0f, 0.0f, 1e-15f};
			}
			//if (is_b)
			if (is == true)
			{
				minr = minrb;
			}
			else
			{
				minr = minra;
			}
			if (on == false)
			{
				REAL sc = minr / dot(p, p);
				p *= sc;
				aux->DE *= sc;

				recurse = false;
				ColV.z += 1.0f;
			}
		}
		//if (is_b)
		if (is == true)
		{
			l = lb;
			r = rb;
			mid = midb;
			minr = minrb;
			if (dot(p, nb0) < 0.0f) p -= 2.0f * nb0 * dot(p, nb0);
			if (dot(p, nb1) < 0.0f) p -= 2.0f * nb1 * dot(p, nb1);
			if (dot(p, nb2) < 0.0f) p -= 2.0f * nb2 * dot(p, nb2);
			if (dot(p, nb3) < 0.0f) p -= 2.0f * nb3 * dot(p, nb3);
			if (dot(p, nb4) < 0.0f) p -= 2.0f * nb4 * dot(p, nb4);

			if (dot(p, nb0) < 0.0f) p -= 2.0f * nb0 * dot(p, nb0);
			if (dot(p, nb1) < 0.0f) p -= 2.0f * nb1 * dot(p, nb1);
			if (dot(p, nb2) < 0.0f) p -= 2.0f * nb2 * dot(p, nb2);
			if (dot(p, nb3) < 0.0f) p -= 2.0f * nb3 * dot(p, nb3);
			if (dot(p, nb4) < 0.0f) p -= 2.0f * nb4 * dot(p, nb4);
		}
		else
		{
			l = la;
			r = ra;
			mid = mida;
			minr = minra;
			if (dot(p, na0) < 0.0f) p -= 2.0f * na0 * dot(p, na0);
			if (dot(p, na1) < 0.0f) p -= 2.0f * na1 * dot(p, na1);
			if (dot(p, na2) < 0.0f) p -= 2.0f * na2 * dot(p, na2);

			if (dot(p, na0) < 0.0f) p -= 2.0f * na0 * dot(p, na0);
			if (dot(p, na1) < 0.0f) p -= 2.0f * na1 * dot(p, na1);
			if (dot(p, na2) < 0.0f) p -= 2.0f * na2 * dot(p, na2);

			if (dot(p, na0) < 0.0f) p -= 2.0f * na0 * dot(p, na0);
			if (dot(p, na1) < 0.0f) p -= 2.0f * na1 * dot(p, na1);
			if (dot(p, na2) < 0.0f) p -= 2.0f * na2 * dot(p, na2);
		}

		REAL3 tv = p - mid * l;
		REAL dist = length(tv);
		if (dist < r || n == fractal->transformCommon.int8X - 1)
		{
			ColV.x += 1.0f;
			p -= mid * l;
			REAL sc = r * r / dot(p, p);
			p *= sc;
			aux->DE *= sc;
			p += mid * l;

			REAL m = minr * k;
			if ((length(p) < minr) && (on == false))
			{
				ColV.y += 1.0f;
				p /= m;
				aux->DE /= m;

				recurse = true;
			}
		}

		if (on == true)
		{
			p /= minr * k;
			aux->DE /= minr * k;
		}



		// post scale
		p *= fractal->transformCommon.scaleF1;
		aux->DE *= fabs(fractal->transformCommon.scaleF1);
		// DE tweaks
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

		if (fractal->foldColor.auxColorEnabled && n >= fractal->foldColor.startIterationsA
				&& n < fractal->foldColor.stopIterationsA)
		{
			t += ColV.y * fractal->foldColor.difs0000.y + ColV.z * fractal->foldColor.difs0000.z;
			if (fractal->foldColor.difs1 > dist) t += fractal->foldColor.difs0000.w;
		}
	}

	z = (REAL4){p.x, p.y, p.z, z.w};

	REAL d;
	if (!fractal->transformCommon.functionEnabledSwFalse)
	{
		if (!fractal->transformCommon.functionEnabledEFalse)
			d = k;
		else
			d = min(1.0f, k);
		d = (length(z) - minr * fractal->transformCommon.scaleE1 * d) / aux->DE;
	}
	else
	{
		REAL4 zc = z - fractal->transformCommon.offset000;
		d = max(max(zc.x, zc.y), zc.z);
		d = (d - minr * k) / aux->DE;
	}

	if (fractal->transformCommon.functionEnabledCFalse)
	{
		REAL dst1 = length(aux->const_c) - fractal->transformCommon.offsetR1;
		d = max(d, dst1);
	}

	if (!fractal->transformCommon.functionEnabledXFalse)
		aux->dist = min(aux->dist, d);
	else
		aux->dist = d;

	if (fractal->analyticDE.enabledFalse) z = oldZ;

	// if (d > length(p) * fractal->foldColor.difs0000.w) ColV.w = 1.0f;

	// aux->color
	aux->color = t;
	return z;
}
