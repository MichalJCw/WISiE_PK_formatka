"""Straty ciśnienia w przewodzie według wzoru Darcy'ego-Weisbacha.

Współczynnik oporów liniowych wyznaczany jest iteracyjnie
z równania Colebrooka-White'a.
"""
import math


def wspolczynnik_tarcia(Re, k, D, tol=1e-8, max_iter=50):
    """Współczynnik oporów liniowych [-] dla przepływu burzliwego."""
    lam = 0.02  # wartość startowa
    for _ in range(max_iter):
        nowa = (-2.0 * math.log10(2.51 / (Re * math.sqrt(lam))
                                  + k / (3.71 * D))) ** -2
        if abs(nowa - lam) < tol:
            return nowa
        lam = nowa
    raise RuntimeError("Brak zbieżności iteracji Colebrooka-White'a")


def strata_cisnienia(w, D, L, k, rho=998.0, nu=1.0e-6):
    """Strata ciśnienia [Pa] na odcinku o długości L [m]."""
    Re = w * D / nu
    if Re < 2300:
        lam = 64.0 / Re  # przepływ laminarny
    else:
        lam = wspolczynnik_tarcia(Re, k, D)
    return lam * L / D * rho * w ** 2 / 2.0


if __name__ == "__main__":
    # Rura stalowa DN100: D = 0,1071 m, k = 0,2 mm, L = 250 m, w = 1,2 m/s
    dp = strata_cisnienia(w=1.2, D=0.1071, L=250.0, k=0.0002)
    print(f"Strata ciśnienia: {dp / 1000:.1f} kPa")
