use cgmath::{Matrix2, Matrix3, Matrix4, Vector1, Vector2, Vector3, Vector4};
use rustler::{types::atom::Atom, Error, Term};

type DecodeResult<T> = Result<T, Error>;

pub fn decode_vector1<'a>(arg: &Term<'a>) -> DecodeResult<Vector1<f64>> {
    let (_vector1, x): (Atom, f64) = arg.decode()?;
    Ok(Vector1::new(x))
}

pub fn decode_vector2<'a>(arg: &Term<'a>) -> DecodeResult<Vector2<f64>> {
    let (_vector2, x, y): (Atom, f64, f64) = arg.decode()?;
    Ok(Vector2::new(x, y))
}

pub fn decode_vector3<'a>(arg: &Term<'a>) -> DecodeResult<Vector3<f64>> {
    let (_vector3, x, y, z): (Atom, f64, f64, f64) = arg.decode()?;
    Ok(Vector3::new(x, y, z))
}

pub fn decode_vector4<'a>(arg: &Term<'a>) -> DecodeResult<Vector4<f64>> {
    let (_vector4, x, y, z, w): (Atom, f64, f64, f64, f64) = arg.decode()?;
    Ok(Vector4::new(x, y, z, w))
}

pub fn decode_matrix2<'a>(arg: &Term<'a>) -> DecodeResult<Matrix2<f64>> {
    let (_matrix2, (_vector2_x, xx, xy), (_vector2_y, yx, yy)): (
        Atom,
        (Atom, f64, f64),
        (Atom, f64, f64),
    ) = arg.decode()?;

    Ok(Matrix2::new(xx, xy, yx, yy))
}

pub fn decode_matrix3<'a>(arg: &Term<'a>) -> DecodeResult<Matrix3<f64>> {
    let (_matrix3, (_vector3_x, xx, xy, xz), (_vector3_y, yx, yy, yz), (_vector3_z, zx, zy, zz)) : (Atom, (Atom, f64, f64, f64), (Atom, f64, f64, f64), (Atom, f64, f64, f64)) = arg.decode()?;

    Ok(Matrix3::new(xx, xy, xz, yx, yy, yz, zx, zy, zz))
}

pub fn decode_matrix4<'a>(arg: &Term<'a>) -> DecodeResult<Matrix4<f64>> {
    let (
        _matrix4,
        (_vector4_x, xx, xy, xz, xw),
        (_vector4_y, yx, yy, yz, yw),
        (_vector4_z, zx, zy, zz, zw),
        (_vector4_w, wx, wy, wz, ww),
    ): (
        Atom,
        (Atom, f64, f64, f64, f64),
        (Atom, f64, f64, f64, f64),
        (Atom, f64, f64, f64, f64),
        (Atom, f64, f64, f64, f64),
    ) = arg.decode()?;

    Ok(Matrix4::new(
        xx, xy, xz, xw, yx, yy, yz, yw, zx, zy, zz, zw, wx, wy, wz, ww,
    ))
}
