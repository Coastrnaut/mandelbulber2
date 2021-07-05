/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Testing transform2
 *https://fractalforums.org/fractal-mathematics-and-new-theories/28/fake-3d-mandelbrot-set/1787/msg17940#msg17940

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_spherical_fold_v1.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfSphericalFoldV1Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 signs = z;
	signs.x = sign(z.x);
	signs.y = sign(z.y);
	signs.z = sign(z.z);
	signs.w = sign(z.w);

	z = fabs(z);
	REAL4 tt = z - fractal->mandelbox.offset;

	REAL trr = dot(tt, tt);
	REAL tp = min(max(1.0f / trr, 1.0f), 1.0f / fractal->transformCommon.minR2p25);

	z *= tp;
	aux->DE *= tp;
	z *= signs;

	// DE tweak
	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
	return z;
}
