/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * ABoxMod14,
 * The Mandelbox fractal known as AmazingBox or ABox, invented by Tom Lowe in 2010
 * Hollow mandelbox idea from alexl (sanbase)
 * http://www.fractalforums.com/3d-fractal-generation/realtime-rendering-on-gpu/
 * Other variations by mclarekin
 * This formula contains aux.color and aux.actualScaleA

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_abox_mod14.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 AboxTetraIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 c = aux->const_c;
	REAL colorAdd = 0.0f;
	REAL m = 1.0f;

		z += fractal->transformCommon.additionConstantA000;
		if (fractal->transformCommon.functionEnabledx) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledy) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledz) z.z = fabs(z.z);

	if (fractal->transformCommon.functionEnabledAxFalse
		&& aux->i >= fractal->transformCommon.startIterationsE
		&& aux->i < fractal->transformCommon.stopIterationsE)
	{
		REAL temp = 0.0;
		if (z.x + z.y < 0.0)
		{
			temp = -z.y;
			z.y = -z.x;
			z.x = temp;
		}
		if (z.x + z.z < 0.0)
		{
			temp = -z.z;
			z.z = -z.x;
			z.x = temp;
		}
		if (z.y + z.z < 0.0)
		{
			temp = -z.z;
			z.z = -z.y;
			z.y = temp;
		}
	}
	if (fractal->transformCommon.functionEnabledAy
		&& aux->i >= fractal->transformCommon.startIterationsF
		&& aux->i < fractal->transformCommon.stopIterationsF)
	{
		if (z.x - z.y < 0.0f)
		{
			REAL temp = z.y;
			z.y = z.x;
			z.x = temp;
		}
		if (z.x - z.z < 0.0f)
		{
			REAL temp = z.z;
			z.z = z.x;
			z.x = temp;
		}
		if (z.y - z.z < 0.0f)
		{
			REAL temp = z.z;
			z.z = z.y;
			z.y = temp;
		}
	}







	// tglad fold
	if (fractal->transformCommon.functionEnabledAFalse
			&& aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
					- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
		z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
					- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;
		if (fractal->transformCommon.functionEnabled)
		{
			z.z = fabs(z.z + fractal->transformCommon.additionConstant111.z)
						- fabs(z.z - fractal->transformCommon.additionConstant111.z) - z.z;
		}

		if (fractal->transformCommon.functionEnabledFalse
				&& aux->i >= fractal->transformCommon.startIterationsD
				&& aux->i < fractal->transformCommon.stopIterationsD1)
		{
			REAL4 limit = fractal->transformCommon.additionConstant111;
			REAL4 length = 2.0f * limit;
			REAL4 tgladS = 1.0f / length;
			REAL4 Add = (REAL4){0.0f, 0.0f, 0.0f, 0.0f};
			if (fabs(z.x) < limit.x) Add.x = z.x * z.x * tgladS.x;
			if (fabs(z.y) < limit.y) Add.y = z.y * z.y * tgladS.y;
			if (fabs(z.z) < limit.z) Add.z = z.z * z.z * tgladS.z;
			if (fabs(z.x) > limit.x && fabs(z.x) < length.x)
				Add.x = (length.x - fabs(z.x)) * (length.x - fabs(z.x)) * tgladS.x;
			if (fabs(z.y) > limit.y && fabs(z.y) < length.y)
				Add.y = (length.y - fabs(z.y)) * (length.y - fabs(z.y)) * tgladS.y;
			if (fabs(z.z) > limit.z && fabs(z.z) < length.z)
				Add.z = (length.z - fabs(z.z)) * (length.z - fabs(z.z)) * tgladS.z;
			Add *= fractal->transformCommon.scale3D000;
			z.x = (z.x - (sign(z.x) * (Add.x)));
			z.y = (z.y - (sign(z.y) * (Add.y)));
			z.z = (z.z - (sign(z.z) * (Add.z)));
		}
	}
	// negative offset
	z -= fractal->transformCommon.offset110;

	// spherical fold
	if (aux->i >= fractal->transformCommon.startIterationsS
			&& aux->i < fractal->transformCommon.stopIterationsS)
	{
		REAL rr = dot(z, z);
		if (rr < fractal->transformCommon.invert0)
			m = fractal->transformCommon.inv0;
		else if (rr < fractal->transformCommon.invert1)
			m = 1.0f / rr;
		else
			m = fractal->transformCommon.inv1;
		z *= m;
		aux->DE *= m;
	}

	REAL useScale = fractal->transformCommon.scale015;
	if (fractal->transformCommon.functionEnabledXFalse
			&& aux->i >= fractal->transformCommon.startIterationsX
			&& aux->i < fractal->transformCommon.stopIterationsX)
	{
		useScale += aux->actualScaleA;
		z *= useScale;
		aux->DE = aux->DE * fabs(useScale) + fractal->analyticDE.offset0;

		// update actualScale for next iteration
		REAL vary = fractal->transformCommon.scaleVary0
								* (fabs(aux->actualScaleA) - fractal->transformCommon.scaleB1);
		aux->actualScaleA = -vary;
	}
	else
	{
		z *= useScale;
		aux->DE = aux->DE * fabs(useScale) + fractal->analyticDE.offset0;
	}

	// offset options
	if (fractal->transformCommon.functionEnabledAxFalse
			&& aux->i >= fractal->transformCommon.startIterationsB
			&& aux->i < fractal->transformCommon.stopIterationsB)
	{
		REAL4 offset = aux->pos_neg * fractal->transformCommon.additionConstant000;

		if (fractal->transformCommon.functionEnabledAFalse)
			offset = (REAL4){sign(z.x), sign(z.y), sign(z.z), 1.0f} * offset;

		if (fractal->transformCommon.functionEnabledBFalse)
			offset = (REAL4){sign(c.x), sign(c.y), sign(c.z), 1.0f} * offset;

		z += offset;
		aux->pos_neg *= fractal->transformCommon.scale1; // update for next iter
	}

	// addCpixel
	if (fractal->transformCommon.addCpixelEnabledFalse
			&& aux->i >= fractal->transformCommon.startIterationsC
			&& aux->i < fractal->transformCommon.stopIterationsC)
	{
		REAL4 tempC = c;
		if (fractal->transformCommon.addCpixelEnabled)
		{
			tempC.x = sign(z.x) * fabs(c.x);
			tempC.y = sign(z.y) * fabs(c.y);
			tempC.z = sign(z.z) * fabs(c.z);
		}

		z += tempC * fractal->transformCommon.constantMultiplier111;
	}
	// rotation
	if (fractal->transformCommon.rotationEnabled
			&& aux->i >= fractal->transformCommon.startIterationsR
			&& aux->i < fractal->transformCommon.stopIterationsR)
	{
		z = Matrix33MulFloat4(fractal->transformCommon.rotationMatrix, z);
	}
	// color
	if (fractal->foldColor.auxColorEnabledFalse)
	{
		colorAdd += fractal->mandelbox.color.factorSp2 * m;
		aux->color += colorAdd;
	}
	return z;
}
