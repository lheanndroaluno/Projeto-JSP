package br.com.sysprojsp.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.sysprojsp.classes.model.Medico;
import br.com.sysprojsp.classes.model.TelefoneMedico;
import br.com.sysprojsp.dao.MedicoDao;
import br.com.sysprojsp.dao.TelefoneMedicoDao;

@WebServlet("/pages/servletTelefoneMedico")
public class ServletTelefoneMedico extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private MedicoDao daoMedico = new MedicoDao();
	
	private TelefoneMedicoDao dao = new TelefoneMedicoDao();
       
    public ServletTelefoneMedico() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String acao = request.getParameter("acao");
		String med = request.getParameter("med");
		
		if (med != null) {
			
		if (acao != null && acao.equalsIgnoreCase("addTelefone")) {
			
			Medico medico = daoMedico.consultarM(med);
			
			request.getSession().setAttribute("medicoSelecionado", medico);
			request.setAttribute("medicoSelecionado", medico);
			
			RequestDispatcher view = request.getRequestDispatcher("/pages/cadastrotelefonesmedicos.jsp");
			request.setAttribute("telefone", dao.listarTodosTM(medico.getId()));
			view.forward(request, response);
			
		} else 
			
		if (acao != null && acao.equalsIgnoreCase("delete")) {
			
			
			String foneId = request.getParameter("foneId");
			dao.deleteTM(foneId);
			
			Medico medico = (Medico) request.getSession().getAttribute("medicoSelecionado");
			
			RequestDispatcher view = request.getRequestDispatcher("/pages/cadastrotelefonesmedicos.jsp");
			request.setAttribute("telefone", dao.listarTodosTM(medico.getId()));
			view.forward(request, response);
		}
		
		} else {
			
			RequestDispatcher view = request.getRequestDispatcher("/pages/cadastromedicos.jsp");
			request.setAttribute("medicos", daoMedico.listarTodosM());
			view.forward(request, response);
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String acao = request.getParameter("acao");
		
		if (acao != null && acao.equalsIgnoreCase("reset")) {
			
			Medico medico = (Medico) request.getSession().getAttribute("medicoSelecionado");
			
			RequestDispatcher view = request.getRequestDispatcher("/pages/cadastrotelefonesmedicos.jsp");
			request.setAttribute("telefone", dao.listarTodosTM(medico.getId()));
			view.forward(request, response);
			
		} else {
			
			Medico medico = (Medico) request.getSession().getAttribute("medicoSelecionado");
			
			String id = request.getParameter("idT");
			String numero = request.getParameter("numero");
			String tipo = request.getParameter("tipo");
			
			TelefoneMedico telefoneMedico = new TelefoneMedico();
			telefoneMedico.setId(!id.isEmpty() ? Long.parseLong(id) : 0);
			telefoneMedico.setNumero(numero);
			telefoneMedico.setTipo(tipo);
			telefoneMedico.setMedico(medico.getId());
			
			if (id == null || id.isEmpty()) {
				
				dao.saveTM(telefoneMedico);
				
				request.getSession().setAttribute("medicoSelecionado", medico);
				request.setAttribute("medicoSelecionado", medico);
				
				RequestDispatcher view = request.getRequestDispatcher("/pages/cadastrotelefonesmedicos.jsp");
				request.setAttribute("telefone", dao.listarTodosTM(medico.getId()));
				view.forward(request, response);
			}
			
		}
	}

}
