from os import curdir
from tkinter import *
from tkinter import messagebox
import sqlite3 as sq3

raiz = Tk() # crea la ventana ppal
raiz.title('GUI - Com 22048') # pone título a la ventana ppal

#PARTE FUNCIONAL

# Menú base de datos
def conectar():
    global con
    global cur
    con = sq3.connect('mi_bbdd.db')
    cur = con.cursor()
    messagebox.showinfo("STATUS","¡Conectado a la BBDD!")

def salir():
    resp = messagebox.askquestion("CONFIRME","¿Desea salir del programa?")
    if resp == "yes":
        con.close()
        raiz.destroy()

# Menú para limpiar
def limpiar():
    legajo.set('')
    alumno.set('')
    email.set('')
    calificacion.set('')
    grado.set('')
    escuela.set('Seleccione')
    localidad.set('')
    provincia.set('')
    legajo_input.config(state='normal')

# Menú acerca de
#Licencia
def licencia():
    # CREATIVE COMMONS GNU GPL https://www.gnu.org/licenses/gpl-3.0.txt
    gnuglp = messagebox.showinfo("LICENCIA",gnuglp)

# Acerca de...
def acerca():
    messagebox.showinfo('ACERCA DE...','Creado por Regina N. Molares\npara Codo a Codo 4.0 - Big Data\nMayo, 2022\nEmail: regina.molares@bue.edu.ar')

# Funciones
def buscar_escuelas(actualiza):
    con = sq3.connect('mi_base.db')
    cur = con.cursor()

    if actualiza:
        cur.execute('SELECT _id, localidad, provincia FROM escuelas WHERE nombre = ?',(escuela.get(),))
    else:
        cur.execute('SELECT nombre FROM escuelas')
    
    resultado = cur.fetchall()
    print(resultado)
    retorno = []
    for e in resultado:
        if actualiza:
            provincia.set(e[2])
            localidad.set(e[1])
        esc = e[0]
        retorno.append(esc)

    #print(resultado) # ->> ver el formato de lista de tupla con 2do elemento fantasma
    #print(retorno)
    con.close()
    return retorno
# Crear
def crear():
    id_escuela = int(buscar_escuelas(True)[0])
    datos = id_escuela, legajo.get(), alumno.get(), calificacion.get(), email.get()
    cur.execute("INSERT INTO alumnos (id_escuela, legajo, nombre, nota, email) VALUES (?,?,?,?,?)", datos)
    con.commit()
    messagebox.showinfo("STATUS","Registro agregado!")
    limpiar()
# Buscar
def buscar():
    query_leer = '''SELECT alumnos.legajo, alumnos.nombre, alumnos.nota, alumnos.email, alumnos.grado,
    escuelas.nombre, escuelas.localidad, escuelas.provincia FROM alumnos 
    INNER JOIN escuelas ON alumnos.id_escuela = escuelas._id WHERE alumnos.legajo ='''
    cur.execute(query_leer + legajo.get())
    resultado = cur.fetchall()
    if resultado == []:
        messagebox.showerror("ERROR","No existe ese N° de legajo")
        legajo.set('')
    else:
        for campo in resultado:
            legajo.set(campo[0])
            alumno.set(campo[1])
            calificacion.set(campo[2])
            email.set(campo[3])
            grado.set(campo[4])
            escuela.set(campo[5])
            localidad.set(campo[6])
            provincia.set(campo[7])
            legajo_input.config(state='disabled')
# Actualizar
def actualizar():
    id_escuela = int(buscar_escuelas(True)[0])
    datos = id_escuela, alumno.get(), calificacion.get(), email.get()
    cur.execute("UPDATE alumnos SET id_escuela =?, nombre=?, nota=?, email=? WHERE legajo =" + legajo.get(), datos)
    con.commit()
    messagebox.showinfo("STATUS", "Registro actualizado")
    limpiar()
# Borrar
def borrar():
    resp = messagebox.askquestion("ELIMINAR","¿Desea eliminar el registro?")
    if resp == "yes":
        cur.execute("DELETE FROM alumnos WHERE legajo =" + legajo.get())
        con.commit()
        messagebox.showinfo("STATUS","Registro eliminado")
        limpiar()

# Otras funciones
def buscar_escuela(actualiza):
    con = sq3.connect('mi_bbdd.db')
    cur = con.cursor()
    if actualiza:
        pass
    else:
        cur.execute('SELECT nombre FROM escuelas')
        escuela.set("Seleccione")

    resultado = cur.fetchall()
    retorno = []
    for e in resultado:
        if actualiza:
            provincia.set(e)
            localidad.set(e)
        esc = e[0]
        retorno.append(esc)
   
    con.close()
    return retorno

