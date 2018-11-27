use cgmath::{Matrix2, Matrix3, Matrix4, Vector1, Vector2, Vector3, Vector4};
use crate::atoms;
use rustler::{types::atom::Atom, Encoder, Env, Error, NifResult, Term};

pub fn encode_vector1<'a>(env: Env<'a>, vector: Vector1<f64>) -> NifResult<Term<'a>> {
    Ok((atoms::vector1(), vector.x).encode(env))
}

pub fn encode_vector2<'a>(env: Env<'a>, vector: Vector2<f64>) -> NifResult<Term<'a>> {
    Ok((atoms::vector2(), vector.x, vector.y).encode(env))
}

pub fn encode_vector3<'a>(env: Env<'a>, vector: Vector3<f64>) -> NifResult<Term<'a>> {
    Ok((atoms::vector3(), vector.x, vector.y, vector.z).encode(env))
}

pub fn encode_vector4<'a>(env: Env<'a>, vector: Vector4<f64>) -> NifResult<Term<'a>> {
    Ok((atoms::vector4(), vector.x, vector.y, vector.z, vector.w).encode(env))
}

pub fn encode_matrix2<'a>(env: Env<'a>, matrix: Matrix2<f64>) -> NifResult<Term<'a>> {
    Ok((
        atoms::matrix2(),
        (atoms::vector2(), matrix.x.x, matrix.x.y),
        (atoms::vector2(), matrix.y.x, matrix.y.y),
    )
        .encode(env))
}

pub fn encode_matrix3<'a>(env: Env<'a>, matrix: Matrix3<f64>) -> NifResult<Term<'a>> {
    Ok((
        atoms::matrix3(),
        (atoms::vector3(), matrix.x.x, matrix.x.y, matrix.x.z),
        (atoms::vector3(), matrix.y.x, matrix.y.y, matrix.y.z),
        (atoms::vector3(), matrix.z.x, matrix.z.y, matrix.z.z),
    )
        .encode(env))
}

pub fn encode_matrix4<'a>(env: Env<'a>, matrix: Matrix4<f64>) -> NifResult<Term<'a>> {
    Ok((
        atoms::matrix4(),
        (
            atoms::vector4(),
            matrix.x.x,
            matrix.x.y,
            matrix.x.z,
            matrix.x.w,
        ),
        (
            atoms::vector4(),
            matrix.y.x,
            matrix.y.y,
            matrix.y.z,
            matrix.y.w,
        ),
        (
            atoms::vector4(),
            matrix.z.x,
            matrix.z.y,
            matrix.z.z,
            matrix.z.w,
        ),
        (
            atoms::vector4(),
            matrix.w.x,
            matrix.w.y,
            matrix.w.z,
            matrix.w.w,
        ),
    )
        .encode(env))
}
