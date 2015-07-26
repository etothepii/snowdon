//
//  OSGB36.swift
//  MapProgress
//
//  Created by James Robinson on 26/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class OSGB36: LatLon {
    
    private let a = 6377563.396;
    private let b = 6356256.909;
    
    init(point: CartesianPoint) {
        super.init(point: point, a: a, b: b);
    }
    
    override init(latitude: Double, longitude: Double) {
        super.init(latitude: latitude, longitude: longitude)
    }
    
    override func getExcentrictyA() -> Double{
        return a;
    }
    
    override func getExcentrictyB() -> Double {
        return b;
    }
    
    override func toOSGrid() -> OSGrid {
    
        let φ = getLatitudeInRadians();
        let λ = getLongitudeInRadians();
        
        let a = getExcentrictyA();
        let b = getExcentrictyB();                         // Airy 1830 major & minor semi-axes
        let F0 = 0.9996012717;                             // NatGrid scale factor on central meridian
        let φ0 = Translator.toRadians(49);
        let λ0 = Translator.toRadians(-2);                 // NatGrid true origin is 49°N,2°W
        let N0: Double = -100000;
        let E0: Double = 400000;                           // northing & easting of true origin, metres
        let e2 = 1 - (b*b)/(a*a);                          // eccentricity squared
        let n = (a-b)/(a+b);                               // n
        let n2 = n*n;                                      // n²
        let n3 = n*n*n;                                    // n³
        
        let cosφ = cos(φ);
        let sinφ = sin(φ);
        let ν = a*F0/sqrt(1-e2*sinφ*sinφ);                 // nu = transverse radius of curvature
        let ρ = a*F0*(1-e2)/pow(1-e2*sinφ*sinφ, 1.5);      // rho = meridional radius of curvature
        let η2 = ν/ρ-1;                                    // eta = ?
        
        let Ma = (1 + n + (5/4)*n2 + (5/4)*n3) * (φ-φ0);
        let Mb_1 = (3*n + 3*n2 + 2.625*n3)
        let Mb = Mb_1 * sin(φ-φ0) * cos(φ+φ0);
        let Mc = (1.875*n2 + 1.875*n3) * sin(2*(φ-φ0)) * cos(2*(φ+φ0));
        let Md = (35/24)*n3 * sin(3*(φ-φ0)) * cos(3*(φ+φ0));
        let M = b * F0 * (Ma - Mb + Mc - Md);              // meridional arc
        
        let cos3φ = cosφ*cosφ*cosφ;
        let cos5φ = cos3φ*cosφ*cosφ;
        let tan2φ = tan(φ)*tan(φ);
        let tan4φ = tan2φ*tan2φ;
        
        let I = M + N0;
        let II = (ν/2)*sinφ*cosφ;
        let III = (ν/24)*sinφ*cos3φ*(5-tan2φ+9*η2);
        let IIIA = (ν/720)*sinφ*cos5φ*(61-58*tan2φ+tan4φ);
        let IV = ν*cosφ;
        let V = (ν/6)*cos3φ*(ν/ρ-tan2φ);
        let VI = (ν/120) * cos5φ * (5 - 18*tan2φ + tan4φ + 14*η2 - 58*tan2φ*η2);
        
        let Δλ = λ-λ0;
        let Δλ2 = Δλ*Δλ, Δλ3 = Δλ2*Δλ, Δλ4 = Δλ3*Δλ, Δλ5 = Δλ4*Δλ, Δλ6 = Δλ5*Δλ;
        
        var N = I + II*Δλ2 + III*Δλ4 + IIIA*Δλ6;
        let E_1 = E0 + IV*Δλ;
        let E_2 = V*Δλ3 + VI*Δλ5
        var E = E_1 + E_2;
        
        N = round(1000*N)/1000;                             // round to mm precision
        E = round(1000*E)/1000;
        
        return OSGrid(easting: E, northing: N); // gets truncated to SW corner of 1m grid square
    }
}
