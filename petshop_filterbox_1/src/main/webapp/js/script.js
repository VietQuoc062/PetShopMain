// === dữ liệu mẫu (giữ format price = nghìn đồng) ===
const products = [
  {id:1, name:"Tabby", pettype:"cat", price:1190, img:"https://via.placeholder.com/160"},
  {id:2, name:"Golden", pettype:"cat", price:990, img:"https://via.placeholder.com/160"},
  {id:3, name:"Texudo", pettype:"cat", price:399, img:"https://via.placeholder.com/160"},
  {id:4, name:"Pug", pettype:"dog", price:4490, img:"https://via.placeholder.com/160"},
  {id:5, name:"Pitbull", pettype:"dog", price:299, img:"https://via.placeholder.com/160"}
];

// === helper DOM refs ===
const tabBtns = document.querySelectorAll(".tab-btn");
const tabContents = document.querySelectorAll(".tab-content");
const subTabBtns = document.querySelectorAll(".sub-tab-btn");
const subTabContents = document.querySelectorAll(".sub-tab-content");
const priceRange = document.getElementById("price-range");
const priceDisplay = document.getElementById("price-display");
const productList = document.getElementById("product-list");

// render products to #product-list
function renderProducts(data){
  if(!productList) return;
  if(!data || data.length === 0){
    productList.innerHTML = `<div class="center">Không tìm thấy sản phẩm</div>`;
    return;
  }
  // stagger animation delay
  productList.innerHTML = data.map((p, i) => {
    const priceVND = Number(p.price) * 1000;
    const priceText = priceVND.toLocaleString('vi-VN') + 'đ';
    return `
      <div class="product-card" style="animation-delay:${i*60}ms">
        <img src="${p.img}" alt="${p.name}">
        <h4>${p.name}</h4>
        <p>${p.pettype}</p>
        <div class="price">${priceText}</div>
      </div>
    `;
  }).join('');
}

// === initial render ===
renderProducts(products);

// --- TAB switching (main tabs) ---
tabBtns.forEach((btn, idx) => {
  btn.addEventListener('click', () => {
    tabBtns.forEach(b => b.classList.remove('active'));
    tabContents.forEach(c => c.classList.remove('active'));
    btn.classList.add('active');

    const id = 'tab-' + btn.dataset.tab;
    const target = document.getElementById(id);
    if(target) target.classList.add('active');

    // move indicator (use transform)
    const tabs = document.querySelector('.tabs');
    const indicator = tabs.querySelector('::after'); // can't access pseudo, move via transform on ::after via class toggle
    // simpler: set CSS variable on tabs and use position percent
    const percent = idx * 100;
    tabs.style.setProperty('--tab-ind', `${percent}%`);
  });
});

// move the indicator by manipulating CSS transform on ::after via inline style trick
// We'll create a dynamic rule by adding style element
(function setupIndicator(){
  const tabs = document.querySelector('.tabs');
  if(!tabs) return;
  const styleEl = document.createElement('style');
  styleEl.id = 'tabs-indicator-style';
  document.head.appendChild(styleEl);
  function update(){
    const activeIndex = Array.from(tabBtns).findIndex(b => b.classList.contains('active'));
    const percent = activeIndex * 100;
    styleEl.innerHTML = `.tabs::after{ transform: translateX(${percent}%); }`;
  }
  update();
  tabBtns.forEach(b => b.addEventListener('click', update));
})();

// --- SUB-TAB switching ---
subTabBtns.forEach(btn => {
  btn.addEventListener('click', () => {
    subTabBtns.forEach(b => b.classList.remove('active'));
    subTabContents.forEach(c => c.classList.remove('active'));
    btn.classList.add('active');
    const id = btn.dataset.subtab;
    const target = document.getElementById(id);
    if(target) target.classList.add('active');

    // re-filter when subtab changed
    filterProducts();
  });
});

// --- collapse toggle for filter groups ---
document.querySelectorAll(".filter-header").forEach(header => {
  header.addEventListener('click', () => {
    const options = header.nextElementSibling;
    const arrow = header.querySelector('.arrow');
    if(!options) return;
    const hidden = options.classList.toggle('hidden');
    arrow.classList.toggle('rotate', hidden);
  });
});

// --- Price slider handling (single slider chooses max) ---
if(priceRange && priceDisplay){
  // format initial
  priceDisplay.textContent = `0 - ${Number(priceRange.value).toLocaleString('vi-VN')}`;
  priceRange.addEventListener('input', () => {
    const max = Number(priceRange.value);
    priceDisplay.textContent = `0 - ${max.toLocaleString('vi-VN')}`;
    // reset price radios to "all" to avoid logic conflict
    const priceRadios = document.querySelectorAll("input[name='price']");
    priceRadios.forEach(r => { if(r.value === 'all') r.checked = true; });

    filterProducts();
  });
}

// --- get active main tab ('pets' or 'products') ---
function getActiveMainTab(){
  const active = document.querySelector(".tab-btn.active");
  return active ? active.dataset.tab : 'pets';
}

// --- get selected pettypes (checkboxes in pets tab) ---
function getCheckedPetTypes(){
  return Array.from(document.querySelectorAll(".pettype:checked")).map(el => el.value);
}

// --- get selected product type for current subtab (dog-ptype or cat-ptype) ---
function getSelectedPtypeForSubtab(){
  // which subtab is active?
  const activeSub = document.querySelector(".sub-tab-btn.active");
  if(!activeSub) return null;
  const subId = activeSub.dataset.subtab; // 'dog-products' or 'cat-products'
  const name = subId.startsWith('dog') ? 'dog-ptype' : 'cat-ptype';
  const sel = document.querySelector(`input[name="${name}"]:checked`);
  return sel ? sel.value : 'all';
}

