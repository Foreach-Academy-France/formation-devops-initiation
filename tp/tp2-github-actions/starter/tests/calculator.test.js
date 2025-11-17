import { describe, it, expect } from 'vitest';
import { add, multiply, subtract, divide } from '../src/calculator.js';

describe('Calculator', () => {
  describe('add', () => {
    it('should add two positive numbers', () => {
      expect(add(2, 3)).toBe(5);
    });

    it('should add negative numbers', () => {
      expect(add(-5, -3)).toBe(-8);
    });

    it('should add positive and negative numbers', () => {
      expect(add(10, -3)).toBe(7);
    });
  });

  describe('multiply', () => {
    it('should multiply two positive numbers', () => {
      expect(multiply(4, 5)).toBe(20);
    });

    it('should multiply by zero', () => {
      expect(multiply(10, 0)).toBe(0);
    });

    it('should multiply negative numbers', () => {
      expect(multiply(-3, -4)).toBe(12);
    });
  });

  describe('subtract', () => {
    it('should subtract two numbers', () => {
      expect(subtract(10, 3)).toBe(7);
    });

    it('should handle negative results', () => {
      expect(subtract(3, 10)).toBe(-7);
    });
  });

  describe('divide', () => {
    it('should divide two numbers', () => {
      expect(divide(10, 2)).toBe(5);
    });

    it('should handle decimal results', () => {
      expect(divide(7, 2)).toBe(3.5);
    });

    it('should throw error when dividing by zero', () => {
      expect(() => divide(10, 0)).toThrow('Division par zéro impossible');
    });
  });
});
