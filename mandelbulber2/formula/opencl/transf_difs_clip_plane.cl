/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2021 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * fragmentarium code, by knighty

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_difs_clip_plane.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfDIFSClipPlaneIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;
	REAL4 zc;
	REAL temp;
	if (!fractal->transformCommon.functionEnabledDFalse)
		zc = c;
	else
		zc = z;

	// polyfold
	if (fractal->transformCommon.functionEnabledPFalse
			&& aux->i >= fractal->transformCommon.startIterationsP
			&& aux->i < fractal->transformCommon.stopIterationsP1)
	{
		zc.y = fabs(z.y);
		REAL psi = M_PI_F / fractal->transformCommon.int6;
		psi = fabs(fmod(atan2(zc.y, zc.x) + psi, 2.0f * psi) - psi);
		REAL len = native_sqrt(zc.x * zc.x + zc.y * zc.y);
		zc.x = native_cos(psi) * len;
		zc.y = native_sin(psi) * len;
	}

	if (fractal->transformCommon.functionEnabledTFalse
			&& aux->i >= fractal->transformCommon.startIterationsT
			&& aux->i < fractal->transformCommon.stopIterationsT1)
	{
		zc.x -= round(zc.x / fractal->transformCommon.offset2) * fractal->transformCommon.offset2;
		zc.y -= round(zc.y / fractal->transformCommon.offsetA2) * fractal->transformCommon.offsetA2;
	}

	if (fractal->transformCommon.functionEnabledIFalse)
	{
		REAL angle = M_PI_2x_F / (fractal->transformCommon.int16);
		REAL sector = round(atan2(zc.x, zc.y) / angle);
		REAL an = sector * angle;
		REAL sinan = native_sin(an);
		REAL cosan = native_cos(an);
		temp = zc.x;
		zc.x = zc.x * cosan - zc.y * sinan;
		zc.y = temp * sinan + zc.y * cosan;
	}

	zc += fractal->transformCommon.offset000;

	if (fractal->transformCommon.functionEnabledAFalse)
	{
		if (fractal->transformCommon.functionEnabledAxFalse) zc.x = fabs(zc.x);
		if (fractal->transformCommon.functionEnabledAyFalse) zc.y = fabs(zc.y);
		if (fractal->transformCommon.functionEnabledAzFalse) zc.z = fabs(zc.z);
		if (fractal->transformCommon.functionEnabledMFalse) zc.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledNFalse) zc.y = fabs(z.y);
		zc.x -= fractal->transformCommon.offsetA000.x;
		zc.y -= fractal->transformCommon.offsetA000.y;
	}

	// scales
	zc.x *= fractal->transformCommon.scale3D111.x;
	zc.y *= fractal->transformCommon.scale3D111.y;
	zc.z *= fractal->transformCommon.scale3D111.z;

	if (fractal->transformCommon.functionEnabledFFalse)
		zc.x = zc.x + native_sin(zc.y) * fractal->transformCommon.scale3D000.x;
	if (fractal->transformCommon.functionEnabledGFalse)
		zc.y = zc.y + native_sin(zc.x) * fractal->transformCommon.scale3D000.y;

	// square
	if (fractal->transformCommon.functionEnabledBxFalse) zc.x = max(fabs(zc.x), fabs(zc.y));
	// circle
	if (fractal->transformCommon.functionEnabledOFalse)
		zc.x = native_sqrt((zc.x * zc.x) + (zc.y * zc.y));

	// plane
	REAL plD = fabs(c.z - fractal->transformCommon.offsetF0) - fractal->transformCommon.offsetAp01;

	// rec clip plane

	REAL d = 1000.0f;
	if (fractal->transformCommon.functionEnabledCy)
	{
		REAL4 rec = zc;
		if (fractal->transformCommon.functionEnabledEFalse)
			rec.x = fabs(rec.x) - ((rec.y) * fractal->transformCommon.scaleE1);

		if (fractal->transformCommon.functionEnabledXFalse)
			rec.x = rec.x - (fabs(rec.y) * fractal->transformCommon.scaleF1);

		REAL4 f = fabs(rec);
		f.x -= fractal->transformCommon.offset111.x;
		f.y -= fractal->transformCommon.offset111.y;
		f.z -= fractal->transformCommon.offsetBp01;
		d = max(f.x, max(f.y, f.z));

		// discs
		if (fractal->transformCommon.functionEnabledSFalse)
			d = native_sqrt(f.x * f.x + f.y * f.y) - fractal->transformCommon.offsetR1;
	}

	// cir clip plane
	REAL e = 1000.0f;
	if (fractal->transformCommon.functionEnabledCxFalse)
	{
		REAL4 cir = zc;
		e = fractal->transformCommon.radius1;
		if (fractal->transformCommon.functionEnabledCFalse)
			cir.y = cir.y - (fabs(cir.x) * fractal->transformCommon.constantMultiplier000.x);

		if (!fractal->transformCommon.functionEnabledYFalse)
			e = clamp(native_sqrt(cir.x * cir.x + cir.y * cir.y) - e, 0.0f, 100.0f); // circle,
		else
			e = clamp(native_sqrt(
									cir.x * cir.x + cir.y * cir.y + cir.z * cir.z * fractal->transformCommon.scaleA1)
									- e,
				0.0f, 100.0f); // sphere
	}

	aux->DE0 = min(e, d); // clip value

	// plane
	REAL a = 1000.0f;
	if (fractal->transformCommon.functionEnabledBFalse)
	{
		a =
			aux->const_c.z - fractal->transformCommon.offsetA0;
		aux->DE0 = min(aux->DE0, a);
	}

	// aux->color
	if (fractal->foldColor.auxColorEnabled)
	{
		REAL addColor = 0.0f;
		if (e > d) addColor += fractal->foldColor.difs0000.x;
		if (e < d) addColor += fractal->foldColor.difs0000.y;
		if (aux->DE0 == a) addColor += fractal->foldColor.difs0000.z;

		if (!fractal->transformCommon.functionEnabledJFalse)
			aux->color = addColor;
		else
			aux->color += addColor;
	}

	aux->DE0 = (max(plD, aux->DE0) - fractal->transformCommon.offset0005)
			/ (aux->DE + fractal->analyticDE.offset0);

	if (!fractal->analyticDE.enabledFalse)
		aux->dist = aux->DE0;
	else
		aux->dist = min(aux->dist, aux->DE0);

	if (fractal->transformCommon.functionEnabledzFalse) z = zc;
	return z;
}
