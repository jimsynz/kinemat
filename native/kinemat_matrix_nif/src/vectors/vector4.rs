use cgmath;
use rustler::types::{Decoder, Encoder};
use rustler::{Env, NifResult, Term};
use std::ops::{Add, Div, Mul, Rem, Sub};

#[derive(Debug)]
pub struct Vector4(cgmath::Vector4<f64>);

#[derive(Debug, NifStruct)]
#[module = "Kinemat.Vector.Vector4"]
pub struct ExVector4 {
    pub x: f64,
    pub y: f64,
    pub z: f64,
    pub w: f64,
}

impl<'a> Decoder<'a> for Vector4 {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        let vec: ExVector4 = term.decode()?;
        Ok(Vector4(cgmath::Vector4::new(vec.x, vec.y, vec.z, vec.w)))
    }
}

impl<'a> Encoder for Vector4 {
    fn encode<'b>(&self, env: Env<'b>) -> Term<'b> {
        let vec = ExVector4 {
            x: self.0.x,
            y: self.0.y,
            z: self.0.z,
            w: self.0.w,
        };
        vec.encode(env)
    }
}

impl Add for Vector4 {
    type Output = Vector4;

    fn add(self, other: Vector4) -> Vector4 {
        Vector4(self.0 + other.0)
    }
}

impl Sub for Vector4 {
    type Output = Vector4;

    fn sub(self, other: Vector4) -> Vector4 {
        Vector4(self.0 - other.0)
    }
}

impl Mul<f64> for Vector4 {
    type Output = Vector4;

    fn mul(self, other: f64) -> Vector4 {
        Vector4(self.0 * other)
    }
}

impl Div<f64> for Vector4 {
    type Output = Vector4;

    fn div(self, other: f64) -> Vector4 {
        Vector4(self.0 / other)
    }
}

impl Rem<f64> for Vector4 {
    type Output = Vector4;

    fn rem(self, other: f64) -> Vector4 {
        Vector4(self.0 % other)
    }
}
