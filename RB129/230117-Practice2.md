### [Quiz 3](https://launchschool.com/quizzes/ac459ccb)
### q 3 : B, D
### q 4 : A, C, D
### q 7 : B, C
### q 11: B, C, D

### [Quiz 1](https://launchschool.com/quizzes/5a6ad223)
### q 11: B

### [RB129 practice problems (spot wiki)](https://docs.google.com/document/d/10JvX-ArkfF8fIWQu8wPaYt7JJHrv_5E0gM0I2uPirwI/edit)
### q 3 : 
- Output of the first line is "4".  This line invokes the `sides` class method on the class `Square`.  This class method is defined within the `Shape` class, an ancestor class to `Square`.  This class method, defined as `self.sides` will return the value of the constant `SIDES` within the `self` class, which is `Square` in this situation.  Since the `SIDES` constant is not defined within class `Square`, Ruby will search the inheritance chain and next look in class `Quadrilateral`, a superclass of `Square`. In class `Quadrilateral`, there is a constant `SIDES` and the value referenced by that constant - `4` - is returned.
- Output of the second line is "4".  This line invokes the `sides` *instance* method on a new instance (object) of the `Square` class.  Ruby must traverse the method lookup path from `Square`, through `Quadrilateral` to `Shape` before it finds the definition for the `sides` instance method.  This instance method returns `self.class::SIDES`, which in this case is `Square::SIDES`.  To resolve the constant `SIDES`, Ruby again traverses from class `Square` up the inheritance chain looking for the `SIDES` constant.  Again, this constant is defined in the `Quadrilateral` class and the value `4` is returned and passed in as an argument to the `p` invocation.
- Output of the third line is an error.  This line invokes the `describe_shape` method defined within the module `Describable` on a new instance (object) of the `Square` class.  Within the `describe_shape` method, string interpolation requires that the value of the `SIDES` constant be evaluated, however, within the lexical scope of the `Describable` module `SIDES` is not defined.  There are no ancestors to this module either and a definition for `SIDES` cannot be found and an error is raised.
- This demonstrates that constants have lexical scope and that Ruby will traverse the inheritance chain starting from the lexical scope from which the constant was referenced to try and determine its value.
- `self.sides` defines a class method and `self` refers to the calling class.
- The `self` within `self::SIDES` (within the class method) refers to the class of the calling object.
- The `self` within `self.class::SIDES` (within the instance method) refers to the calling object itself (an instance of a class).

### q 7 : 
### q 11: 
### q 23: 
### q 25: 
### q 27: 
### q 28: 
### q 31: 
### q 32: 
### q 35: 
### q 38: 
### q 47: 
### q 50: 
