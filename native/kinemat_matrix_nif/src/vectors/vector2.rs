use cgmath;
use rustler::types::{Decoder, Encoder};
use rustler::{Env, NifResult, Term};
use std::ops::{Add, Div, Mul, Rem, Sub};

#[derive(Debug)]
pub struct Vector2(cgmath::Vector2<f64>);

impl Vector2 {
    pub fn perp_dot(&self, other: Vector2) -> f64 {
        self.0.perp_dot(other.0)
    }
}

#[derive(Debug, NifStruct)]
#[module = "Kinemat.Vector.Vector2"]
pub struct ExVector2 {
    pub x: f64,
    pub y: f64,
}

impl<'a> Decoder<'a> for Vector2 {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        let vec: ExVector2 = term.decode()?;
        Ok(Vector2(cgmath::Vector2::new(vec.x, vec.y)))
    }
}

impl<'a> Encoder for Vector2 {
    fn encode<'b>(&self, env: Env<'b>) -> Term<'b> {
        let vec = ExVector2 {
            x: self.0.x,
            y: self.0.y,
        };
        vec.encode(env)
    }
}

impl Add for Vector2 {
    type Output = Vector2;

    fn add(self, other: Vector2) -> Vector2 {
        Vector2(self.0 + other.0)
    }
}

impl Sub for Vector2 {
    type Output = Vector2;

    fn sub(self, other: Vector2) -> Vector2 {
        Vector2(self.0 - other.0)
    }
}

impl Mul<f64> for Vector2 {
    type Output = Vector2;

    fn mul(self, other: f64) -> Vector2 {
        Vector2(self.0 * other)
    }
}

impl Div<f64> for Vector2 {
    type Output = Vector2;

    fn div(self, other: f64) -> Vector2 {
        Vector2(self.0 / other)
    }
}

impl Rem<f64> for Vector2 {
    type Output = Vector2;

    fn rem(self, other: f64) -> Vector2 {
        Vector2(self.0 % other)
    }
}
