# Key material (tweaks 165-168) — lifetimes, rotation, seeds.
- Key material gets a lifetime, not just a location: record expiry alongside where it lives.
- Sign-then-verify smoke in every rotation: prove the new key signs and verifies before cutting over.
- Rotation invalidates everyone: say so upfront, and re-issue to every holder.
- Never ask for seeds: this holds for every session, no exceptions.
