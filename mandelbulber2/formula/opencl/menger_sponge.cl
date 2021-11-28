/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2019 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * Menger Sponge formula created by Knighty
 * @reference
 * http://www.fractalforums.com/ifs-iterated-function-systems/kaleidoscopic-(escape-time-ifs)/

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_menger_sponge.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 MengerSpongeIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	z.x = fabs(z.x);
	z.y = fabs(z.y);
	z.z = fabs(z.z);

	if (z.x < z.y)
	{
		REAL temp = z.x;
		z.x = z.y;
		z.y = temp;
	}
	if (z.x < z.z)
	{
		REAL temp = z.x;
		z.x = z.z;
		z.z = temp;
	}
	if (z.y < z.z)
	{
		REAL temp = z.y;
		z.y = z.z;
		z.z = temp;
	}

	z *= fractal->transformCommon.scale3;

	z.x -= 2.0f;
	z.y -= 2.0f;
	if (z.z > 1.0f) z.z -= 2.0f;

	aux->DE *= fractal->transformCommon.scale3;
	return z;
}
