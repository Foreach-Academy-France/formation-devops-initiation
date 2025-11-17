/**
 * Calculatrice Simple - TP GitHub Actions
 * Formation M2 ESTD - ForEach Academy
 */

/**
 * Additionne deux nombres
 * @param {number} a - Premier nombre
 * @param {number} b - Deuxième nombre
 * @returns {number} La somme de a et b
 */
export function add(a, b) {
  return a + b;
}

/**
 * Multiplie deux nombres
 * @param {number} a - Premier nombre
 * @param {number} b - Deuxième nombre
 * @returns {number} Le produit de a et b
 */
export function multiply(a, b) {
  return a * b;
}

/**
 * Soustrait deux nombres
 * @param {number} a - Premier nombre
 * @param {number} b - Deuxième nombre
 * @returns {number} La différence de a et b
 */
export function subtract(a, b) {
  return a - b;
}

/**
 * Divise deux nombres
 * @param {number} a - Dividende
 * @param {number} b - Diviseur
 * @returns {number} Le quotient de a et b
 * @throws {Error} Si le diviseur est zéro
 */
export function divide(a, b) {
  if (b === 0) {
    throw new Error('Division par zéro impossible');
  }
  return a / b;
}
