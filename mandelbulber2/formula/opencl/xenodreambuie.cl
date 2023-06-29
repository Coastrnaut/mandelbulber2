/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2023 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Xenodreambuie
 * @reference
 * http://www.fractalforums.com/3d-fractal-generation/true-3d-mandlebrot-type-fractal/273/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_xenodreambuie.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 XenodreambuieIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL rp = pow(aux->r, fractal->bulb.power - 1.0f);
	aux->DE = rp * aux->DE * fractal->bulb.power + 1.0f;
	rp *= aux->r;

	REAL th = (atan2(z.y, z.x) + fractal->bulb.betaAngleOffset) * fractal->bulb.power;
	REAL ph = acos(z.z / aux->r) + fractal->bulb.alphaAngleOffset;

	if (fabs(ph) > 0.5f * M_PI_F) ph = sign(ph) * M_PI_F - ph;

	ph *= fractal->bulb.power;

	REAL sph = native_sin(ph);
	z.x = rp * native_cos(th) * sph;
	z.y = rp * native_sin(th) * sph;
	z.z = rp * native_cos(ph);
	return z;
}