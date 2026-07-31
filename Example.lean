import SystemE

namespace LeanEuclid.Example

theorem line_contains_a_point (L : Line) : ∃ p : Point, p.onLine L := by
  euclid_apply (line_nonempty L) as p
  exact ⟨p, by assumption⟩

theorem distinct_point_on_line (L : Line) (p : Point) : ∃ q : Point, p ≠ q ∧ q.onLine L := by
  euclid_apply (exists_distincts_points_on_line L p) as q
  exact ⟨q, by constructor <;> assumption⟩

theorem circle_with_centre_and_point (a b : Point) (hne : a ≠ b) :
    ∃ α : Circle, a.isCentre α ∧ b.onCircle α := by
  euclid_apply (circle_from_points a b hne) as α
  exact ⟨α, by constructor <;> assumption⟩

end LeanEuclid.Example
