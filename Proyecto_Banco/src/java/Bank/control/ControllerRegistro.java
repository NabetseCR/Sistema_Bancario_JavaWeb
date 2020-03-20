package Bank.control;

import Bank.model.ModelRegistro;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistroController", urlPatterns = {"/presentation/Registro/show", "/presentation/Registro"})
public class ControllerRegistro extends HttpServlet{

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("model", new ModelRegistro());

        String viewUrl = "";
        switch (request.getServletPath()) {
            case "/presentation/Registro/show":
                viewUrl = this.show(request);
                break;
            case "/presentation/Registro":
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
        ModelRegistro model = (ModelRegistro) request.getAttribute("model");
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
       return "/presentation/Registro/Registro.jsp";
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
