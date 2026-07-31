import Lake
open Lake DSL

package «lib» where
  leanOptions := #[⟨`relaxedAutoImplicit, true⟩]

@[default_target]
lean_lib SystemE {
}

require mathlib from git "https://github.com/leanprover-community/mathlib4" @ "v4.19.0"

require checkdecls from git "https://github.com/PatrickMassot/checkdecls.git"

meta if get_config? env = some "dev" then
require «doc-gen4» from git
  "https://github.com/leanprover/doc-gen4" @ "main"
