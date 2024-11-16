const removeButtons = document.querySelectorAll('.remove-button');

removeButtons.forEach(button => {
  button.addEventListener('click', () => {
    button.parentNode.remove();
    updateTotal();
  });
});

function updateTotal() {
  const subTotalElement = document.querySelector('.booking-summary p:last-child');
  const items = document.querySelectorAll('.booking-item');
  let subTotal = 0;

  items.forEach(item => {
    const price = parseFloat(item.querySelector('.booking-item-price').textContent.slice(1));
    const quantity = parseInt(item.querySelector('input').value);
    subTotal += price * quantity;
  });

  subTotalElement.textContent = `Sub Total: $${subTotal.toFixed(2)}`;
}

updateTotal();