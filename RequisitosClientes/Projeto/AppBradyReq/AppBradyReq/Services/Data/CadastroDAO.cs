using System.Collections.Generic;
using AppBradyReq.DataAccess;
using AppBradyReq.Models;
using System;
using System.Data;
using Dapper;
using System.Linq;
using System.Data.SqlClient;

namespace AppBradyReq.Services.Data
{
    internal class CadastroDAO : IDataConnection
    {

        // performs all operations on the database.
        // Glossario
        private const String db = "AppSop";

        public List<GlossarioModel> GetGlossario_All()
        {
            List<GlossarioModel> returnList = new List<GlossarioModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT RQCL_GLOSSARIO_ID, TITULO, SUBSTRING(DESCRICAO, 1, 20) AS DESCRICAO, TSIS_USUCOD FROM RQCL_GLOSSARIO where TITULO is not null";
                SqlCommand command = new SqlCommand(sqlQuery, connection);
                connection.Open();
                SqlDataReader reader =  command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        GlossarioModel glossario = new GlossarioModel();
                        glossario.RQCL_Glossario_ID = reader.GetInt32(0);
                        glossario.Titulo = reader.GetString(1);
                        glossario.Descricao = reader.GetString(2);
                        glossario.Tsis_usucod = reader.GetInt32(3);

                        returnList.Add(glossario);
                    }
                }
                
            }

            return returnList;
        }

        internal List<ClienteModel> GetLista_Clientes(int id)
        {
            List<ClienteModel> returnList = new List<ClienteModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT distinct Tsop_Clisapclicgc, Tsop_Ordbilgruclinom FROM RQCL_CLIENTE where Tsop_Ordbilgruclinom is not null and RQCL_MERCADO_ID = @RQCL_MERCADO_ID";


                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@RQCL_MERCADO_ID", System.Data.SqlDbType.Int).Value = id;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        ClienteModel cliente = new ClienteModel();
                       
                        cliente.Tsop_Clisapclicgc = reader.GetString(0);
                        cliente.Tsop_Ordbilgruclinom = reader.GetString(1);


                        returnList.Add(cliente);
                    }
                }

            }

            return returnList;
        }

        internal List<MercadoModel> GetMercado_All()
        {
            List<MercadoModel> returnList = new List<MercadoModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT RQCL_MERCADO_ID, NOME, TSIS_USUCOD FROM RQCL_MERCADO ORDER BY NOME";
                SqlCommand command = new SqlCommand(sqlQuery, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        MercadoModel mercado = new MercadoModel();
                        mercado.Mercado_ID = reader.GetInt32(0);
                        mercado.Nome = reader.GetString(1);
                        mercado.Tsis_usucod = reader.GetInt32(2);

                        returnList.Add(mercado);
                    }
                }

            }

            return returnList;
        }

        public int CreateRequisitoCliente(int cliente, int id_requisito, int id_item)
        {
          
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "";

 
                 sqlQuery = "Insert Into RQCL_CLIENTE_REQUISITO (TSOP_CLISAPCLICOD, RQCL_REQUISITO_ID, RQCL_ITEM_ID, TSIS_USUCOD) Values (@TSOP_CLISAPCLICOD, @RQCL_REQUISITO_ID, @RQCL_ITEM_ID, @TSIS_USUCOD) ";


                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@TSOP_CLISAPCLICOD", System.Data.SqlDbType.Int).Value = cliente;
                command.Parameters.Add("@RQCL_REQUISITO_ID", System.Data.SqlDbType.Int).Value = id_requisito;
                command.Parameters.Add("@RQCL_ITEM_ID", System.Data.SqlDbType.Int).Value = id_item;
                command.Parameters.Add("@TSIS_USUCOD", System.Data.SqlDbType.Int).Value = 191;

                connection.Open();
                int newID = command.ExecuteNonQuery();

                return newID;
            }
        }

        public int ExcluirRequisitoCliente(int cliente,  int id)
        {
            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "Delete from RQCL_CLIENTE_REQUISITO Where TSOP_CLISAPCLICOD = @TSOP_CLISAPCLICOD AND RQCL_REQUISITO_ID = @RQCL_REQUISITO_ID";


                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@TSOP_CLISAPCLICOD", System.Data.SqlDbType.Int).Value = cliente;
                command.Parameters.Add("@RQCL_REQUISITO_ID", System.Data.SqlDbType.Int).Value = id;

                connection.Open();

                int deleteID = command.ExecuteNonQuery();

                return deleteID;
            }
        }

        internal List<RequisitoModel> PesquisaPeloCodigo(object cliente)
        {

            List<RequisitoModel> returnList = new List<RequisitoModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT C.TSOP_CLISAPCLICOD " +
                                    " ,(SELECT TOP 1 TSOP_CLISAPCLINOM FROM TSOP_CLIENTESAP WHERE TSOP_CLISAPCLICOD = @TSOP_CLISAPCLICOD) AS TSOP_CLISAPCLINOM " +
                                    " , R.RQCL_REQUISITO_ID " +
                                    " , R.NOME" +
                                    " ,1 AS POSSUI" +
                                    " FROM  RQCL_CLIENTE_REQUISITO CR" +
                                    " INNER JOIN RQCL_CLIENTE         C ON C.TSOP_CLISAPCLICOD = CR.TSOP_CLISAPCLICOD" +
                                    " LEFT OUTER JOIN RQCL_REQUISITO R ON R.RQCL_REQUISITO_ID = CR.RQCL_REQUISITO_ID" +
                                    " WHERE C.TSOP_CLISAPCLICOD = @TSOP_CLISAPCLICOD" +

                                    " UNION ALL " +

                                    " SELECT (SELECT TOP 1 TSOP_CLISAPCLICOD FROM TSOP_CLIENTESAP WHERE TSOP_CLISAPCLICOD = @TSOP_CLISAPCLICOD) AS TSOP_CLISAPCLICOD " +
                                    " ,(SELECT TOP 1 TSOP_CLISAPCLINOM FROM TSOP_CLIENTESAP WHERE TSOP_CLISAPCLICOD = @TSOP_CLISAPCLICOD) AS TSOP_CLISAPCLINOM " +
                                    " , R.RQCL_REQUISITO_ID" +
                                    " , R.NOME" +
                                    " , 0 AS POSSUI" +
                                    " FROM RQCL_REQUISITO R" +
                                    " WHERE NOT EXISTS(SELECT CR.TSOP_CLISAPCLICOD FROM RQCL_CLIENTE_REQUISITO CR" +
                                    " INNER JOIN RQCL_CLIENTE C ON C.TSOP_CLISAPCLICOD = CR.TSOP_CLISAPCLICOD" +
                                    " WHERE R.RQCL_REQUISITO_ID = CR.RQCL_REQUISITO_ID" +
                                    " AND C.TSOP_CLISAPCLICOD = @TSOP_CLISAPCLICOD)" +
                                    " Order by R.RQCL_REQUISITO_ID";

                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@TSOP_CLISAPCLICOD", System.Data.SqlDbType.Int).Value = cliente;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        RequisitoModel requisito = new RequisitoModel();
                        requisito.Cliente.Tsop_Clisapclicod = reader.GetInt32(0);
                        requisito.Cliente.Tsop_Clisapclinom = reader.GetString(1);
                        requisito.Rqcl_Requisito_Id = reader.GetInt32(2);
                        requisito.Nome = reader.GetString(3);
                        requisito.Possui = Convert.ToBoolean(reader.GetInt32(4));

                        returnList.Add(requisito);
                    }
                }

            }

            return returnList;
        }

        internal List<RequisitoItemModel> BuscaListaItens(int cliente, int id)
        {
            List<RequisitoItemModel> returnList = new List<RequisitoItemModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT RI.RQCL_REQUISITO_ID,  I.RQCL_ITEM_ID, I.NOME " +
                    " FROM RQCL_REQUISITO_ITENS RI " +
                    " INNER JOIN RQCL_ITEM I ON I.RQCL_ITEM_ID = RI.RQCL_ITEM_ID " +
                    " WHERE RI.RQCL_REQUISITO_ID = @RQCL_REQUISITO_ID Order By RI.RQCL_REQUISITO_ID";

                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@RQCL_REQUISITO_ID", System.Data.SqlDbType.Int).Value = id;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        RequisitoItemModel requisitoitem = new RequisitoItemModel();
                        requisitoitem.Requisito.Rqcl_Requisito_Id  = reader.GetInt32(0);
                        requisitoitem.Requisito.Cliente.Tsop_Clisapclicod = cliente;
                        requisitoitem.Item.Item_Id = reader.GetInt32(1);
                        requisitoitem.Item.Nome = reader.GetString(2);
                        
                        returnList.Add(requisitoitem);
                    }
                }

            }

            return returnList;
        }

        public List<ClienteModel> GetCliente_All()
        {
            List<ClienteModel> returnList = new List<ClienteModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT RQCL_CLIENTE_ID, Tsop_Clisapclicgc, Tsop_Ordbilgruclinom, Tsop_Clisapclicod FROM RQCL_CLIENTE where Tsop_Ordbilgruclinom is not null";
                SqlCommand command = new SqlCommand(sqlQuery, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        ClienteModel cliente = new ClienteModel();
                        cliente.Cliente_Id = reader.GetInt32(0);
                        cliente.Tsop_Clisapclicgc = reader.GetString(1);
                        cliente.Tsop_Ordbilgruclinom = reader.GetString(2);
                        cliente.Tsop_Clisapclicod = reader.GetInt32(3);

                        returnList.Add(cliente);
                    }
                }

            }

            return returnList;
        }

        public  List<RequisitoModel> PesquisaPeloCNPJ(string searchCNPJ)
        {
            List<RequisitoModel> returnList = new List<RequisitoModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT C.TSOP_CLISAPCLICOD " +
                                    " ,(SELECT TOP 1 TSOP_CLISAPCLINOM FROM TSOP_CLIENTESAP WHERE TSOP_CLISAPCLICGC = @Tsop_Clisapclicgc) AS TSOP_CLISAPCLINOM " +
                                    "  , c.TSOP_CLISAPCLICGC " +
                                    " , R.RQCL_REQUISITO_ID " +
                                    " , R.NOME" +
                                    " ,1 AS POSSUI" +
                                    " FROM  RQCL_CLIENTE_REQUISITO CR" +
                                    " INNER JOIN RQCL_CLIENTE         C ON C.TSOP_CLISAPCLICOD = CR.TSOP_CLISAPCLICOD" +
                                    " LEFT OUTER JOIN RQCL_REQUISITO R ON R.RQCL_REQUISITO_ID = CR.RQCL_REQUISITO_ID" +
                                    " WHERE C.TSOP_CLISAPCLICGC = @Tsop_Clisapclicgc" +

                                    " UNION ALL " +

                                    " SELECT (SELECT TOP 1 TSOP_CLISAPCLICOD FROM TSOP_CLIENTESAP WHERE TSOP_CLISAPCLICGC = @Tsop_Clisapclicgc) AS TSOP_CLISAPCLICOD " +
                                    " ,(SELECT TOP 1 TSOP_CLISAPCLINOM FROM TSOP_CLIENTESAP WHERE TSOP_CLISAPCLICGC = @Tsop_Clisapclicgc) AS TSOP_CLISAPCLINOM " +
                                    " ,(SELECT TOP 1 TSOP_CLISAPCLICGC FROM TSOP_CLIENTESAP WHERE TSOP_CLISAPCLICGC = @Tsop_Clisapclicgc) AS TSOP_CLISAPCLICGC " +
                                    " , R.RQCL_REQUISITO_ID" +
                                    " , R.NOME" +
                                    " , 0 AS POSSUI" +
                                    " FROM RQCL_REQUISITO R" +
                                    " WHERE NOT EXISTS(SELECT CR.TSOP_CLISAPCLICOD FROM RQCL_CLIENTE_REQUISITO CR" +
                                    " INNER JOIN RQCL_CLIENTE C ON C.TSOP_CLISAPCLICOD = CR.TSOP_CLISAPCLICOD" +
                                    " WHERE R.RQCL_REQUISITO_ID = CR.RQCL_REQUISITO_ID" +
                                    " AND C.TSOP_CLISAPCLICGC = @Tsop_Clisapclicgc)" +
                                    " Order By R.RQCL_REQUISITO_ID";


                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@Tsop_Clisapclicgc", System.Data.SqlDbType.VarChar, 18).Value = searchCNPJ;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        RequisitoModel requisito = new RequisitoModel();
                        requisito.Cliente.Tsop_Clisapclicod = reader.GetInt32(0);
                        requisito.Cliente.Tsop_Clisapclinom = reader.GetString(1);
                        requisito.Cliente.Tsop_Clisapclicgc = reader.GetString(2);
                        requisito.Rqcl_Requisito_Id = reader.GetInt32(3);
                        requisito.Nome = reader.GetString(4);
                        requisito.Possui =  Convert.ToBoolean(reader.GetInt32(5));
                    
                        returnList.Add(requisito);
                    }
                }

            }

            return returnList;
        }

        public List<GlossarioModel> PesquisaPeloTitulo(string searchTitulo)
        {
            List<GlossarioModel> returnList = new List<GlossarioModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT RQCL_GLOSSARIO_ID, TITULO, DESCRICAO, TSIS_USUCOD FROM RQCL_GLOSSARIO where TITULO Like @TITULO";

                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@TITULO", System.Data.SqlDbType.VarChar, 100).Value =  "%" +searchTitulo +"%";

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        GlossarioModel glossario = new GlossarioModel();
                        glossario.RQCL_Glossario_ID = reader.GetInt32(0);
                        glossario.Titulo = reader.GetString(1);
                        glossario.Descricao = reader.GetString(2);
                        glossario.Tsis_usucod = reader.GetInt32(3);

                        returnList.Add(glossario);
                    }
                }

            }

            return returnList;
        }

      
        public List<GlossarioModel> PesquisaPelaDescricao(string searchDescricao)
        {
            List<GlossarioModel> returnList = new List<GlossarioModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT RQCL_GLOSSARIO_ID, TITULO, DESCRICAO, TSIS_USUCOD FROM RQCL_GLOSSARIO where DESCRICAO Like @DESCRICAO";

                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@DESCRICAO", System.Data.SqlDbType.VarChar, 100).Value = "%" + searchDescricao + "%";

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        GlossarioModel glossario = new GlossarioModel();
                        glossario.RQCL_Glossario_ID = reader.GetInt32(0);
                        glossario.Titulo = reader.GetString(1);
                        glossario.Descricao = reader.GetString(2);
                        glossario.Tsis_usucod = reader.GetInt32(3);

                        returnList.Add(glossario);
                    }
                }

            }

            return returnList;
        }

        public int Delete(int id)
        {
            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string  sqlQuery = "Delete from RQCL_GLOSSARIO Where RQCL_GLOSSARIO_ID = @RQCL_GLOSSARIO_ID";

             
                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@RQCL_GLOSSARIO_ID", System.Data.SqlDbType.Int).Value = id;
                connection.Open();

                int deleteID = command.ExecuteNonQuery();

                return deleteID;
            }
        }

        public GlossarioModel GetGlossario_One(int id)
        {
            GlossarioModel glossario = new GlossarioModel();
            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT RQCL_GLOSSARIO_ID, TITULO, DESCRICAO, TSIS_USUCOD FROM RQCL_GLOSSARIO where RQCL_GLOSSARIO_ID = @Id and TITULO is not null";

                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@Id", System.Data.SqlDbType.Int).Value = id;

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                    
                        glossario.RQCL_Glossario_ID = reader.GetInt32(0);
                        glossario.Titulo = reader.GetString(1);
                        glossario.Descricao = reader.GetString(2);
                        glossario.Tsis_usucod = reader.GetInt32(3);

                   
                    }
                }

            }

            return glossario;

        }

        public int CreateOrUpdate(GlossarioModel glossario)
        {
           
            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "";
           
                if (glossario.RQCL_Glossario_ID <= 0)
                {
                    sqlQuery = "Insert Into RQCL_GLOSSARIO (TITULO, DESCRICAO, TSIS_USUCOD) Values (@TITULO, @DESCRICAO, @TSIS_USUCOD) ";

                }
                else
                {
                    sqlQuery = "Update RQCL_GLOSSARIO Set Titulo = @TITULO, Descricao = @DESCRICAO, Tsis_UsuCod = @TSIS_USUCOD Where RQCL_GLOSSARIO_ID = @RQCL_GLOSSARIO_ID";

       
                }
                SqlCommand command = new SqlCommand(sqlQuery, connection);
                command.Parameters.Add("@RQCL_GLOSSARIO_ID", System.Data.SqlDbType.Int).Value = glossario.RQCL_Glossario_ID;
                command.Parameters.Add("@TITULO", System.Data.SqlDbType.VarChar, 100).Value = glossario.Titulo;
                command.Parameters.Add("@DESCRICAO", System.Data.SqlDbType.VarChar, 4000).Value = glossario.Descricao;
                command.Parameters.Add("@TSIS_USUCOD", System.Data.SqlDbType.Int).Value = 191;

                connection.Open();
                int newID = command.ExecuteNonQuery();

                return newID;
            }
            
        }

        //Item
        public List<ItemModel> GetItem_All()
        {
            List<ItemModel> returnList = new List<ItemModel>();

            // access the database
            using (SqlConnection connection = new SqlConnection(GlobalConfig.CnnString(db)))
            {

                string sqlQuery = "SELECT RQCL_ITEM_ID, NOME, TSIS_USUCOD FROM RQCL_ITEM where NOME is not null";
                SqlCommand command = new SqlCommand(sqlQuery, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        ItemModel item = new ItemModel();
                        item.Item_Id = reader.GetInt32(0);
                        item.Nome = reader.GetString(1);
                        item.Tsis_usucod = reader.GetInt32(2);

                        returnList.Add(item);
                    }
                }

            }

            return returnList;
        }


    }

}