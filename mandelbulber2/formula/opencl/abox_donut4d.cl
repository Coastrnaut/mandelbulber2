/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2023 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Formula based on Aexion's The-Golden-Donnut
 * https://www.deviantart.com/aexion/art/The-Golden-Donnut-210148578
 * This formula contains aux.color and aux.actualScale

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_abox_donut4d.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 AboxDonut4dIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL colorAdd = 0.0f;

	// initial conditions 4D
	REAL4 ct = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
	if (aux->i == 0)
	{
		REAL angle = atan2(z.x, z.y) * fractal->transformCommon.scaleA2;
		REAL radius = native_sqrt(z.x * z.x + z.y * z.y);
		REAL t_radius = radius - fractal->transformCommon.offset4;

		ct.x = native_sin(angle) * radius;
		ct.y = native_cos(angle) * radius;
		ct.z = z.z - fractal->transformCommon.offset0;
		ct.w = t_radius * t_radius + z.z * z.z;

		z = ct;
		z = fabs(z) - fractal->transformCommon.offsetA0000;
		aux->const_c = z;
	}

	// abox
	REAL rrCol = 0.0f;
	REAL4 zCol = z;
	REAL4 oldZ = z;

	z = fabs(z + fractal->transformCommon.offset1111) - fabs(z - fractal->transformCommon.offset1111)
			- z;

	zCol = z;

	REAL rr = dot(z, z);
	rrCol = rr;
	z += fractal->transformCommon.offset0000;
	if (rr < fractal->transformCommon.minR2p25)
	{
		z *= fractal->transformCommon.maxMinR2factor;
		aux->DE *= fractal->transformCommon.maxMinR2factor;
	}
	else if (rr < fractal->transformCommon.maxR2d1)
	{
		z *= fractal->transformCommon.maxR2d1 / rr;
		aux->DE *= fractal->transformCommon.maxR2d1 / rr;
	}
	z -= fractal->transformCommon.offset0000;

	// scale
	z *= fractal->transformCommon.scale2;
	aux->DE = aux->DE * fabs(fractal->transformCommon.scale2) + 1.0f;

	z += fractal->transformCommon.additionConstant0000;

	z += aux->const_c * fractal->transformCommon.scale1111;

	// aux->color
	if (fractal->foldColor.auxColorEnabledFalse && aux->i >= fractal->transformCommon.startIterationsN
			&& aux->i < fractal->transformCommon.stopIterationsN)
	{
		if (zCol.x != oldZ.x) colorAdd += fractal->foldColor.difs0000.x;
		if (zCol.y != oldZ.y) colorAdd += fractal->foldColor.difs0000.y;
		if (zCol.z != oldZ.z) colorAdd += fractal->foldColor.difs0000.z;
		if (zCol.w != oldZ.w) colorAdd += fractal->foldColor.difs0000.w;

		if (rrCol < fractal->transformCommon.minR2p25)
			colorAdd += fractal->mandelbox.color.factorSp1;
		else if (rrCol < fractal->transformCommon.maxR2d1)
			colorAdd += fractal->foldColor.difs1;
		aux->color += colorAdd;
	}

	// DE tweak
	if (fractal->analyticDE.enabled)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset1;
	return z;
}