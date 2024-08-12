document.querySelector("form").addEventListener("submit", function(e){
 
e.preventDefault();
         
let score = 0;
         
if(document.querySelector("#q1b").checked){
         
score++;
         
}
if(document.querySelector("#q2b").checked){
         
score++;
             
}

if(document.querySelector("#q3b").checked){
         
score++;
                 
}

         
// Check answers for other questions
         
alert("Your score is " + score);
    
document.getElementById('output').innerHTML = score;
         
})