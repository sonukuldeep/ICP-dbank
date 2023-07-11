import { dbank_backend } from "../../declarations/dbank_backend";

async function checkBalance() {
  const balance = await dbank_backend.checkBalance()
  document.querySelector('#value').innerText = balance.toFixed(2)
}

window.addEventListener('load', checkBalance)

async function submitHandler(e) {
  e.preventDefault()
  const form = e.target;
  const formData = new FormData(form)
  const submitBtn = form.querySelector('#submit-btn')
  try {
    const topUp = Number(formData.get('topUp'))
    const withDraw = Number(formData.get('withdraw'))
    submitBtn.setAttribute('disabled', true)
    if (topUp !== 0)
      await dbank_backend.topUp(topUp)

    if (withDraw !== 0)
      await dbank_backend.withdraw(withDraw)

  } catch (error) {
    console.log('something went wrong, ', error.message)
  } finally {
    await dbank_backend.compound()
    checkBalance()
    setTimeout(() => {
      submitBtn.removeAttribute('disabled')
    }, 1000 * 60)
    form.reset()
  }
}

document.querySelector('form').addEventListener('submit', submitHandler)