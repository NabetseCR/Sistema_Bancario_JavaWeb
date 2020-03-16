/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.control;

import Bank.logic.Cliente;
import Bank.logic.Usuario;
import Bank.model.ModelDatos;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ClienteDatosController", urlPatterns = {"/presentation/cliente/datos/show", "/presentation/cliente/datos/update"})
public class ControllerDatos extends HttpServlet {

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("model", new ModelDatos());

        String viewUrl = "";
        switch (request.getServletPath()) {
            case "/presentation/cliente/datos/show":
                viewUrl = this.show(request);
                break;
            case "/presentation/cliente/datos/update":
                viewUrl = this.update(request);
                break;
        }
        request.getRequestDispatcher(viewUrl).forward(request, response);
    }

    public String show(HttpServletRequest request) {
        return this.showAction(request);
    }

    public String showAction(HttpServletRequest request) {
        ModelDatos model = (ModelDatos) request.getAttribute("model");
        Bank.logic.Model domainModel = Bank.logic.Model.instance();
        HttpSession session = request.getSession(true);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        Cliente cliente;
        try {
            cliente = domainModel.clienteFind(usuario);
        } catch (Exception ex) {
            cliente = null;
        }
        try {
            model.setCurrent(cliente);
            return "/presentation/cliente/datos/Datos.jsp";
        } catch (Exception ex) {
            return "";
        }
    }

    private String update(HttpServletRequest request) {
        try {
            ModelDatos model = (ModelDatos) request.getAttribute("model");
            HttpSession session = request.getSession(true);
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            model.getCurrent().setCedula(usuario.getCedula());
            Map<String, String> errores = this.validar(request);
            if (errores.isEmpty()) {
                this.updateModel(request);
                return this.updateAction(request);
            } else {
                request.setAttribute("errores", errores);
                return "/presentation/cliente/datos/Datos.jsp";
            }
        } catch (Exception e) {
            return "/presentation/Error.jsp";
        }
    }

    Map<String, String> validar(HttpServletRequest request) {
        Map<String, String> errores = new HashMap<>();
        if (request.getParameter("nombreFld").isEmpty()) {
            errores.put("nombreFld", "Nombre requerido");
        }
        return errores;
    }

    void updateModel(HttpServletRequest request) {
        Bank.model.ModelDatos model = (Bank.model.ModelDatos) request.getAttribute("model");

        model.getCurrent().setNombre(request.getParameter("nombreFld"));
    }

    public String updateAction(HttpServletRequest request) {
        Bank.model.ModelDatos model = (Bank.model.ModelDatos) request.getAttribute("model");
        Bank.logic.Model domainModel = Bank.logic.Model.instance();
        HttpSession session = request.getSession(true);
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        model.getCurrent().setCedula(usuario.getCedula());
        model.getCurrent().setUsuario(usuario);
        try {
            domainModel.clienteUpdate(model.getCurrent());
            return "/presentation/Index.jsp";
        } catch (Exception ex) {
            Map<String, String> errores = new HashMap<>();
            request.setAttribute("errores", errores);
            errores.put("nombreFld", "cedula o nombreincorrectos");
            return "/presentation/cliente/datos/Datos.jsp";
        }
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
