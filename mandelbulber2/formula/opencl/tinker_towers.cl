/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2024 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * GeneralizedFoldBoxIteration - Prototype Tinker Towers
 * @reference http://www.fractalforums.com/new-theories-and-research/tinker-towers/
 * This formula contains aux.color

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the file "fractal_tinker_towers.cpp" in the folder formula/definition
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TinkerTowersIteration(REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL t = 0.0f;
	REAL3 tv = (REAL3){0.0f, 0.0f, 0.0f};
	REAL3 zXYZ = z.xyz;

	REAL3 u_zXYZ = (REAL3){0.0f, 0.0f, 1.0f}; // angle does matter if mag_zXYZ==0
	REAL mag_zXYZ = 0.0f;

	t = dot(zXYZ, zXYZ);
	if (t > 0.0f)
	{
		t = native_sqrt(t);
		u_zXYZ = zXYZ / t;
		mag_zXYZ = t;
	}

	REAL flat = 0.0f;
	int sides;
	int i;

	// By defination u_Fv are unit vectors (rays) that define the orentation of the facets that cut a
	// unit sphere. The Nv vectors need to be scaled by a number between 0 and 1f, mag_Fv, in order to
	// cut the unit sphere. They don't have to be scaled by the same amount, but every facit must
	// contain its definining u_Fv vector.

	__constant REAL3 *u_Fv;

	switch (fractal->genFoldBox.type)
	{
		default:
		case generalizedFoldBoxTypeCl_foldTet:
			u_Fv = fractal->genFoldBox.Nv_tet;
			sides = fractal->genFoldBox.sides_tet;
			break;
		case generalizedFoldBoxTypeCl_foldCube:
			u_Fv = fractal->genFoldBox.Nv_cube;
			sides = fractal->genFoldBox.sides_cube;
			break;
		case generalizedFoldBoxTypeCl_foldOct:
			u_Fv = fractal->genFoldBox.Nv_oct;
			sides = fractal->genFoldBox.sides_oct;
			break;
		case generalizedFoldBoxTypeCl_foldDodeca:
			u_Fv = fractal->genFoldBox.Nv_dodeca;
			sides = fractal->genFoldBox.sides_dodeca;
			break;
		case generalizedFoldBoxTypeCl_foldOctCube:
			u_Fv = fractal->genFoldBox.Nv_oct_cube;
			sides = fractal->genFoldBox.sides_oct_cube;
			break;
		case generalizedFoldBoxTypeCl_foldIcosa:
			u_Fv = fractal->genFoldBox.Nv_icosa;
			sides = fractal->genFoldBox.sides_icosa;
			break;
		case generalizedFoldBoxTypeCl_foldBox6:
			u_Fv = fractal->genFoldBox.Nv_box6;
			sides = fractal->genFoldBox.sides_box6;
			break;
		case generalizedFoldBoxTypeCl_foldBox5:
			u_Fv = fractal->genFoldBox.Nv_box5;
			sides = fractal->genFoldBox.sides_box5;
			break;
	}

	// melt is going to be used to control the u_Fv vector height.
	// The height must be between 0 and 1 to cut the unit sphere
	// The magnetude does not need to be equal, but u_Fv must not be cut from the face.
	REAL melt = fractal->transformCommon.offset05;
	REAL mag_Fv[64];
	for (i = 0; i < sides; i++)
	{
		mag_Fv[i] = melt;
	}

	//
	// Scale is used as the power.
	REAL power = fractal->transformCommon.pwr4;
	// fractal->transformCommon.functionEnabledAFalse is used for selecting fractal(disabled) or
	// target map(enabled).
	//	REAL solid = fractal->mandelbox.solid;

	// Find the lowest cutting plane that cuts the ray from the origin through zXYZ.
	// The parameterized equation for this ray is L_Z(h) = h * u_zXYX.
	// The plane equation is X dot u_Fv = mag_Fv;
	// The value of h at the intersection point is h = mag_Fv/(u_zXYZ dot u_Fv)

	int side = -1; // Assume no facet found before unit sphere.
	REAL h = 1.0f; // so h=1.
	REAL my_h;
	for (i = 0; i < sides; i++)
	{
		my_h = 2.0f; // just needs to be >1
		REAL u_zXYZ_dot_u_Fvi = dot(u_zXYZ, u_Fv[i]);
		if (u_zXYZ_dot_u_Fvi > 0.0f)
		{
			my_h = mag_Fv[i] / u_zXYZ_dot_u_Fvi;
		}
		if (my_h < h)
		{
			h = my_h;
			side = i;
		}
	}
	// Did we hit a cutting plane in the unit sphere.
	// If so calculate the ratio of the distance from u_Fv through the point
	// of intersection of ray (Zc) to either another cutting plane or
	// the unit sphere if there are none.
	// Zc = h * zXYZ
	REAL w, my_w;
	int edge = -1;
	REAL3 Zc;
	// The intersection point is Zc.
	Zc = h * u_zXYZ;

	if (side != -1)
	{
		// The parameterized formula for the line from u_Fv through Zi is
		// L_u_Fv_Zc(w) = w * unit_vector(Zc - mag_Fv * u_Fv).

		// Using dot product to estimate ratio of u_Fv[side] to Zc to NV[side] to edge of facit
		// u_Fv[side] dot u_Fv[side] = 1;
		// u_Fv[side] dot Zc = h;
		// u_Fv[side] dot unclipped circle = mag_Fv.

		tv = (Zc - mag_Fv[side] * u_Fv[side]);
		t = dot(
			tv, Zc - mag_Fv[side] * u_Fv[side]); // mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		REAL D_u_Fv_to_Zc = native_sqrt(t);
		// REAL D_u_Fv_to_Zc = native_sqrt((Zc - mag_Fv[side] * u_Fv[side]).Dot(Zc - mag_Fv[side] *
		// u_Fv[side]));

		REAL3 u_Fv_to_Zc = (Zc - mag_Fv[side] * u_Fv[side]);
		// REAL3 u_Fv_to_Zc;
		if (D_u_Fv_to_Zc > 0.0f)
		{
			u_Fv_to_Zc = u_Fv_to_Zc / D_u_Fv_to_Zc;
		}

		// Assume no cutting plane before the unit sphere.
		// Find the distancd from u_Fv to edge of sphere.
		w = native_sqrt(1.0f - mag_Fv[side] * mag_Fv[side]);

		for (i = 0; i < sides; i++)
		{
			// Don't check side found in step 1.f
			if (side != i)
			{
				// avoid dividing by zero.
				if ((dot(u_Fv_to_Zc, u_Fv[i])) > 0.0f)
				{
					// Distance from mag_Fv * u_Fv to cutting plane i.
					my_w =
						(mag_Fv[i] - mag_Fv[side] * (dot(u_Fv[side], u_Fv[i]))) / (dot(u_Fv_to_Zc, u_Fv[i]));

					if (my_w < w)
					{
						w = my_w;
						edge = i;
					}
				}
			}
		}
		// w is the distance between u_Fv[side] and either an edge (cutting plane mag_Fv * u_Fv[edge])
		// The ratio of the distance (|mag_nv * u_Fv - Zc|)/w is the radial parameter for the patch map.

		REAL D = 0.0f;
		REAL3 Axis = (REAL3){0.0f, 0.0f, 1.0f}; // angle does not matter if D=0;
		// D = native_sqrt((Zc - mag_Fv * u_Fv[side]).Dot(Zc - mag_Fv * u_Fv[side]))/w;
		if (w > 0.0f)
		{
			D = D_u_Fv_to_Zc / w;
			Axis = cross(u_Fv[side], zXYZ);
			Axis = Axis / native_sqrt(dot(Axis, Axis));
		}
		flat = dot(Zc, u_zXYZ);
		if (!fractal->transformCommon.functionEnabledAFalse)
		{
			// if(D>1.0){printf("HERE");}
			//  REAL rot_angle = 3.14159*(1-D*D)*(1-D*D);  // force detail away from edges and center.
			// REAL rot_angle = 3.14159*(1-D)*(1-D); // Move detail toward center.
			// REAL rot_angle = 3.14159*(1-D*D); // Move detail tword edge.
			// REAL rot_angle = 3.14159*(1-.3 * D*D - .7*D);  // Mixing
			REAL rot_angle = M_PI_F * (1.0f - D); // Linear

			// Sign of rot_angel determines the patch includes self
			// rot_angle = rot_angle * ((side & 2)-1); // mix it up

			if (!fractal->transformCommon.functionEnabledBFalse)
			{
				rot_angle = -rot_angle;
			}
			// rot_angle = rot_angle;  // Exclude self
			// rot_angle = -rot_angle; // Include self

			// zXYZ = zXYZ *(1.0f - .0*flat);  // Does not play well with power DE
			// zXYZ =  RotateAroundVectorByAngle4(zXYZ, u_Fv[side], 3.14159/3.0); // Taffy

			REAL4 v4 = (REAL4){zXYZ.x, zXYZ.y, zXYZ.z, 0.0f};
			v4 = RotateAroundVectorByAngle4(v4, Axis, rot_angle); // php angel4 ?? mmmmmmmmmmmfix
			zXYZ = (REAL3){v4.x, v4.y, v4.z};
		}
		else
		{
			zXYZ = zXYZ / flat;
			REAL ramp = 5.0f * D - (int)(5.0f * D);			 // (int)
			REAL saw = -1.0f + 2.0f * fabs(ramp - 0.5f); // fabs
			saw = (saw + 0.6f) + fabs(saw + 0.6f);			 // fabs
			saw = 0.02f * saw * saw;
			REAL rings = 1.0f - (saw * (1.0f - 0.1f * ramp));
			if (D < 0.02f) rings = rings * 0.98f;
			zXYZ = zXYZ * rings;
		}
	}

	// zXYZ ray hits unit sphere first.

	REAL rp = pow(mag_zXYZ, power - 1.0f); // what about julia bulb or proper bulb

	aux->DE = rp * aux->DE * power + 1.0f;

	zXYZ = zXYZ * rp;

	aux->DE = aux->DE * fractal->analyticDE.scale1 + fractal->analyticDE.offset0;
	z = (REAL4){zXYZ.x, zXYZ.y, zXYZ.z, z.w};
	return z;
}