use cgmath;
use rustler::types::{Decoder, Encoder};
use rustler::{Env, NifResult, Term};
use std::ops::{Add, Div, Mul, Rem, Sub};

#[derive(Debug)]
pub struct Vector3(cgmath::Vector3<f64>);

impl Vector3 {
    pub fn cross(&self, other: Vector3) -> Vector3 {
        Vector3(self.0.cross(other.0))
    }
}

#[derive(Debug, NifStruct)]
#[module = "Kinemat.Vector.Vector3"]
pub struct ExVector3 {
    pub x: f64,
    pub y: f64,
    pub z: f64,
}

impl<'a> Decoder<'a> for Vector3 {
    fn decode(term: Term<'a>) -> NifResult<Self> {
        let vec: ExVector3 = term.decode()?;
        Ok(Vector3(cgmath::Vector3::new(vec.x, vec.y, vec.z)))
    }
}

impl<'a> Encoder for Vector3 {
    fn encode<'b>(&self, env: Env<'b>) -> Term<'b> {
        let vec = ExVector3 {
            x: self.0.x,
            y: self.0.y,
            z: self.0.z,
        };
        vec.encode(env)
    }
}

impl Add for Vector3 {
    type Output = Vector3;

    fn add(self, other: Vector3) -> Vector3 {
        Vector3(self.0 + other.0)
    }
}

impl Sub for Vector3 {
    type Output = Vector3;

    fn sub(self, other: Vector3) -> Vector3 {
        Vector3(self.0 - other.0)
    }
}

impl Mul<f64> for Vector3 {
    type Output = Vector3;

    fn mul(self, other: f64) -> Vector3 {
        Vector3(self.0 * other)
    }
}

impl Div<f64> for Vector3 {
    type Output = Vector3;

    fn div(self, other: f64) -> Vector3 {
        Vector3(self.0 / other)
    }
}

impl Rem<f64> for Vector3 {
    type Output = Vector3;

    fn rem(self, other: f64) -> Vector3 {
        Vector3(self.0 % other)
    }
}
