use cgmath;
use crate::vectors::ExVector2;
use rustler::types::{Decoder, Encoder};
use rustler::{Env, NifResult, Term};
use std::ops::{Add, Div, Mul, Rem, Sub};

#[derive(Debug)]
pub struct Matrix2(cgmath::Matrix2<f64>);

#[derive(Debug, NifStruct)]
#[module = "Kinemat.Matrix.Matrix2"]
struct ExMatrix2 {
    x: ExVector2,
    y: ExVector2,
}

impl<'a> Decoder<'a> for Matrix2 {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        let m: ExMatrix2 = term.decode()?;
        Ok(Matrix2(cgmath::Matrix2::new(m.x.x, m.x.y, m.y.x, m.y.y)))
    }
}

impl<'a> Encoder for Matrix2 {
    fn encode<'b>(&self, env: Env<'b>) -> Term<'b> {
        let m = ExMatrix2 {
            x: ExVector2 {
                x: self.0.x.x,
                y: self.0.x.y,
            },
            y: ExVector2 {
                x: self.0.y.x,
                y: self.0.y.y,
            },
        };
        m.encode(env)
    }
}

impl Add for Matrix2 {
    type Output = Matrix2;

    fn add(self, other: Matrix2) -> Matrix2 {
        Matrix2(self.0 + other.0)
    }
}

impl Sub for Matrix2 {
    type Output = Matrix2;

    fn sub(self, other: Matrix2) -> Matrix2 {
        Matrix2(self.0 - other.0)
    }
}

impl Mul<f64> for Matrix2 {
    type Output = Matrix2;

    fn mul(self, other: f64) -> Matrix2 {
        Matrix2(self.0 * other)
    }
}

impl Div<f64> for Matrix2 {
    type Output = Matrix2;

    fn div(self, other: f64) -> Matrix2 {
        Matrix2(self.0 / other)
    }
}

impl Rem<f64> for Matrix2 {
    type Output = Matrix2;

    fn rem(self, other: f64) -> Matrix2 {
        Matrix2(self.0 % other)
    }
}
