/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2023 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * spherical invert v3
 * from M3D. Formula by Luca GN 2011, updated May 2012.
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_spherical_inv_v3.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfSphericalInvV3Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	// pre abs
	if (fractal->transformCommon.functionEnabledCFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC1)
	{
		z += fractal->transformCommon.offsetF000;
		if (fractal->transformCommon.functionEnabledx) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledy) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledz) z.z = fabs(z.z);
	}

	if (aux->i >= fractal->transformCommon.startIterationsD
			&& aux->i < fractal->transformCommon.stopIterationsD1)
	{
		z += fractal->transformCommon.offset000 + fractal->transformCommon.offsetA000;
		REAL rr = dot(z, z);
		REAL r = native_sqrt(rr);
		REAL inv = 1.0f / rr;
		z *= fractal->transformCommon.maxR2d1 * inv;
		z -= fractal->transformCommon.offset000;

		if (!fractal->transformCommon.functionEnabledNFalse)
			aux->DE *= inv * (fractal->transformCommon.maxR2d1 + r * aux->DE);
		else
			aux->DE *=
				inv * (fractal->transformCommon.maxR2d1 + r * aux->DE * fractal->transformCommon.scale0);

		z *= fractal->transformCommon.scaleA1;
		aux->DE *= fractal->transformCommon.scaleA1;
	}

	if (fractal->analyticDE.enabledFalse)
	{
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
	}
	return z;
}