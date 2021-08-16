using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using AppBradyReq.Models;

namespace AppBradyReq.Services.Data
{
    public class SecurityDAO
    {
        string connectionString = @"Data Source=GHOS2023;Initial Catalog=AppSOP_HOM;User ID=sa;Password=Bl@cksheep;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

        internal bool FindByUser(UserModel user)
        {
            bool success = false;

            string queryString = "SELECT TSIS_USUCOD, TSIS_USULOG FROM TSIS_USUARIO WHERE TSIS_USULOG = @Username and TSIS_SENHA = @Password";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {


                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.Add("@Username", System.Data.SqlDbType.VarChar, 255).Value = user.Username;
                command.Parameters.Add("@Password", System.Data.SqlDbType.VarChar, 128).Value = user.Password;

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows)
                    {
                       
                        success = true;
                    }
                    else
                    {
                        success = false;

                    }
                    reader.Close();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    
                }

            }

            return success;

        }



        public int FindIDByUser(string Usuario)
        {

            int UserID = 0;

            string queryString = "SELECT TSIS_USUCOD FROM TSIS_USUARIO WHERE TSIS_USULOG = @Username";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {


                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.Add("@Username", System.Data.SqlDbType.VarChar, 255).Value = Usuario;

                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            UserID = reader.GetInt32(0);
                        }
                     
                    }
                    else
                    {
                        UserID = 0;

                    }
                    reader.Close();
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);

                }

            }

            return UserID;

        }
    }
}