/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Adds c constant to z vector

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_transf_add_constant.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfAddNormIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	z += fractal->transformCommon.offset000;
	REAL4 zNorm = z / aux->r;
	REAL4 rotadd = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, zNorm);
	z += fractal->transformCommon.scale1 * rotadd;
	z -= fractal->transformCommon.offset000;
	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux=>DE * length(z) / aux->r * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
	return z;
}
