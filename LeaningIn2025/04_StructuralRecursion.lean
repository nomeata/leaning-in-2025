/-!
Structural recursion
====================

Using recursors to define recursive functions is tedious,
so Lean does that work for us, and we can just define
recursive functions like this:
-/

def add (a b : Nat) : Nat :=
  match a with
  | .zero => b
  | .succ a' => Nat.succ (add a' b)

/-
But under the hood, this is transformed into a non-recursive
definition using the recursor!
-/

/-
Course-of-value recursion
-------------------------

In fact, Lean uses a more powerful translation called
*course-of-value recursion* that allows recursive
calls on deeper subexpression.

Classic example:
-/

def fib (a : Nat) : Nat :=
  match a with
  | 0 => 0
  | 1 => 1
  | Nat.succ (Nat.succ n') =>
    fib n' + fib (Nat.succ n')


/-
Mutual recursion
----------------

Another addition over primitive recursion is support for mutual recursion:
-/

mutual
  def even : Nat → Bool
  | 0 => true
  | Nat.succ n => odd n

  def odd : Nat → Bool
  | 0 => false
  | Nat.succ n => even n
end
