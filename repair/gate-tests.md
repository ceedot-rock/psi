# Gate self-test (tweak 71) — gates test themselves, not just the product.
psi-doctor covers preflight deny/warn/pass shapes, snapshot round-trip, and its
own pipeline semantics (the SIGPIPE case). A gate whose self-test is removed or
weakened fails the doctor by policy: coverage of the gate is the gate.
