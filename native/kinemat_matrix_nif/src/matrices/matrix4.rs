use cgmath;
use crate::vectors::ExVector4;
use rustler::types::{Decoder, Encoder};
use rustler::{Env, NifResult, Term};
use std::ops::{Add, Div, Mul, Rem, Sub};

#[derive(Debug)]
pub struct Matrix4(cgmath::Matrix4<f64>);

#[derive(Debug, NifStruct)]
#[module = "Kinemat.Matrix.Matrix4"]
struct ExMatrix4 {
    x: ExVector4,
    y: ExVector4,
    z: ExVector4,
    w: ExVector4,
}

impl<'a> Decoder<'a> for Matrix4 {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        let m: ExMatrix4 = term.decode()?;
        Ok(Matrix4(cgmath::Matrix4::new(
            m.x.x, m.x.y, m.x.z, m.x.w, m.y.x, m.y.y, m.y.z, m.y.w, m.z.x, m.z.y, m.z.z, m.z.w,
            m.w.x, m.w.y, m.w.z, m.w.w,
        )))
    }
}

impl<'a> Encoder for Matrix4 {
    fn encode<'b>(&self, env: Env<'b>) -> Term<'b> {
        let m = ExMatrix4 {
            x: ExVector4 {
                x: self.0.x.x,
                y: self.0.x.y,
                z: self.0.x.z,
                w: self.0.x.w,
            },
            y: ExVector4 {
                x: self.0.y.x,
                y: self.0.y.y,
                z: self.0.y.z,
                w: self.0.y.w,
            },
            z: ExVector4 {
                x: self.0.z.x,
                y: self.0.z.y,
                z: self.0.z.z,
                w: self.0.z.w,
            },
            w: ExVector4 {
                x: self.0.w.x,
                y: self.0.w.y,
                z: self.0.w.z,
                w: self.0.w.w,
            },
        };
        m.encode(env)
    }
}

impl Add for Matrix4 {
    type Output = Matrix4;

    fn add(self, other: Matrix4) -> Matrix4 {
        Matrix4(self.0 + other.0)
    }
}

impl Sub for Matrix4 {
    type Output = Matrix4;

    fn sub(self, other: Matrix4) -> Matrix4 {
        Matrix4(self.0 - other.0)
    }
}

impl Mul<f64> for Matrix4 {
    type Output = Matrix4;

    fn mul(self, other: f64) -> Matrix4 {
        Matrix4(self.0 * other)
    }
}

impl Div<f64> for Matrix4 {
    type Output = Matrix4;

    fn div(self, other: f64) -> Matrix4 {
        Matrix4(self.0 / other)
    }
}

impl Rem<f64> for Matrix4 {
    type Output = Matrix4;

    fn rem(self, other: f64) -> Matrix4 {
        Matrix4(self.0 % other)
    }
}
