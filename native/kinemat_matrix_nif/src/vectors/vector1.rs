use cgmath;
use rustler::types::{Decoder, Encoder};
use rustler::{Env, NifResult, Term};
use std::ops::{Add, Div, Mul, Rem, Sub};

#[derive(Debug)]
pub struct Vector1(cgmath::Vector1<f64>);

#[derive(Debug, NifStruct)]
#[module = "Kinemat.Vector.Vector1"]
struct ExVector1 {
    x: f64,
}

impl<'a> Decoder<'a> for Vector1 {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        let vec: ExVector1 = term.decode()?;
        Ok(Vector1(cgmath::Vector1::new(vec.x)))
    }
}

impl<'a> Encoder for Vector1 {
    fn encode<'b>(&self, env: Env<'b>) -> Term<'b> {
        let vec = ExVector1 { x: self.0.x };
        vec.encode(env)
    }
}

impl Add for Vector1 {
    type Output = Vector1;

    fn add(self, other: Vector1) -> Vector1 {
        Vector1(self.0 + other.0)
    }
}

impl Sub for Vector1 {
    type Output = Vector1;

    fn sub(self, other: Vector1) -> Vector1 {
        Vector1(self.0 - other.0)
    }
}

impl Mul<f64> for Vector1 {
    type Output = Vector1;

    fn mul(self, other: f64) -> Vector1 {
        Vector1(self.0 * other)
    }
}

impl Div<f64> for Vector1 {
    type Output = Vector1;

    fn div(self, other: f64) -> Vector1 {
        Vector1(self.0 / other)
    }
}

impl Rem<f64> for Vector1 {
    type Output = Vector1;

    fn rem(self, other: f64) -> Vector1 {
        Vector1(self.0 % other)
    }
}
