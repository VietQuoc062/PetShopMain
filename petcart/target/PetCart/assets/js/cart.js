document.addEventListener("DOMContentLoaded", () => {
  const buttons = document.querySelectorAll(".add-to-cart-btn");
  const modal = new bootstrap.Modal(document.getElementById("productModal"));

  buttons.forEach((button) => {
    button.addEventListener("click", () => {
      //lay du lieu tu butoon
      const id = button.dataset.id;
      const name = button.dataset.name;
      const price = button.dataset.price;
      const image = button.dataset.image;
      const description = button.dataset.description;

      //gan vao modal
      document.getElementById("modalProductName").textContent = name;
      document.getElementById("modalProductPrice").textContent =
        new Intl.NumberFormat("vi-VN", {
          style: "currency",
          currency: "VND",
        }).format(price);
      // document.getElementById("modalProductImage").src = image;
      document.getElementById("modalProductQuantity").value = 1;
      // document.getElementById("modalProductDescription").textContent =
      // description;

      // Gán giá trị cho các input hidden
      document.getElementById("modalProductCode").value = id;
      document.getElementById("modalProductNameInput").value = name;
      document.getElementById("modalProductPriceInput").value = price;
      document.getElementById("formQuantity").value = 1;
      modal.show();

      document
        .getElementById("modalProductQuantity")
        .addEventListener("input", (e) => {
          document.getElementById("formQuantity").value = e.target.value;
        });
    });
  });
});
