from tkinter import *
from tkinter import messagebox
import sqlite3

def licencia():
    messagebox.showinfo("LICENCIA",gnuglp)

#   ACERCA DE...
def acerca():
    messagebox.showinfo('ACERCA DE...','Creado por Regina N. Molares\npara Codo a Codo 4.0 - Big Data\nMayo, 2022\nEmail: regina.molares@bue.edu.ar')

def conectar():
    global con
    global cur
    con = sqlite3.connect('My_DDBB')
    cur = con.cursor()
    messagebox.showinfo("Status", "Conectado a la base de datos")

def limpiar():
    legajo.set('')
    alumno.set('')
    email.set('')
    calificacion.set('')
    escuela.set('')
    localidad.set('')
    provincia.set('')

def salir():
    resp = messagebox.askquestion("CONFIRME","¿Desea salir del programa?")
    if resp == yes:
        con.close()
        raiz.destroy()

# def prueba_ddbb():
#    conectar()
#    query1 = '''SELECT alumnos.legajo, alumnos.nombre, alumnos.nota, alumnos.email, escuelas.nombre, escuelas.localidad, escuelas.provincia FROM alumnos INNER JOIN escuelas ON alumnos.id_escuela = escuelas._id'''

#    for registro in cur.execute(query1):
#        print(registro) 


raiz = Tk()  #crea la ventana
raiz.title('GUI - Com 22048')   #pone el titulo a la ventana

#BARRA MENÚ
barramenu = Menu(raiz)   #crea la barra de menu
raiz.config(menu=barramenu)   #indica a la ventana que ubuque el menu

bbddmenu= Menu(barramenu, tearoff=0)   #crea submenu BBDD
#BOTON CONECTAR
bbddmenu.add_command(label='Conectar', command=conectar)
#BOTON SALIR
bbddmenu.add_command(label='Salir', command=salir)

limpiarmenu = Menu(barramenu, tearoff=0)
#BOTON DE LIMPIEZA
limpiarmenu.add_command(label='Limpiar campos', command=limpiar)

ayudamenu = Menu(barramenu, tearoff=0)
ayudamenu.add_command(label='Licencia')
ayudamenu.add_command(label='Acerca de...')

bbddmenu.add_cascade(label='BBDD', menu=bbddmenu)   #agrega submenu de DDBB y le asigna sus botones
bbddmenu.add_cascade(label='Limpiar', menu = limpiarmenu)
bbddmenu.add_cascade(label='Acerca de...', menu = ayudamenu)

#FRAMECAMPOS
framecampos = Frame(raiz)
framecampos.pack()

#Variables de control para los entry
legajo = StringVar()
alumno = StringVar()
email = StringVar()
calificacion = DoubleVar()
escuela = StringVar()
localidad = StringVar()
provincia = StringVar()

#Campos entry
legajo_input = Entry(framecampos, textvariable=legajo)
legajo_input.grid(row=0, column=2, padx=10, pady=10)

alumno_input = Entry(framecampos, textvariable=alumno)
alumno_input.grid(row=1, column=2, padx=10, pady=10)

email_input = Entry(framecampos, textvariable=email)
email_input.grid(row=2, column=2, padx=10, pady=10)

calificacion_input = Entry(framecampos, textvariable=calificacion)
calificacion_input.grid(row=3, column=2, padx=10, pady=10)

escuela_input = Entry(framecampos, textvariable=escuela)
escuela_input.grid(row=4, column=2, padx=10, pady=10)

localidad_input = Entry(framecampos, textvariable=localidad)
localidad_input.grid(row=5, column=2, padx=10, pady=10)

provincia_input = Entry(framecampos, textvariable=provincia)
provincia_input.grid(row=6, column=2, padx=10, pady=10)

#Nombrar Campos

legajo_label = Label(framecampos, text='Legajo:')
legajo_label.grid(row=0, column=1, padx=10, pady=10, sticky='e')

alumno_label = Label(framecampos, text='Alumno:')
alumno_label.grid(row=1, column=1, padx=10, pady=10, sticky='e')

email_label = Label(framecampos, text='Email:')
email_label.grid(row=2, column=1, padx=10, pady=10, sticky='e')

calificacion_label = Label(framecampos, text='Calificación:')
calificacion_label.grid(row=3, column=1, padx=10, pady=10, sticky='e')

escuela_label = Label(framecampos, text='Escuela:')
escuela_label.grid(row=4, column=1, padx=10, pady=10, sticky='e')

localidad_label = Label(framecampos, text='Localidad:')
localidad_label.grid(row=5, column=1, padx=10, pady=10, sticky='e')

provincia_label = Label(framecampos, text='Provincia:')
provincia_label.grid(row=6, column=1, padx=10, pady=10, sticky='e')

# FRAME BOTONERA -> Maneja las funciones CRUD (create, read, update, delete)
framebotones = Frame(raiz)
framebotones.pack()

boton_crear = Button(framebotones, text='Crear')
boton_crear.grid(row=0, column=1, padx=5, pady=10, ipadx=10)

boton_buscar = Button(framebotones, text='Buscar')
boton_buscar.grid(row=0, column=2, padx=5, pady=10, ipadx=10)

boton_actualizar = Button(framebotones, text='Actualizar')
boton_actualizar.grid(row=0, column=3, padx=5, pady=10, ipadx=10)

boton_eliminar = Button(framebotones, text='Eliminar')
boton_eliminar.grid(row=0, column=4, padx=5, pady=10, ipadx=10)

# FRAME PIE
framecopy = Frame(raiz)
framecopy.pack()
copylabel = Label(framecopy, text='(2022) por Regina N. Molares para CaC 4.0 - Big Data')
copylabel.grid(row=0, column=0, padx=10, pady=10)

conectar()

raiz.mainloop()