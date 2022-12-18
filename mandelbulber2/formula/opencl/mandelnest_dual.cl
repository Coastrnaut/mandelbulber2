﻿/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2022 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Mandelnest refer Jeannot
 * https://fractalforums.org/share-a-fractal/22/mandelbrot-3d-mandelnest/4028/
 * also https://www.shadertoy.com/view/4lKfzy

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_mandelnest_v2.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MandelnestDualIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{

	REAL Power = fractal->bulb.power;
	aux->DE = pow(aux->r, Power - 1.0f) * aux->DE * Power + 1.0f;
	// Dual +
	REAL4 zp = z;
	REAL M0 = length(zp);
	zp.x = asin(zp.x / M0); // dual+
	zp.y = asin(zp.y / M0);
	zp.z = asin(zp.z / M0);
	M0 = pow(M0, Power);
	zp *= Power;

	zp.x = sin(zp.x);
	zp.y = sin(zp.y);
	zp.z = sin(zp.z);
	REAL M1 = length(zp);
	zp = zp * M0 / M1;
	zp += fractal->transformCommon.offsetA000;
	if (!fractal->transformCommon.functionEnabledAFalse)
		zp += aux->const_c * fractal->transformCommon.constantMultiplierA111;

	// Dual -
	REAL4 zm = z;
	M0 = length(zm);
	zm.x = -asin(zm.x / M0); // dual-
	zm.y = -asin(zm.y / M0);
	zm.z = -asin(zm.z / M0);
	M0 = pow(M0, Power);
	zm *= Power;

	zm.x = sin(zm.x);
	zm.y = sin(zm.y);
	zm.z = sin(zm.z);
	M1 = length(zm);
	zm = zm * M0 / M1;
	zm += fractal->transformCommon.offsetA000;
	if (!fractal->transformCommon.functionEnabledAFalse)
		zm += aux->const_c * fractal->transformCommon.constantMultiplierA111;

	// Dual+ OR dual-
	M0 = length(zp);
	M1 = length(zm);
	if (M0<M1)
	{
		z = zp;
	}
	else
	{
		z = zm;
	}

	if (fractal->transformCommon.functionEnabledAFalse)
		z += aux->const_c * fractal->transformCommon.constantMultiplierA111;

	if (fractal->transformCommon.functionEnabledFalse)
	{
		zp.x = sign(aux->const_c.x);
		zp.y = sign(aux->const_c.y);
		zp.z = sign(aux->const_c.z);
		z -= fractal->transformCommon.offset000 * zp;
	}

	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

	return z;
}