// --- filter logic ---
function filterProducts(){
  let min = 0;
  let max = Infinity;

  // if slider changed from default -> use slider as max (slider value is VND)
  if(priceRange){
    const sliderMax = Number(priceRange.value);
    const sliderDefault = Number(priceRange.max);
    if(sliderMax !== sliderDefault){
      min = 0;
      max = sliderMax;
    }
  }

  // if radio price selected and slider is default, use radio (radio values are strings like "0-1000000" or "all")
  if(max === Infinity){
    const priceRadio = document.querySelector("input[name='price']:checked");
    if(priceRadio && priceRadio.value !== 'all'){
      const parts = priceRadio.value.split('-').map(Number);
      if(parts.length === 2){
        min = parts[0];
        max = parts[1];
      }
      // detect if radio used nghìn unit (<=10000)
      if(max <= 10000){
        min = min * 1000;
        max = max * 1000;
      }
    }
  }

  // Determine filters:
  const mainTab = getActiveMainTab(); // 'pets' or 'products'
  const checkedPetTypes = getCheckedPetTypes(); // [] or ['dog','cat']
  const subPtype = getSelectedPtypeForSubtab(); // 'food'|'toy'|'accessory'|'all'
  const activeSub = document.querySelector(".sub-tab-btn.active");
  const impliedPetKind = activeSub ? (activeSub.dataset.subtab.startsWith('dog') ? 'dog' : 'cat') : null;

  // Filter
  const filtered = products.filter(p => {
    // price: product.price in nghìn -> convert to VND
    const priceVND = Number(p.price) * 1000;
    const priceOk = priceVND >= min && priceVND <= max;

    // pettype checkboxes: if any checked -> must include; if none checked -> all OK
    const petCheckboxOk = checkedPetTypes.length ? checkedPetTypes.includes(p.pettype) : true;

    // products tab subfilter: if mainTab is 'products', then only show items for impliedPetKind and matching ptype (if not 'all')
    let subOk = true;
    if(mainTab === 'products'){
      if(impliedPetKind && p.pettype !== impliedPetKind) subOk = false;
      if(subPtype && subPtype !== 'all'){
        // our sample product model currently doesn't have 'ptype' field; assume product has maybe categories - but we try to map roughly:
        // if you have real ptype in data use p.ptype === subPtype; for now accept all (or you can expand dataset)
        // For demonstration we check by name contains keywords (naive)
        const nameLower = p.name.toLowerCase();
        if(subPtype === 'food' && !nameLower.includes('food') && !nameLower.includes('tabby') ){ /* keep broad */ }
        // skip strict check to avoid hiding samples
      }
    }

    // final decision: must satisfy price & petCheckboxOk & subOk
    return priceOk && petCheckboxOk && subOk;
  });

  renderProducts(filtered);
}

document.addEventListener("DOMContentLoaded", () => {
  // Xử lý tab chính (Shop cho Chó / Shop cho Mèo)
  const tabBtns = document.querySelectorAll(".tab-btn");
  const tabContents = document.querySelectorAll(".tab-content");

  tabBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      // Bỏ active tất cả
      tabBtns.forEach(b => b.classList.remove("active"));
      tabContents.forEach(c => c.classList.remove("active"));

      // Active tab được chọn
      btn.classList.add("active");
      document.getElementById(btn.dataset.tab).classList.add("active");

      // Reset tab con: luôn chọn cái đầu tiên khi đổi tab chính
      const subBtns = document.querySelectorAll(`#${btn.dataset.tab} .sub-tab-btn`);
      const subContents = document.querySelectorAll(`#${btn.dataset.tab} .sub-tab-content`);
      if (subBtns.length > 0) {
        subBtns.forEach((b, i) => {
          if (i === 0) b.classList.add("active");
          else b.classList.remove("active");
        });
      }
      if (subContents.length > 0) {
        subContents.forEach((c, i) => {
          if (i === 0) c.classList.add("active");
          else c.classList.remove("active");
        });
      }
    });
  });

  // Xử lý tab con (Giống / Sản phẩm)
  const subTabBtns = document.querySelectorAll(".sub-tab-btn");
  const subTabContents = document.querySelectorAll(".sub-tab-content");

  subTabBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      const parent = btn.closest(".tab-content");

      // Bỏ active trong group hiện tại
      parent.querySelectorAll(".sub-tab-btn").forEach(b => b.classList.remove("active"));
      parent.querySelectorAll(".sub-tab-content").forEach(c => c.classList.remove("active"));

      // Active tab con được chọn
      btn.classList.add("active");
      parent.querySelector(`#${btn.dataset.subtab}`).classList.add("active");
    });
  });

  // Toggle filter options (ẩn/hiện khi click header)
  document.querySelectorAll(".filter-header").forEach(header => {
    header.addEventListener("click", () => {
      const options = header.nextElementSibling;
      const arrow = header.querySelector(".arrow");
      options.classList.toggle("collapsed");
      arrow.classList.toggle("rotate");
    });
  });

  // Thanh trượt giá
  const priceRange = document.getElementById("price-range");
  const priceDisplay = document.getElementById("price-display");
  if (priceRange && priceDisplay) {
    priceRange.addEventListener("input", () => {
      priceDisplay.textContent = `0 - ${parseInt(priceRange.value).toLocaleString("vi-VN")}`;
    });
  }
});

// Toggle filter group khi click tiêu đề
document.querySelectorAll(".filter-header").forEach(header => {
  header.addEventListener("click", () => {
    const options = header.nextElementSibling;
    options.classList.toggle("open");

    // Xoay icon mũi tên
    const arrow = header.querySelector(".arrow");
    arrow.classList.toggle("rotate");
  });
});
