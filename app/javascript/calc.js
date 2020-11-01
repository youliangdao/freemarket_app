function calc() {
  const price = document.getElementById("item-price");
  price.addEventListener("input", () => {
    const item_price = document.getElementById("item-price")
    const input = item_price.value
    const tax_price = document.getElementById("add-tax-price");
    const profit_price = document.getElementById("profit");
    const tax_before = input * 0.1;
    const tax_after = Math.floor(tax_before);
    const profit = input - tax_after;

    tax_price.innerHTML = tax_after;
    profit_price.innerHTML = profit;

  });
}
window.addEventListener("load", calc);