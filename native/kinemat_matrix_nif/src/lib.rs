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
        ("vector1_add", 2, vector1_add),
        ("vector1_sub", 2, vector1_sub),
        ("vector1_mul", 2, vector1_mul),
        ("vector1_div", 2, vector1_div),
        ("vector1_mod", 2, vector1_mod),
        ("vector2_add", 2, vector2_add),
        ("vector2_sub", 2, vector2_sub),
        ("vector2_mul", 2, vector2_mul),
        ("vector2_div", 2, vector2_div),
        ("vector2_mod", 2, vector2_mod),
        ("vector3_add", 2, vector3_add),
        ("vector3_sub", 2, vector3_sub),
        ("vector3_mul", 2, vector3_mul),
        ("vector3_div", 2, vector3_div),
        ("vector3_mod", 2, vector3_mod),
        ("vector2_perp_dot", 2, vector2_perp_dot),
        ("vector3_cross", 2, vector3_cross),
        ("vector4_add", 2, vector4_add),
        ("vector4_sub", 2, vector4_sub),
        ("vector4_mul", 2, vector4_mul),
        ("vector4_div", 2, vector4_div),
        ("vector4_mod", 2, vector4_mod),
        ("matrix2_add", 2, matrix2_add),
        ("matrix2_sub", 2, matrix2_sub),
        ("matrix2_mul", 2, matrix2_mul),
        ("matrix2_div", 2, matrix2_div),
        ("matrix2_mod", 2, matrix2_mod),
    ],
    None
}

fn vector1_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector1(&args[0])?;
    let rhs = decode_vector1(&args[1])?;
    let result = encode_vector1(env, lhs + rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector1_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector1(&args[0])?;
    let rhs = decode_vector1(&args[1])?;
    let result = encode_vector1(env, lhs - rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector1_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector1(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector1(env, lhs * rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector1_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector1(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector1(env, lhs / rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector1_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector1(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector1(env, lhs % rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector2_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector2(&args[0])?;
    let rhs = decode_vector2(&args[1])?;
    let result = encode_vector2(env, lhs + rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector2_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector2(&args[0])?;
    let rhs = decode_vector2(&args[1])?;
    let result = encode_vector2(env, lhs - rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector2_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector2(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector2(env, lhs * rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector2_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector2(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector2(env, lhs / rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector2_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector2(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector2(env, lhs % rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector3_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector3(&args[0])?;
    let rhs = decode_vector3(&args[1])?;
    let result = encode_vector3(env, lhs + rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector3_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector3(&args[0])?;
    let rhs = decode_vector3(&args[1])?;
    let result = encode_vector3(env, lhs - rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector3_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector3(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector3(env, lhs * rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector3_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector3(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector3(env, lhs / rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector3_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector3(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector3(env, lhs % rhs)?;

    Ok((atoms::ok(), result).encode(env))
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

fn vector4_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector4(&args[0])?;
    let rhs = decode_vector4(&args[1])?;
    let result = encode_vector4(env, lhs + rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector4_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector4(&args[0])?;
    let rhs = decode_vector4(&args[1])?;
    let result = encode_vector4(env, lhs - rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector4_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector4(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector4(env, lhs * rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector4_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector4(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector4(env, lhs / rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn vector4_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_vector4(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_vector4(env, lhs % rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn matrix2_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_matrix2(&args[0])?;
    let rhs = decode_matrix2(&args[1])?;
    let result = encode_matrix2(env, lhs + rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn matrix2_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_matrix2(&args[0])?;
    let rhs = decode_matrix2(&args[1])?;
    let result = encode_matrix2(env, lhs - rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn matrix2_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_matrix2(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_matrix2(env, lhs * rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn matrix2_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_matrix2(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_matrix2(env, lhs / rhs)?;

    Ok((atoms::ok(), result).encode(env))
}

fn matrix2_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs = decode_matrix2(&args[0])?;
    let rhs: f64 = args[1].decode()?;
    let result = encode_matrix2(env, lhs % rhs)?;

    Ok((atoms::ok(), result).encode(env))
}
