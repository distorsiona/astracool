import httpx

from timezonefinder import TimezoneFinder


class LocationService:
    NOMINATIM_URL = "https://nominatim.openstreetmap.org"

    def __init__(self):
        self.timezone_finder = TimezoneFinder()

    def _headers(self) -> dict[str, str]:
        return {
            "User-Agent": "AstraCool/0.1",
            "Accept": "application/json",
        }

    def _timezone_name(
        self,
        lat: float,
        lon: float,
    ) -> str | None:
        return self.timezone_finder.timezone_at(
            lat=lat,
            lng=lon,
        )

    async def search(
        self,
        query: str,
    ) -> list[dict]:
        params = {
            "q": query,
            "format": "jsonv2",
            "limit": 5,
            "addressdetails": 1,
        }

        async with httpx.AsyncClient(
            timeout=15.0,
        ) as client:
            response = await client.get(
                f"{self.NOMINATIM_URL}/search",
                params=params,
                headers=self._headers(),
            )

        response.raise_for_status()

        results = response.json()

        parsed_results = []

        for item in results:
            lat = float(item["lat"])
            lon = float(item["lon"])

            parsed_results.append(
                {
                    "display_name": item["display_name"],
                    "lat": lat,
                    "lon": lon,
                    "timezone_name": self._timezone_name(
                        lat=lat,
                        lon=lon,
                    ),
                }
            )

        return parsed_results

    async def reverse(
        self,
        lat: float,
        lon: float,
    ) -> dict:
        params = {
            "lat": lat,
            "lon": lon,
            "format": "jsonv2",
            "addressdetails": 1,
        }

        async with httpx.AsyncClient(
            timeout=15.0,
        ) as client:
            response = await client.get(
                f"{self.NOMINATIM_URL}/reverse",
                params=params,
                headers=self._headers(),
            )

        response.raise_for_status()

        data = response.json()

        result_lat = float(data["lat"])
        result_lon = float(data["lon"])

        return {
            "display_name": data.get(
                "display_name",
                "",
            ),
            "lat": result_lat,
            "lon": result_lon,
            "timezone_name": self._timezone_name(
                lat=result_lat,
                lon=result_lon,
            ),
        }


location_service = LocationService()