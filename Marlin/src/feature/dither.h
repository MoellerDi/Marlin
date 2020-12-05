/**
 * Marlin 3D Printer Firmware
 * Copyright (c) 2020 MarlinFirmware [https://github.com/MarlinFirmware/Marlin]
 *
 * Based on Sprinter and grbl.
 * Copyright (c) 2011 Camiel Gubbels / Erik van der Zalm
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 */

/**
 * Dithering seeks to improve mechanical in the z axis by oscillating the axis about it's intended position 
 * after each z move for a small amount of time and with a decaying amplitude. 
 * This allows the axis to 'average out' and settle more accurately on the intended position.
 * When using dithering babysteps must also be enabled. 

 * Dithering has the following options which can be set with M205 D<Dither Amplitude (steps)> T<Dither Time (ms)> H<Dither Minimum Layer Height (mm)>
 * Default is M205 D16 T100 H0.1, ie dither for 16 steps for 100ms with min layer interval of 0.1mm
 * Dither Values are not retained in eeprom (yet) so if change is needed should be manually set with custom g-code at the start of each print. 

 * D = Dither Amplitude (steps) inital amplitude of dither, set to ~0.5-1.5 times the numer of mircosteps (Requires Dither and Babysteps)
 * T = Dither Time (ms) how long to dither for (Requires Dither and Babysteps)
 * H = Dither Minimum layer height (um) minimum layer height interval where dither will be used (ensure compatibility with vase mode) (Requires Dither and Babysteps)
 */

#pragma once

class Dithering
{
public:
    static uint16_t Amplitude; // how many steps for dither
    static uint16_t TimeMS;
    static float MinLayerInterval;
    static float PrevZ;

    static uint16_t DitherSubTime;
    static uint8_t Ditherssteps[4];

    static void Handle(float CurrZ);
    static void CalculateParameters();
};

extern Dithering dithering;
