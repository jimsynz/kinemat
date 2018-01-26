# Kinemat

Kinemat is the beginnings of a library for solving forward and reverse
kinematics of robotic systems and graphical simulations.

## Installation

As this package currently doesn't do what it says on the tin, I've not
published a version to [hex](https://hex.pm) yet. Maybe when it looks
more complete.

For now, you can install it as a Git dependency:

```elixir
def deps do
  [{:kinemat, "~> 0.1.0"}]
end
```

## Usage

### Representing angles regardless of unit

Since Angles are probably something you want to use we use the
[angle](https://hex.pm/packages/angle) package to store and convert between
different types of angles.

Most usefully you can use the `~a` sigil to create angles in different units.
See the [angle docs](https://hexdocs.pm/angle/api-reference.html) for more
information.

### Representing spacial coordinates

Kinemat uses the `Point` protocol to handle manipulations of spacial
coordinates.  The protocol is implemented by `Cartesian`, `Cylindrical` and
`Spherical`.

    iex> use Kinemat
    ...> use Kinemat.Coordinates
    ...> Cartesian.init(3,4,5)
    ...> |> Point.to_cylindrical()
    #Kinemat.Point<[azimuth: #Angle<0.9272952180016122㎭>,
                    radial: 5.0,
                    vertical: 5]>

### Representing spacial orientations

Kinemat uses the `Orientation` module to allow manipulations and conversions
between the three primary orientation modules; `Euler`, `RotationMatrix` and
`Quaternion`.

Note that not all `Euler` orders are supported, but only so-called "Tait-Bryan"
angles.

    iex> use Kinemat
    ...> use Kinemat.Orientations
    ...> Euler.init(:xyz, ~a(10)d, ~a(20)d, ~a(30)d)
    ...> |> Orientation.to_quaternion()
    #Kinemat.Orientation<[
      type: :quaternion,
      w: #Angle<0.943714364147489㎭>,
      x: 0.12767944069578063,
      y: 0.14487812541736914,
      z: 0.2685358227515692
    ]>

### Representing frames of reference

Kinemat can build a `Frame` given the combination of an `Orientation` and a `Point`;

    iex> use Kinemat
    ...> point = Kinemat.Coordinates.Cylindrical.init(10, ~a(20)d, 30)
    ...> orientation = Kinemat.Orientations.Euler.init(:xyz, ~a(10)d, ~a(20)d, ~a(30)d)
    ...> frame = Frame.init(point, orientation)
    #Kinemat.Frame<[
      orientation: #Kinemat.Orientation<[
        euler: :xyz,
        x: #Angle<10°>,
        y: #Angle<20°>,
        z: #Angle<30°>
      ]>,
      point: #Kinemat.Point<[azimuth: #Angle<20°>, radial: 10, vertical: 30]>
    ]>

And frames can be converted to homogeneous transformations

    ...> Kinemat.HomogeneousTransformation.to_homogeneous_transformation(frame)
    { 0.8137976813493738,  0.5438381424823255, -0.20487412870286215,  9.396926207859085,
     -0.46984631039295416, 0.823172944645501,   0.3187957775971678,   3.420201433256687,
      0.3420201433256687, -0.16317591116653482, 0.9254165783983234,  30,
      0.0,                 0.0,                 0.0,                  1.0}

### Representing joints

Kinemat can build `Revolute`, `Cylindrical` and `Prismatic` joints starting
with a frame and extra information based on the kind of joint in use.

    iex> use Kinemat
    ...> use Kinemat.Joints
    ...> Revolute.init(Frame.zero(), limits: {~a(-10)d, ~a(10)d})
    %Kinemat.Joints.Revolute{
      frame: #Kinemat.Frame<[
        orientation: #Kinemat.Orientation<[
          euler: :xyz,
          x: #Angle<0>,
          y: #Angle<0>,
          z: #Angle<0>
        ]>,
        point: #Kinemat.Point<[x: 0, y: 0, z: 0]>
      ]>,
      limits: {#Angle<-10°>, #Angle<10°>},
      position: #Angle<-10°>
    }

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/kinemat](https://hexdocs.pm/kinemat).
