package Bank.control;

import Bank.model.ModelLogin;
import Bank.model.ModelRegistro;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroController", urlPatterns = {"/presentation/registro/show", "/presentation/registro"})
public class ControllerRegistro {

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("model", new ModelRegistro());

        String viewUrl = "";
        switch (request.getServletPath()) {
            case "/presentation/registro/show":
                viewUrl = this.show(request);
                break;
            case "/presentation/registro":
                viewUrl = this.registro(request);
                break;

        }
        request.getRequestDispatcher(viewUrl).forward(request, response);
    }

    private String registro(HttpServletRequest request) {
        try {
            Map<String, String> errores = this.validar(request);
            if (errores.isEmpty()) {
                this.updateModel(request);
                return "/presentation/Index.jsp";
            } else {
                request.setAttribute("errores", errores);
                return "/presentation/Registro/Registro.jsp";
            }
        } catch (Exception e) {
            return "/presentation/Error.jsp";
        }
    }

    Map<String, String> validar(HttpServletRequest request) {
        Map<String, String> errores = new HashMap<>();
        if (request.getParameter("cedulaFld").isEmpty()) {
            errores.put("cedulaFld", "Cedula requerida");
        }

        if (request.getParameter("claveFld").isEmpty()) {
            errores.put("claveFld", "Clave requerida");
        }
        return errores;
    }

    void updateModel(HttpServletRequest request) {
        ModelLogin model = (ModelLogin) request.getAttribute("model");
        String id = request.getParameter("id");
        String nom = request.getParameter("nombre");
        String ape1 = request.getParameter("apellido1");
        String ape2 = request.getParameter("apellido2");
        String edad = request.getParameter("edad");
        String estadoC = request.getParameter("estadoCivil");
        String prov = request.getParameter("provicia");
        String cant = request.getParameter("canton");
        String direcc = request.getParameter("direccion");
        String tel = request.getParameter("telefono");
        String cel = request.getParameter("celular");
        String correo = request.getParameter("email");
        String contra = request.getParameter("password");
        model.getCurrent().setCedula(request.getParameter("cedulaFld"));
        model.getCurrent().setClave(request.getParameter("claveFld"));

    }

    public String show(HttpServletRequest request) {
        return "../presentation/Registro/Registro.jsp";
    }

}
