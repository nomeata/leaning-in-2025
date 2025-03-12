/-!

Compiler vs. Kernel
===================

So far we only talked about Lean the theorem prover,
and various ways to get recursive definitions into a
form the kernel accepts.

Lean is also a programming language, and can compile
to native code. The compiler is used when
* compiling programs (duh)
* using `#eval` to evalute expressions
* using `by native_decide` in proofs.


The compiler supports recursion, and sees the definitions
before the structural/well-founded/partial fixpoint machinery
kicks in. To the compiler, the following are identical:
-/

def add₁ : (a b : Nat) → Option Nat
| .zero, b => b
| .succ a', b => Nat.succ <$> add₁ a' b
termination_by structural a => a

def add₂ : (a b : Nat) → Option Nat
| .zero, b => b
| .succ a', b => Nat.succ <$> add₂ a' b
termination_by a => a -- well-founded recursion

def add₃ : (a b : Nat) → Option Nat
| .zero, b => b
| .succ a', b => Nat.succ <$> add₃ a' b
partial_fixpoint

/-
Ignoring the kernel
-------------------

There are two variants useful when one does not plan to proof
things about the defintion anyways.

`partial`
---------

* Function may use unrestricted recursion
* Definition exists in the kernel, but completely opaque
* Type has to be inhabited
* `partial` *is not* infectous

Often used in programs (Lean itself is full of it)
-/

partial def add₄ : (a b : Nat) → Option Nat
| .zero, b => b
| .succ a', b => Nat.succ <$> add₄ a' b

/--
`unsafe`
--------

* Function may use unrestricted recursion
* Other `unsafe` features are available
* Definition not visible in the kernel
* `unsafe` *is* infectous
-/

unsafe def add₅ : (a b : Nat) → Option Nat
| .zero, b => b
| .succ a', b => Nat.succ <$> add₅ a' b
