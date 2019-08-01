package controllers.responses;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Employee;
import models.Response;
import models.validators.ResponseValidator;
import utils.DBUtil;

/**
 * Servlet implementation class ResponseCreateServlet
 */
@WebServlet("/responses/create")
public class ResponseCreateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResponseCreateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String _token = (String)request.getParameter("_token");
        if(_token != null && _token.equals(request.getSession().getId())){
            EntityManager em = DBUtil.createEntityManager();

            Response rs = new Response();

            rs.setEmployee((Employee)request.getSession().getAttribute("login_employee"));

            Date response_date = new Date(System.currentTimeMillis());
            rs.setResponse_date(response_date);

            rs.setTitle(request.getParameter("title"));
            rs.setContent(request.getParameter("content"));

            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            rs.setCreated_at(currentTime);
            rs.setUpdated_at(currentTime);

            List<String> errors = ResponseValidator.validate(rs);
            if(errors.size() > 0){
                em.close();

                request.setAttribute("_token", request.getSession().getId());
                request.setAttribute("response", rs);
                request.setAttribute("errors", errors);

                //show?=idを入れたい
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/reports/index.jsp");
                rd.forward(request, response);
            } else {
                em.getTransaction().begin();
                em.persist(rs);
                em.getTransaction().commit();
                em.close();
                request.getSession().setAttribute("flush", "返信が完了しました。");
              //show?=idを入れたい
                response.sendRedirect(request.getContextPath() + "/reports/index");
            }
        }
    }

}
