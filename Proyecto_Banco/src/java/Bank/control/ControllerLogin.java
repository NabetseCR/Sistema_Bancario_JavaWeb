/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bank.control;

import Bank.logic.Usuario;
import Bank.model.ModelLogin;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author jsanchez
 */
@WebServlet(name = "LoginController", urlPatterns = {"/presentation/login/show", "/presentation/login/login", "/presentation/login/logout"})
public class ControllerLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("model", new ModelLogin());

        String viewUrl = "";
        switch (request.getServletPath()) {
            case "/presentation/login/show":
                viewUrl = this.show(request);
                break;
            case "/presentation/login/login":
                viewUrl = this.login(request);
                break;
            case "/presentation/login/logout":
                viewUrl = this.logout(request);
                break;
        }
        request.getRequestDispatcher(viewUrl).forward(request, response);
    }

    private String login(HttpServletRequest request) {
        try {
            Map<String, String> errores = this.validar(request);
            if (errores.isEmpty()) {
                this.updateModel(request);
                return this.loginAction(request);
            } else {
                request.setAttribute("errores", errores);
                return "/presentation/login/View.jsp";
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

        model.getCurrent().setCedula(request.getParameter("cedulaFld"));
        model.getCurrent().setClave(request.getParameter("claveFld"));
    }

    public String loginAction(HttpServletRequest request) {
        ModelLogin model = (ModelLogin) request.getAttribute("model");
        Bank.logic.Model domainModel = Bank.logic.Model.instance();
        HttpSession session = request.getSession(true);
        try {
            Usuario real = domainModel.usuarioFind(model.getCurrent().getCedula(), model.getCurrent().getClave());
            session.setAttribute("usuario", real);
            String viewUrl = "";
            switch (real.getTipo()) {
                case 1:
                    viewUrl = "/presentation/cliente/cuentas/show";
                    break;
                case 2:
                    viewUrl = "";
                    break;
            }
            return viewUrl;
        } catch (Exception ex) {
            Map<String, String> errores = new HashMap<>();
            request.setAttribute("errores", errores);
            errores.put("cedulaFld", "Usuario o clave incorrectos");
            errores.put("claveFld", "Usuario o clave incorrectos");
            return "/presentation/login/Login.jsp";
        }
    }

    public String logout(HttpServletRequest request) {
        return this.logoutAction(request);
    }

    public String logoutAction(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        session.removeAttribute("usuario");
        session.invalidate();
        return "/presentation/Index.jsp";
    }

    public String show(HttpServletRequest request) {
        return this.showAction(request);
    }

    public String showAction(HttpServletRequest request) {
        ModelLogin model = (ModelLogin) request.getAttribute("model");
        model.getCurrent().setCedula("");
        model.getCurrent().setClave("");
        return "/presentation/login/Login.jsp";
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
