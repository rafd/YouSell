 window.cookie = function(name,value,days){
        if(name && value){ // sets cookie 'name' with 'value'
          if (days) {
                var date = new Date();
                date.setTime(date.getTime()+(days*24*60*60*1000));
                var expires = "; expires="+date.toGMTString();
          }
          else var expires = "";

                document.cookie = name+"="+value+expires+"; path=/";
          return value;
        }
        else if(name){ // gets cookie 'name'
          var nameEQ = name + "=";
          var ca = document.cookie.split(';');
          for(var i=0;i < ca.length;i++) {
                var c = ca[i];
                while (c.charAt(0)==' ') c = c.substring(1,c.length);
                if (c.indexOf(nameEQ) == 0) {
                  return c.substring(nameEQ.length,c.length);
                  }
          }
        }
        return null;
      };