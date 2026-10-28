(() => {
  'use strict';
  const nav = document.getElementById('navigation');
  const toggle = document.querySelector('.menu-toggle');
  const setMenu = open => { nav.classList.toggle('open', open); toggle.setAttribute('aria-expanded', String(open)); toggle.setAttribute('aria-label', open ? 'Fechar menu' : 'Abrir menu'); };
  toggle.addEventListener('click', () => setMenu(toggle.getAttribute('aria-expanded') !== 'true'));
  nav.querySelectorAll('a').forEach(a => a.addEventListener('click', () => setMenu(false)));
  document.addEventListener('click', e => { if (!nav.contains(e.target) && !toggle.contains(e.target)) setMenu(false); });
  document.addEventListener('keydown', e => { if (e.key === 'Escape' && toggle.getAttribute('aria-expanded') === 'true') { setMenu(false); toggle.focus(); } });
  window.matchMedia('(min-width: 761px)').addEventListener('change', e => { if (e.matches) setMenu(false); });
  document.querySelectorAll('[data-whatsapp]').forEach(a => { a.href = 'https://wa.me/556993776427?text=' + encodeURIComponent('Olá, Inácio! ' + a.dataset.whatsapp); });
  let dialogTrigger;
  document.querySelectorAll('[data-open]').forEach(button => button.addEventListener('click', () => {
    dialogTrigger = button;
    document.getElementById(button.dataset.open).showModal();
    document.documentElement.classList.add('modal-open');
  }));
  document.querySelectorAll('dialog').forEach(dialog => {
    dialog.querySelector('.dialog-close').addEventListener('click', () => dialog.close());
    dialog.addEventListener('click', e => { if(e.target !== dialog) return; const r=dialog.getBoundingClientRect(); if(e.clientX<r.left || e.clientX>r.right || e.clientY<r.top || e.clientY>r.bottom) dialog.close(); });
    dialog.addEventListener('close', () => { document.documentElement.classList.remove('modal-open'); dialogTrigger?.focus(); });
  });
  if ('IntersectionObserver' in window) {
    const links = [...nav.querySelectorAll('a')];
    const observer = new IntersectionObserver(entries => { entries.forEach(entry => { if(entry.isIntersecting) links.forEach(a => { const active=a.hash==='#'+entry.target.id; a.classList.toggle('active',active); if(active) a.setAttribute('aria-current','location'); else a.removeAttribute('aria-current'); }); }); }, {rootMargin:'-10% 0px -55% 0px'});
    document.querySelectorAll('section[id],.impact-cards[id]').forEach(el => observer.observe(el));
  }
})();
