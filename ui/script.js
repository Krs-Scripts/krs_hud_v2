
const micValue = (value) => {
  switch (value) {
      case 0:
          return 15;
      case 1:
          return 33;
      case 2:
          return 66;
      case 3:
          return 100;
      default:
          return 33; 
  }
};

$(document).ready(function () {
  const vita = new ProgressBar.Circle("#health", createProgressBarOptions('#5C940D'));
  const cibo = new ProgressBar.Circle("#hunger", createProgressBarOptions('#862E9C'));
  const acqua = new ProgressBar.Circle("#thirst", createProgressBarOptions('#0B7285'));
  const ossigeno = new ProgressBar.Circle("#oxygen", createProgressBarOptions('#B197FC'));
  const corsa = new ProgressBar.Circle("#stamina", createProgressBarOptions('#c2332f'));
  const nervoso = new ProgressBar.Circle("#stress", createProgressBarOptions('#FFD43B'));
  const scudo = new ProgressBar.Circle("#armour", createProgressBarOptions('#326dbf'));
  const microphone = new ProgressBar.Circle("#voice", createProgressBarOptions('#E9ECEF'));

  function createProgressBarOptions(color) {
      return {
          color: color,
          trailColor: '#222224dc',
          strokeWidth: 10,
          trailWidth: 10,
          duration: 250,
          easing: "easeInOut"
      };
  }

  window.addEventListener('message', function (event) {
      const data = event.data;

      switch (data.message) {
          case 'info':
              $("#time").html(' ' + data.value.time);
              break;

          case 'update_hud':
              updateHud(data);
              break;

      }

      microphone.path.setAttribute("stroke", data.isTalking ? "#A61E4D" : "#828282");
  });

  function updateHud(data) {
      document.getElementById("id").innerHTML = data.id + ' ';
      vita.animate(data.health / 100);
      cibo.animate(data.hunger / 100);
      acqua.animate(data.thirst / 100);
      corsa.animate(data.stamina / 100);
      scudo.animate(data.armour / 100);
      nervoso.animate(data.stress / 100);

      handleHealth(data.health);
      handleOxygen(data.oxygen, data.active); 
      handleStamina(data.stamina);
      handleStress(data.stress);
      handleArmour(data.armour);
      handleMicrophone(data.microphone); 
  }

  function handleHealth(health) {
      if (health <= 0) {
          vita.animate(0);
          vita.trail.setAttribute("stroke", "#C92A2A");
          $("#health i").removeClass("fa-heart").addClass("fa-skull");
      } else {
          vita.trail.setAttribute("stroke", "#222224dc");
          $("#health i").removeClass("fa-skull").addClass("fa-heart");
      }
  }

  function handleOxygen(oxygen, active) { 
      if (oxygen < 0) {
          ossigeno.animate(0);
      } else {
          ossigeno.animate(oxygen / 100);
      }

      if (active) {
          $('#ossigeno').fadeIn();
      } else {
          $('#ossigeno').fadeOut();
      }
  }

  function handleStamina(stamina) {
      $('#stamina1').toggle(stamina < 100);
  }

  function handleStress(stress) {
      $('#stress1').toggle(stress > 0);
  }

  function handleArmour(armour) {
      if (armour > 1) {
          $("#scudo1").fadeIn();
          $("#scudo2").fadeOut();
      } else {
          $("#scudo1").fadeOut();
          $("#scudo2").fadeOut();
      }
  }

  function handleMicrophone(mode) {
      const micPercentage = micValue(mode); 
      microphone.animate(micPercentage / 100);
  }
});


// Handle speed container
window.addEventListener("DOMContentLoaded", () => {
  window.addEventListener("message", async (e) => {
    if (e.data.action === "show") {
      $(".contenitore_speed").removeClass("hidden");

      let speed = e.data.isMetric
        ? e.data.speed * 3.6
        : e.data.speed * 2.236936;
      let misura = e.data.isMetric ? "km/h" : "mph";

      if (e.data.fuel !== undefined) {
        let levelFuel = (e.data.fuel / 100) * 100;
        $(".livello_benzina").css({ width: `${levelFuel}%` });
        if (levelFuel > 90) {
          $(".livello_benzina").css("backgroundColor", "#0b7285");
        } else if (levelFuel <= 90 && levelFuel > 20) {
          $(".livello_benzina").css("backgroundColor", "#f76707");
        } else if (levelFuel <= 20) {
          $(".livello_benzina").css("backgroundColor", "#f03e3e");
        }
      }

      $(".speed").text(speed.toFixed(0));
      $(".misura").text(misura);
    } else if (e.data.action === "hide") {
      $(".contenitore_speed").addClass("hidden");
    }
  });
});