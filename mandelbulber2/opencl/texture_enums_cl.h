/**
 * Mandelbulber v2, a 3D fractal generator       ,=#MKNmMMKmmßMNWy,
 *                                             ,B" ]L,,p%%%,,,§;, "K
 * Copyright (C) 2018-20 Mandelbulber Team     §R-==%w["'~5]m%=L.=~5N
 *                                        ,=mm=§M ]=4 yJKA"/-Nsaj  "Bw,==,,
 * This file is part of Mandelbulber.    §R.r= jw",M  Km .mM  FW ",§=ß., ,TN
 *                                     ,4R =%["w[N=7]J '"5=],""]]M,w,-; T=]M
 * Mandelbulber is free software:     §R.ß~-Q/M=,=5"v"]=Qf,'§"M= =,M.§ Rz]M"Kw
 * you can redistribute it and/or     §w "xDY.J ' -"m=====WeC=\ ""%""y=%"]"" §
 * modify it under the terms of the    "§M=M =D=4"N #"%==A%p M§ M6  R' #"=~.4M
 * GNU General Public License as        §W =, ][T"]C  §  § '§ e===~ U  !§[Z ]N
 * published by the                    4M",,Jm=,"=e~  §  §  j]]""N  BmM"py=ßM
 * Free Software Foundation,          ]§ T,M=& 'YmMMpM9MMM%=w=,,=MT]M m§;'§,
 * either version 3 of the License,    TWw [.j"5=~N[=§%=%W,T ]R,"=="Y[LFT ]N
 * or (at your option)                   TW=,-#"%=;[  =Q:["V""  ],,M.m == ]N
 * any later version.                      J§"mr"] ,=,," =="""J]= M"M"]==ß"
 *                                          §= "=C=4 §"eM "=B:m|4"]#F,§~
 * Mandelbulber is distributed in            "9w=,,]w em%wJ '"~" ,=,,ß"
 * the hope that it will be useful,                 . "K=  ,=RMMMßM"""
 * but WITHOUT ANY WARRANTY;                            .'''
 * without even the implied warranty
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Mandelbulber. If not, see <http://www.gnu.org/licenses/>.
 *
 * ###########################################################################
 *
 * Authors: Krzysztof Marczak (buddhi1980@gmail.com)
 *
 * texture types
 *       ____                   ________
 *      / __ \____  ___  ____  / ____/ /
 *     / / / / __ \/ _ \/ __ \/ /   / /
 *    / /_/ / /_/ /  __/ / / / /___/ /___
 *    \____/ .___/\___/_/ /_/\____/_____/
 *        /_/
 *
 * This file has been autogenerated by tools/populateOpenCL.php
 * from the file src/texture_enums.hpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

#ifndef MANDELBULBER2_OPENCL_TEXTURE_ENUMS_CL_HPP_
#define MANDELBULBER2_OPENCL_TEXTURE_ENUMS_CL_HPP_

#ifndef OPENCL_KERNEL_CODE
#include "common_params_cl.hpp"
#include "fractal_cl.h"
#include "image_adjustments_cl.h"
#include "opencl_algebra.h"

#include "src/common_params.hpp"
#include "src/fractal.h"
#include "src/fractal_enums.h"
#include "src/fractparams.hpp"
#include "src/image_adjustments.h"
#endif /* OPENCL_KERNEL_CODE */

typedef enum
{
	mappingSpherical = 0,
	mappingCubic = 1,
	mappingCylindrical = 2,
	mappingPlanar = 3
} enumTextureMappingCl;

typedef enum
{
	texColor = 0,
	texDiffuse = 1,
	texLuminosity = 2,
	texDisplacement = 3,
	texReflectance = 4,
	texTransparency = 5,
	texTransparencyAlpha = 6
} enumTextureSelectionCl;

#endif /* MANDELBULBER2_OPENCL_TEXTURE_ENUMS_CL_HPP_ */
