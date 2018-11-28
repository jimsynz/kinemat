use cgmath;
use crate::vectors::ExVector3;
use rustler::types::{Decoder, Encoder};
use rustler::{Env, NifResult, Term};
use std::ops::{Add, Div, Mul, Rem, Sub};

#[derive(Debug)]
pub struct Matrix3(cgmath::Matrix3<f64>);

#[derive(Debug, NifStruct)]
#[module = "Kinemat.Matrix.Matrix3"]
struct ExMatrix3 {
    x: ExVector3,
    y: ExVector3,
    z: ExVector3,
}

impl<'a> Decoder<'a> for Matrix3 {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        let m: ExMatrix3 = term.decode()?;
        Ok(Matrix3(cgmath::Matrix3::new(
            m.x.x, m.x.y, m.x.z, m.y.x, m.y.y, m.y.z, m.z.x, m.z.y, m.z.z,
        )))
    }
}

impl<'a> Encoder for Matrix3 {
    fn encode<'b>(&self, env: Env<'b>) -> Term<'b> {
        let m = ExMatrix3 {
            x: ExVector3 {
                x: self.0.x.x,
                y: self.0.x.y,
                z: self.0.x.z,
            },
            y: ExVector3 {
                x: self.0.y.x,
                y: self.0.y.y,
                z: self.0.y.z,
            },
            z: ExVector3 {
                x: self.0.z.x,
                y: self.0.z.y,
                z: self.0.z.z,
            },
        };
        m.encode(env)
    }
}

impl Add for Matrix3 {
    type Output = Matrix3;

    fn add(self, other: Matrix3) -> Matrix3 {
        Matrix3(self.0 + other.0)
    }
}

impl Sub for Matrix3 {
    type Output = Matrix3;

    fn sub(self, other: Matrix3) -> Matrix3 {
        Matrix3(self.0 - other.0)
    }
}

impl Mul<f64> for Matrix3 {
    type Output = Matrix3;

    fn mul(self, other: f64) -> Matrix3 {
        Matrix3(self.0 * other)
    }
}

impl Div<f64> for Matrix3 {
    type Output = Matrix3;

    fn div(self, other: f64) -> Matrix3 {
        Matrix3(self.0 / other)
    }
}

impl Rem<f64> for Matrix3 {
    type Output = Matrix3;

    fn rem(self, other: f64) -> Matrix3 {
        Matrix3(self.0 % other)
    }
}
