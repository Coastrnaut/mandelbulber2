/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
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

REAL4 XenodreambuieV3Iteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL t;
	if (fractal->transformCommon.functionEnabledPFalse
			&& aux->i >= fractal->transformCommon.startIterationsP
			&& aux->i < fractal->transformCommon.stopIterationsP)
	{
		if (fractal->transformCommon.functionEnabledCxFalse) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledCyFalse) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledCzFalse) z.z = fabs(z.z);
		z += fractal->transformCommon.offsetA000;

		if (fractal->transformCommon.functionEnabledTFalse)
		{
			aux->r = length(z);
		}
	}

	if (!fractal->transformCommon.functionEnabledSwFalse) t = asin(z.z / aux->r);
	else t = acos(z.z / aux->r);
	t = (t + fractal->bulb.betaAngleOffset);
	REAL th = t * fractal->bulb.power * fractal->transformCommon.scaleA1;
	REAL ph = (atan2(z.y, z.x) + fractal->bulb.alphaAngleOffset)
			* fractal->bulb.power * fractal->transformCommon.scaleB1;
	REAL rp = pow(aux->r, fractal->bulb.power - fractal->transformCommon.offset1);
	aux->DE = rp * aux->DE * fabs(fractal->bulb.power) + 1.0f;
	rp *= aux->r;



	// polar to cartesian
	if (!fractal->transformCommon.functionEnabledDFalse)
	{
		if (aux->i >= fractal->transformCommon.startIterationsX
				&& aux->i < fractal->transformCommon.stopIterationsX)
		{
			if (native_cos(th) < 0.0f) ph = ph + M_PI_F;
		}

		REAL cth = native_cos(th);
		if (fractal->transformCommon.functionEnabledBFalse
				&& aux->i >= fractal->transformCommon.startIterationsB
				&& aux->i < fractal->transformCommon.stopIterationsB)
		{
			z.x = (cth + (1.0f - cth) * fractal->transformCommon.scaleB0) * cos(ph) * rp;
		}
		else
		{
			z.x = cth * cos(ph) * rp;
		}
		if (fractal->transformCommon.functionEnabledAFalse
				&& aux->i >= fractal->transformCommon.startIterationsA
				&& aux->i < fractal->transformCommon.stopIterationsA)
		{
			z.y = (cth + (1.0f - cth) * fractal->transformCommon.scaleA0) * sin(ph) * rp;
		}
		else
		{
			z.y = cth * sin(ph) * rp;
		}
		z.z = native_sin(th) * rp;
	}
	else
	{
		if (aux->i >= fractal->transformCommon.startIterationsY
				&& aux->i < fractal->transformCommon.stopIterationsY)
		{
			if (fabs(t) > 0.5f * M_PI_F) t = sign(t) * M_PI_F - t;
		}
		th = t * fractal->bulb.power * fractal->transformCommon.scaleA1;

		REAL sth = sin(th);
		z.x = sth * cos(ph) * rp;
		z.y = sth * sin(ph) * rp;
		z.z = cos(th) * rp;
	}
	if (fractal->transformCommon.functionEnabledBzFalse) z.y = min(z.y, fractal->transformCommon.offset0 - z.y);
	z += fractal->transformCommon.offset000;

	z *= fractal->transformCommon.scaleC1;
	aux->DE *= fabs(fractal->transformCommon.scaleC1);

	if (fractal->analyticDE.enabledFalse)
		aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;

	if (fractal->transformCommon.functionEnabledCFalse)
	{
		aux->DE0 = length(z);
		if (!fractal->transformCommon.functionEnabledBxFalse)
		{
			if (aux->DE0 > 1.0f)
				aux->DE0 = 0.5f * log(aux->DE0) * aux->DE0 / aux->DE;
			else
				aux->DE0 = 0.0f;
		}
		else // temp
		{
			if (aux->DE0 > 1.0f)
				aux->DE0 = 1.0 / aux->DE0 / aux->DE;
			else
				aux->DE0 = 0.0f;
		}




		/*if (aux->DE0 > 1.0f)
			aux->DE0 = 0.5f * log(aux->DE0) * aux->DE0 / aux->DE;
		else
			aux->DE0 = 0.0f; // 0.01f artifacts in openCL*/
		if (!fractal->transformCommon.functionEnabledByFalse)
		{
			aux->dist = aux->DE0;
		}
		else
		{	if (aux->i >= fractal->transformCommon.startIterationsC
				&& aux->i < fractal->transformCommon.stopIterationsC)
					aux->dist = min(aux->dist, aux->DE0);
			else aux->dist = aux->DE0;
		}


	}


	return z;
}
