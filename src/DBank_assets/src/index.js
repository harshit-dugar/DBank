import {DBank} from '../../declarations/DBank';

window.addEventListener('load', async () => {
  update();
})

document.querySelector("form").addEventListener("submit",async (event)=>{
  event.preventDefault();
  const button = event.target.querySelector("#submit-btn");

  const inputAmount =parseFloat(document.getElementById('input-amount').value);
  const withdrawAmount = parseFloat(document.getElementById('withdrawal-amount').value);
  button.setAttribute("disabled", true);

  if(document.getElementById("input-amount").value.length!=0){
    await DBank.topUp(inputAmount);
  }
  if(document.getElementById("withdrawal-amount").value.length!=0){
    await DBank.withdraw(withdrawAmount);
  }
  await DBank.compound();

  update();

  document.getElementById('input-amount').value = "";
  document.getElementById('withdrawal-amount').value = "";
  button.removeAttribute("disabled");
})

async function update(){
  const currentAmmount =Math.round(await DBank.checkValue()*100)/100;
  document.getElementById("value").innerText=currentAmmount;
}