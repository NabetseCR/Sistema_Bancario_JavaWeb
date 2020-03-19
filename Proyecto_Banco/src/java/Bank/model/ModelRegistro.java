package Bank.model;

import Bank.logic.Usuario;

public class ModelRegistro {

    Usuario current;

    public ModelRegistro() {
        this.reset();
    }

    public void reset() {
        setCurrent(new Usuario());
    }

    public Usuario getCurrent() {
        return current;
    }

    public void setCurrent(Usuario current) {
        this.current = current;
    }

}
