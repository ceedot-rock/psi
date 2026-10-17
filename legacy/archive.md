# Archive law (tweak 96) — yearly frozen archives, checksummed, stored twice.
Every January: snapshot, sha256 the tarball, keep one copy beside snapshots/
and one in a Hub drive blob (byte-verified on write). The archive is read-only
forever; corrections go in the live system, never in the archive.
