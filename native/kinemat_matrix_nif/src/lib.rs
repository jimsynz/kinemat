#[macro_use]
extern crate rustler;

#[macro_use]
extern crate rustler_codegen;

#[macro_use]
extern crate lazy_static;

extern crate cgmath;

mod matrices;
mod vectors;

use matrices::{Matrix2, Matrix3, Matrix4};
use rustler::{Encoder, Env, NifResult, Term};
use vectors::{Vector1, Vector2, Vector3, Vector4};

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

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
        ("vector2_perp_dot", 2, vector2_perp_dot),
        ("vector3_add", 2, vector3_add),
        ("vector3_sub", 2, vector3_sub),
        ("vector3_mul", 2, vector3_mul),
        ("vector3_div", 2, vector3_div),
        ("vector3_mod", 2, vector3_mod),
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
        ("matrix3_add", 2, matrix3_add),
        ("matrix3_sub", 2, matrix3_sub),
        ("matrix3_mul", 2, matrix3_mul),
        ("matrix3_div", 2, matrix3_div),
        ("matrix3_mod", 2, matrix3_mod),
        ("matrix4_add", 2, matrix4_add),
        ("matrix4_sub", 2, matrix4_sub),
        ("matrix4_mul", 2, matrix4_mul),
        ("matrix4_div", 2, matrix4_div),
        ("matrix4_mod", 2, matrix4_mod),
    ],
    None
}

fn vector1_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector1 = args[0].decode()?;
    let rhs: Vector1 = args[1].decode()?;
    let result = lhs + rhs;

    Ok(result.encode(env))
}

fn vector1_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector1 = args[0].decode()?;
    let rhs: Vector1 = args[1].decode()?;
    let result = lhs - rhs;

    Ok(result.encode(env))
}

fn vector1_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector1 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs * rhs;

    Ok(result.encode(env))
}

fn vector1_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector1 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs / rhs;

    Ok(result.encode(env))
}

fn vector1_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector1 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs % rhs;

    Ok(result.encode(env))
}

fn vector2_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector2 = args[0].decode()?;
    let rhs: Vector2 = args[1].decode()?;
    let result = lhs + rhs;

    Ok(result.encode(env))
}

fn vector2_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector2 = args[0].decode()?;
    let rhs: Vector2 = args[1].decode()?;
    let result = lhs - rhs;

    Ok(result.encode(env))
}

fn vector2_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector2 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs * rhs;

    Ok(result.encode(env))
}

fn vector2_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector2 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs / rhs;

    Ok(result.encode(env))
}

fn vector2_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector2 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs % rhs;

    Ok(result.encode(env))
}

fn vector2_perp_dot<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector2 = args[0].decode()?;
    let rhs: Vector2 = args[1].decode()?;
    let result = lhs.perp_dot(rhs);

    Ok(result.encode(env))
}

fn vector3_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector3 = args[0].decode()?;
    let rhs: Vector3 = args[1].decode()?;
    let result = lhs + rhs;

    Ok(result.encode(env))
}

fn vector3_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector3 = args[0].decode()?;
    let rhs: Vector3 = args[1].decode()?;
    let result = lhs - rhs;

    Ok(result.encode(env))
}

fn vector3_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector3 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs * rhs;

    Ok(result.encode(env))
}

fn vector3_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector3 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs / rhs;

    Ok(result.encode(env))
}

fn vector3_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector3 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs % rhs;

    Ok(result.encode(env))
}

fn vector3_cross<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector3 = args[0].decode()?;
    let rhs: Vector3 = args[1].decode()?;
    let result = lhs.cross(rhs);

    Ok(result.encode(env))
}

fn vector4_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector4 = args[0].decode()?;
    let rhs: Vector4 = args[1].decode()?;
    let result = lhs + rhs;

    Ok(result.encode(env))
}

fn vector4_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector4 = args[0].decode()?;
    let rhs: Vector4 = args[1].decode()?;
    let result = lhs - rhs;

    Ok(result.encode(env))
}

fn vector4_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector4 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs * rhs;

    Ok(result.encode(env))
}

fn vector4_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector4 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs / rhs;

    Ok(result.encode(env))
}

fn vector4_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Vector4 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs % rhs;

    Ok(result.encode(env))
}

fn matrix2_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix2 = args[0].decode()?;
    let rhs: Matrix2 = args[1].decode()?;
    let result = lhs + rhs;

    Ok(result.encode(env))
}

fn matrix2_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix2 = args[0].decode()?;
    let rhs: Matrix2 = args[1].decode()?;
    let result = lhs - rhs;

    Ok(result.encode(env))
}

fn matrix2_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix2 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs * rhs;

    Ok(result.encode(env))
}

fn matrix2_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix2 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs / rhs;

    Ok(result.encode(env))
}

fn matrix2_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix2 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs % rhs;

    Ok(result.encode(env))
}

fn matrix3_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix3 = args[0].decode()?;
    let rhs: Matrix3 = args[1].decode()?;
    let result = lhs + rhs;

    Ok(result.encode(env))
}

fn matrix3_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix3 = args[0].decode()?;
    let rhs: Matrix3 = args[1].decode()?;
    let result = lhs - rhs;

    Ok(result.encode(env))
}

fn matrix3_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix3 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs * rhs;

    Ok(result.encode(env))
}

fn matrix3_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix3 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs / rhs;

    Ok(result.encode(env))
}

fn matrix3_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix3 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs % rhs;

    Ok(result.encode(env))
}

fn matrix4_add<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix4 = args[0].decode()?;
    let rhs: Matrix4 = args[1].decode()?;
    let result = lhs + rhs;

    Ok(result.encode(env))
}

fn matrix4_sub<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix4 = args[0].decode()?;
    let rhs: Matrix4 = args[1].decode()?;
    let result = lhs - rhs;

    Ok(result.encode(env))
}

fn matrix4_mul<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix4 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs * rhs;

    Ok(result.encode(env))
}

fn matrix4_div<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix4 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs / rhs;

    Ok(result.encode(env))
}

fn matrix4_mod<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let lhs: Matrix4 = args[0].decode()?;
    let rhs: f64 = args[1].decode()?;
    let result = lhs % rhs;

    Ok(result.encode(env))
}
