/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.         ______
 * Copyright (C) 2020 Mandelbulber Team   _>]|=||i=i<,      / ____/ __    __
 *                                        \><||i|=>>%)     / /   __/ /___/ /_
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    / /__ /_  __/_  __/
 * The project is licensed under GPLv3,   -<>>=|><|||`    \____/ /_/   /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * MsltoeJuliaBulb Eiffie. Refer post by Eiffie    Reply #69 on: January 27, 2015
 * @reference http://www.fractalforums.com/theory/choosing-the-squaring-formula-by-location/60/
 */

#include "all_fractal_definitions.h"

cFractalMsltoeSym4Mod1::cFractalMsltoeSym4Mod1() : cAbstractFractal()
{
	nameInComboBox = "Msltoe - Sym4 Mod1";
	internalName = "msltoe_sym4_mod1";
	internalID = fractal::msltoeSym4Mod1;
	DEType = analyticDEType;
	DEFunctionType = logarithmicDEFunction;
	cpixelAddition = cpixelDisabledByDefault;
	defaultBailout = 10.0;
	DEAnalyticFunction = analyticFunctionLogarithmic;
	coloringFunction = coloringFunctionDefault;
}

void cFractalMsltoeSym4Mod1::FormulaCode(CVector4 &z, const sFractal *fractal, sExtendedAux &aux)
{
	if (aux.i >= fractal->transformCommon.startIterationsK
			&& aux.i < fractal->transformCommon.stopIterationsK)
	{
		if (fractal->transformCommon.functionEnabledBx) z.x = fabs(z.x);
		if (fractal->transformCommon.functionEnabledBy) z.y = fabs(z.y);
		if (fractal->transformCommon.functionEnabledBz) z.z = fabs(z.z);
		CVector4 pfive = fractal->transformCommon.additionConstant0555;
		double t;
		if (fractal->transformCommon.functionEnabledAx)
		{
			t = z.x - z.z;
			t = pfive.x * (t - fabs(t));
			z.x = z.x - t;
			z.z = z.z + t;
		}

		if (fractal->transformCommon.functionEnabledAy)
		{
			t = z.x - z.y;
			t = pfive.y * (t - fabs(t));
			z.x = z.x - t;
			z.y = z.y + t;
		}

		if (fractal->transformCommon.functionEnabledAz)
		{
			t = z.y - z.z;
			t = pfive.z * (t - fabs(t));
			z.y = z.y - t;
			z.z = z.z + t;
		}

		z += fractal->transformCommon.offsetA000;
	}

	CVector4 c = aux.const_c;
	aux.DE = aux.DE * 2.0 * aux.r;

	double psi = fractal->transformCommon.int8Y;
	if (fractal->transformCommon.functionEnabledBFalse
			&& aux.i >= fractal->transformCommon.startIterationsB
			&& aux.i < fractal->transformCommon.stopIterationsB)
	{
		psi += fractal->transformCommon.int1;
	}
	psi = M_PI / psi;
	psi = fabs(fmod(atan2(z.z, z.y) + M_PI + psi, 2.0 * psi) - psi);
	double len = sqrt(z.y * z.y + z.z * z.z);
	z.y = cos(psi) * len;
	z.z = sin(psi) * len;

	CVector4 z2 = z * z;
	double rr = z2.x + z2.y + z2.z;
	double m = 1.0 - z2.z / rr;
	CVector4 temp;
	temp.x = (z2.x - z2.y) * m * fractal->transformCommon.scaleB1;
	temp.y = 2.0 * z.x * z.y * m * fractal->transformCommon.scale; // scaling y;
	temp.z = 2.0 * z.z * sqrt(z2.x + z2.y);
	temp.w = z.w;
	z = temp + fractal->transformCommon.additionConstantNeg100;

	if (fractal->transformCommon.addCpixelEnabledFalse
			&& aux.i >= fractal->transformCommon.startIterationsC
			&& aux.i < fractal->transformCommon.stopIterationsC)
	{
		CVector4 tempFAB = c;
		if (fractal->transformCommon.functionEnabledx) tempFAB.x = fabs(tempFAB.x);
		if (fractal->transformCommon.functionEnabledy) tempFAB.y = fabs(tempFAB.y);
		if (fractal->transformCommon.functionEnabledz) tempFAB.z = fabs(tempFAB.z);

		tempFAB *= fractal->transformCommon.constantMultiplier000;
		z.x += sign(z.x) * tempFAB.x;
		z.y += sign(z.y) * tempFAB.y;
		z.z += sign(z.z) * tempFAB.z;
	}
	double lengthTempZ = -z.Length();
	// if (lengthTempZ > -1e-21) lengthTempZ = -1e-21;   //  z is neg.)
	z *= 1.0 + fractal->transformCommon.offset / lengthTempZ;
	z *= fractal->transformCommon.scale1;
	aux.DE *= fabs(fractal->transformCommon.scale1);


	if (fractal->analyticDE.enabledFalse)
		aux.DE = aux.DE * fractal->analyticDE.scale1
						 + fractal->analyticDE.offset0;
}