'''
       INTERFAZ GRÁFICA
'''
#Barramenu
barramenu = Menu(raiz) # crea la barra del menú
raiz.config(menu=barramenu) # indica a la ventana ppal que ubique al menú

bbddmenu = Menu(barramenu, tearoff=0) # crea submenú BBDD
# BotónConectar
bbddmenu.add_command(label='Conectar', command=conectar)
# BotónSalir
bbddmenu.add_command(label='SALIR',command=salir)

limpiarmenu = Menu(barramenu, tearoff=0)
# creo boton limpiar
limpiarmenu.add_command(label='Limpiar campos', command=limpiar)

ayudamenu = Menu(barramenu, tearoff=0)
ayudamenu.add_command(label='Licencia', command=licencia)
ayudamenu.add_command(label='Acerca de...', command=acerca)

barramenu.add_cascade(label='BBDD', menu=bbddmenu) # agrega el botón ppal del submenú BBDD y le asigna sus botones
barramenu.add_cascade(label='Limpiar',menu=limpiarmenu)
barramenu.add_cascade(label='Acerca de...',menu=ayudamenu)

# FRAMECAMPOS
framecampos = Frame(raiz)
framecampos.pack()

# Variables de control para los Entry
legajo = StringVar()
alumno = StringVar()
email = StringVar()
calificacion = DoubleVar()
grado = IntVar()
escuela = StringVar()
localidad = StringVar()
provincia = StringVar()

# Campos Entry
legajo_input = Entry(framecampos,textvariable=legajo)
legajo_input.grid(row=0, column=2, padx=10, pady=10)

alumno_input = Entry(framecampos, textvariable=alumno)
alumno_input.grid(row=1, column=2, padx=10, pady=10)

email_input = Entry(framecampos, textvariable=email)
email_input.grid(row=2, column=2, padx=10, pady=10)

grado_input = Entry(framecampos, textvariable=grado)
grado_input.grid(row=3, column=2, padx=10, pady=10)

calificacion_input = Entry(framecampos,textvariable=calificacion)
calificacion_input.grid(row=4, column=2, padx=10, pady=10)

#escuela_input = Entry(framecampos, textvariable=escuela)
#escuela_input.grid(row=5, column=2, padx=10, pady=10)
escuelas = buscar_escuela(False)
escuela_option = OptionMenu(framecampos, escuela,*escuelas)
escuela_option.grid(row=5, column=2, padx=10, pady=10)

localidad_input = Entry(framecampos, textvariable=localidad, state='readonly')
localidad_input.grid(row=6, column=2, padx=10, pady=10)

provincia_input = Entry(framecampos, textvariable=provincia, state='readonly')
provincia_input.grid(row=7, column=2, padx=10, pady=10)

# Labels
legajo_label = Label(framecampos, text='Legajo:')
legajo_label.grid(row=0, column=1, padx=10, pady=10, sticky='e')

alumno_label = Label(framecampos, text='Alumno:')
alumno_label.grid(row=1, column=1, padx=10, pady=10, sticky='e')

email_label = Label(framecampos, text='Email:')
email_label.grid(row=2, column=1, padx=10, pady=10, sticky='e')

grado_label = Label(framecampos, text='Grado:')
grado_label.grid(row=3, column=1, padx=10, pady=10, sticky='e')

calificacion_label = Label(framecampos, text='Calificación:')
calificacion_label.grid(row=4, column=1, padx=10, pady=10, sticky='e')

escuela_label = Label(framecampos, text='Escuela:')
escuela_label.grid(row=5, column=1, padx=10, pady=10, sticky='e')

localidad_label = Label(framecampos, text='Localidad:')
localidad_label.grid(row=6, column=1, padx=10, pady=10, sticky='e')

provincia_label = Label(framecampos, text='Provincia:')
provincia_label.grid(row=7, column=1, padx=10, pady=10, sticky='e')

# FRAME BOTONERA -> Maneja las funciones CRUD (create, read, update, delete)
framebotones = Frame(raiz)
framebotones.pack()

boton_crear = Button(framebotones, text='Crear')
boton_crear.grid(row=0, column=1, padx=5, pady=10, ipadx=10)

boton_buscar = Button(framebotones, text='Buscar',command=buscar)
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

buscar_escuela(False)

raiz.mainloop()