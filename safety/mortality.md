# Mortality (tweak 29) — nothing depends on one immortal process.
- Logs rotate (1 MiB soul cap). State migrates (pmcp mirror). Servers are
  per-launch; persistence lives in files + cron-owned schedules, never daemons.
- Any process can die; the system reconstitutes from observatory + depots + goals.
