/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.         ______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,      / ____/ __    __
 *                                        \><||i|=>>%)     / /   __/ /___/ /_
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    / /__ /_  __/_  __/
 * The project is licensed under GPLv3,   -<>>=|><|||`    \____/ /_/   /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * amazing surf based on Mandelbulber3D. Formula proposed by Kali, with features added by
 * DarkBeam
 * @reference
 * http://www.fractalforums.com/mandelbulb-3d/custom-formulas-and-transforms-release-t17106/
 */

#include "all_fractal_definitions.h"

cFractalAmazingSurfKleinV2::cFractalAmazingSurfKleinV2() : cAbstractFractal()
{
	nameInComboBox = "Amazing Surf - Klein V2";
	internalName = "amazing_surf_klein_v2";
	internalID = fractal::amazingSurfKleinV2;
	DEType = analyticDEType;
	DEFunctionType = linearDEFunction;
	cpixelAddition = cpixelDisabledByDefault;
	defaultBailout = 100.0;
	DEAnalyticFunction = analyticFunctionLinear;
	coloringFunction = coloringFunctionDefault;
}

void cFractalAmazingSurfKleinV2::FormulaCode(CVector4 &z, const sFractal *fractal, sExtendedAux &aux)
{
	// polyfold
	if (fractal->transformCommon.functionEnabledPFalse
			&& aux.i >= fractal->transformCommon.startIterationsP
			&& aux.i < fractal->transformCommon.stopIterationsP1)
	{
		z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledCy) z.y = fabs(z.y);
		double psi = M_PI / fractal->transformCommon.int8Y;
		psi = fabs(fmod(atan2(z.y, z.x) + psi, 2.0 * psi) - psi);
		double len = sqrt(z.x * z.x + z.y * z.y);
		z.x = cos(psi) * len;
		z.y = sin(psi) * len;
		z += fractal->transformCommon.offsetF000;
	}

	// sphere inversion
	if (fractal->transformCommon.sphereInversionEnabledFalse
			&& aux.i >= fractal->transformCommon.startIterationsX
			&& aux.i < fractal->transformCommon.stopIterations1)
	{
		z += fractal->transformCommon.offset000;
		double rr = z.Dot(z);
		z *= fractal->transformCommon.scaleG1 / rr;
		aux.DE *= (fractal->transformCommon.scaleG1 / rr);
		z += fractal->transformCommon.additionConstant000 - fractal->transformCommon.offset000;
		z *= fractal->transformCommon.scaleA1;
		aux.DE *= fractal->transformCommon.scaleA1;
	}

	if (aux.i < fractal->transformCommon.int8X)
	{
		CVector4 oldZ = z;
		z.x = fabs(z.x + fractal->transformCommon.additionConstant111.x)
					- fabs(z.x - fractal->transformCommon.additionConstant111.x) - z.x;
		z.y = fabs(z.y + fractal->transformCommon.additionConstant111.y)
					- fabs(z.y - fractal->transformCommon.additionConstant111.y) - z.y;

		if (fractal->transformCommon.functionEnabledIFalse
				&& aux.i >= fractal->transformCommon.startIterationsI
				&& aux.i < fractal->transformCommon.stopIterationsI)
		{
			double tt = z.x;
			z.x = z.y;
			z.y = tt;
		}

		if (fractal->transformCommon.functionEnabledJFalse
			&& aux.i >= fractal->transformCommon.startIterationsJ
			&& aux.i < fractal->transformCommon.stopIterationsJ)
		{
			z.z = fabs(z.z + fractal->transformCommon.additionConstant111.z)
						- fabs(z.z - fractal->transformCommon.additionConstant111.z) - z.z;
		}
		else
		{
			double tt = z.y;
			z.y = z.z;
			z.z = tt;
		}
		if (fractal->transformCommon.functionEnabledSwFalse
				&& aux.i >= fractal->transformCommon.startIterationsH
				&& aux.i < fractal->transformCommon.stopIterationsH)
		{
			double tt = z.x;
			z.x = z.y;
			z.y = tt;
		}
		CVector4 zCol = z;

		double rr = z.Dot(z);
		double MinRR = fractal->transformCommon.minR0;
		double dividend = rr < MinRR ? MinRR : min(rr, 1.0);

		// scale
		double useScale = 1.0;
		useScale = (aux.actualScaleA + fractal->transformCommon.scale1) / dividend;
		z *= useScale;
		aux.DE = aux.DE * fabs(useScale) + fractal->analyticDE.offset1;
		if (fractal->transformCommon.functionEnabledKFalse
				&& aux.i >= fractal->transformCommon.startIterationsK
				&& aux.i < fractal->transformCommon.stopIterationsK)
		{
			// update actualScaleA for next iteration
			double vary = fractal->transformCommon.scaleVary0
										* (fabs(aux.actualScaleA) - fractal->transformCommon.scaleC1);
			aux.actualScaleA -= vary;
		}

		if (fractal->transformCommon.rotation2EnabledFalse)
		{
			z = fractal->transformCommon.rotationMatrix.RotateVector(z);
		}
		if (aux.i >= fractal->transformCommon.startIterationsO
				&& aux.i < fractal->transformCommon.stopIterationsO)
				z += fractal->transformCommon.additionConstantA000;

		if (fractal->foldColor.auxColorEnabledFalse)
		{
			double colorAdd = 0.0;
			if (zCol.x != oldZ.x)
				colorAdd += fractal->foldColor.difs0000.x
										* (fabs(zCol.x) - fractal->transformCommon.additionConstant111.x);
			if (zCol.y != oldZ.y)
				colorAdd += fractal->foldColor.difs0000.y
										* (fabs(zCol.y) - fractal->transformCommon.additionConstant111.y);
			if (zCol.z != oldZ.z)
				colorAdd += fractal->foldColor.difs0000.z
										* (fabs(zCol.z) - fractal->transformCommon.additionConstant111.z);
			colorAdd += fractal->foldColor.difs0000.w * useScale;
			aux.color += colorAdd;
		}
	}
	else
	{
		if (fractal->transformCommon.functionEnabled)
		{
			z = fabs(z + fractal->transformCommon.offset110)
					- fabs(z - fractal->transformCommon.offset110) - z;

			z *= fractal->transformCommon.scale2;
			aux.DE *= fractal->transformCommon.scale2;

			z += fractal->transformCommon.offsetA000;
		}
	}
}
