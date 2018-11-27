#[macro_use]
extern crate rustler;

#[macro_use]
extern crate rustler_codegen;

#[macro_use]
extern crate lazy_static;

#[macro_use]
extern crate cgmath;

mod decode;
mod encode;

use decode::*;
use encode::*;

use cgmath::{Matrix2, Matrix3, Matrix4, Vector1, Vector2, Vector3, Vector4};
use rustler::{types::atom::Atom, Encoder, Env, Error, NifResult, Term};

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
        atom vector1;
        atom vector2;
        atom vector3;
        atom vector4;
        atom matrix2;
        atom matrix3;
        atom matrix4;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

type DecodeResult<T> = Result<T, Error>;

rustler_export_nifs! {
    "Elixir.Kinemat.MatrixNif",
    [
        ("vector2_perp_dot", 2, vector2_perp_dot),
        ("vector3_cross", 2, vector3_cross),
    ],
    None
}

fn vector2_perp_dot<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector2(&args[0])?;
    let rhs = decode_vector2(&args[1])?;
    let result = lhs.perp_dot(rhs);

    Ok((atoms::ok(), result).encode(env))
}

fn vector3_cross<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector3(&args[0])?;
    let rhs = decode_vector3(&args[1])?;
    let result = lhs.cross(rhs);
    let vec = encode_vector3(env, result)?;

    Ok((atoms::ok(), vec).encode(env))
}
