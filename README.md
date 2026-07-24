# BookstoreDB-Project
Repositorio académico para la implementación de la base de datos Bookstore.

# 📚 Proyecto Bookstore - Gestión y Analítica de Datos

Este repositorio contiene el diseño, implementación y análisis de la base de datos **Bookstore**, desarrollado como actividad práctica para la Maestría. El proyecto utiliza un enfoque de *Database-as-Code* mediante **SQL Server Database Project** y control de versiones con Git/GitHub.

---

## 👥 Integrantes del Grupo # 4 y Roles

Para maximizar la eficiencia y simular un entorno profesional, distribuimos las actividades entre los 5 integrantes de la siguiente manera:

*   **(Coordinador):** Infraestructura de Git/GitHub, empaquetado del proyecto y documentación final.
*   **(Estructura):** Diseño, normalización y creación de las tablas relacionales.
*   **(Datos):** Generación y carga del script de datos ficticios para pruebas.
*   **(Automatización):** Creación de procedimientos almacenados para operaciones clave.
*   **(Analista):** Consultas analíticas, métricas de negocio y reportes para la toma de decisiones.

---

## 🛠️ Estructura del Modelo de Datos

El sistema consta de **5 tablas principales** totalmente normalizadas que permiten simular la operación comercial de una librería:

1.  `Authors`: Registro de autores de los libros.
2.  `Books`: Catálogo de libros con precios y autores asociados.
3.  `Customers`: Datos de contacto únicos de los clientes.
4.  `Orders`: Cabecera de las transacciones con fechas de compra.
5.  `OrderDetails`: Detalle de productos, cantidades y precios por cada venta (Relación muchos a muchos).

---

## 🚀 Cómo Desplegar el Proyecto

1.  **Clonar el repositorio:** `git clone https://github.com`
2.  **Abrir en Visual Studio:** Ejecutar el archivo del proyecto de base de datos (`.sqlproj`).
3.  **Compilar:** Hacer clic derecho en el proyecto y seleccionar **Build (Compilar)** para verificar que no existan errores de sintaxis.
4.  **Publicar:** Seleccionar **Publish (Publicar)**, apuntar a su instancia local de SQL Server (LocalDB o Servidor Local) y generar la base de datos activa.

---

## 📄 Licencia

Este proyecto está bajo la **Licencia MIT**, lo que permite su libre uso, modificación y distribución con fines académicos.
