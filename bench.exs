alias Kinemat.Matrix.Matrix4

range = 1..100 |> Stream.map(&:erlang.float(&1))

matrix =
  Matrix4.init(
    1.0,
    2.0,
    3.0,
    4.0,
    5.0,
    6.0,
    7.0,
    8.0,
    9.0,
    10.0,
    11.0,
    12.0,
    13.0,
    14.0,
    15.0,
    16.0
  )

Benchee.run(
  %{
    "elixir_matrix_multiplication" => fn -> Enum.each(range, &Matrix4.elixir_mult(matrix, &1)) end,
    "rust_matrix_multiplication" => fn -> Enum.each(range, &Matrix4.rust_mult(matrix, &1)) end
  },
  time: 10,
  memory_time: 2,
  parallel: 4
)
