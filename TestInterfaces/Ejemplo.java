
//METODO 1

FirebaseAuth mAuth;
String email = "paulo@gmail.com";
String password = "11111111";

		//Metodo autentificacion mediante email y contraseña
        mAuth.signInWithEmailAndPassword(email, password)
                .addOnCompleteListener(this, new OnCompleteListener<AuthResult>() 
                {
                    @Override
                    public void onComplete(@NonNull Task<AuthResult> task) {
                        if (task.isSuccessful()) 
                        {
                            // Si el proceso termina correctamente, entonces estas autentificado
                            FirebaseUser user = mAuth.getCurrentUser();
                            //ESCRIBIR "Autentificacion correcta"
                        } 
                        else 
                        {
                        	//ESCRIBIR "Autentificacion fallida"
                        }
                    }
                });


//METODO 2

FirebaseAuth mAuth;
String email = "paulo@gmail.com";
String password = "11111111";
OnCompleteListener<AuthResult> autentificacionListener 
		= new OnCompleteListener<AuthResult>() {
		   
		    @Override
		    public void onComplete(@NonNull Task<AuthResult> task) {

		        if (task.isSuccessful()) {
			        // Si el proceso termina correctamente, entonces estas autentificado
			        FirebaseUser user = mAuth.getCurrentUser();
			        //ESCRIBIR "Autentificacion correcta"
			    } 
			    else {
			       	//ESCRIBIR "Autentificacion fallida"
			    }
			}
		}
			
		//Metodo autentificacion mediante email y contraseña
        mAuth.signInWithEmailAndPassword(email, password).addOnCompleteListener(this, autentificacionListener);