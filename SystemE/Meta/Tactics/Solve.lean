import SystemE.Meta.Tactics.Util

set_option autoImplicit false

open Lean Elab Tactic Meta

namespace SystemE.Tactics

private def runEuclidFinish : TacticM Unit := do
  evalTactic $ ← `(tactic| try simp_all)
  evalTactic $ ← `(tactic| first | assumption | rfl)

/--
The `euclid_finish` tactic performs lightweight local proof cleanup.
It does not invoke external solvers or automatic prover backends.
-/
def EuclidFinish : TacticM Unit :=
  withMainContext runEuclidFinish

syntax "euclid_finish" : tactic

elab "euclid_finish" : tactic => EuclidFinish

/--
`euclid_apply` performs forward reasoning from an explicit proof term.
For existential construction rules, use `as` to name the witnesses.
-/
def EuclidApply (rule : Term) (idents : Array Ident)  : TacticM Unit := do
  let hnm ← getUnusedUserName `h
  if idents.isEmpty then
    evalTactic $ ← `(tactic| have $(mkIdent hnm) := $rule)
  else
    evalTactic $ ← `(tactic| obtain ⟨$idents,*, ($(mkIdent hnm))⟩ := $rule)
  elimAllConjunctions
  EuclidFinish <|> pure ()

syntax "euclid_apply" term : tactic

syntax "euclid_apply" term "as" ident : tactic

syntax "euclid_apply" term "as" "(" ident,+ ")" : tactic

syntax "euclid_assert" term : tactic

elab_rules : tactic
  | `(tactic| euclid_apply $t as $i) =>
    withMainContext $ EuclidApply t #[i]
  | `(tactic| euclid_apply $t as ($is,*)) =>
    withMainContext $ EuclidApply t is
  | `(tactic| euclid_apply $t) =>
    withMainContext $ EuclidApply t #[]

macro_rules
  | `(tactic| euclid_assert $t) => `(tactic| have : $t := by euclid_finish)

end SystemE.Tactics
