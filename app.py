from flask import Flask,render_template,flash,request,redirect, url_for, session, logging
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from functools import wraps
import json
from flask.json import JSONEncoder
from passlib.hash import sha256_crypt
import os,time,redis
from wtforms import SelectField

from flask_mysqldb import MySQL
import urllib.request
import urllib
import re
import random
import json as json
import codecs
from flask_mail import Mail
from flask.ext.mail import Message,Mail

from gtts import gTTS
import os
import requests
from selenium import webdriver
import selenium.webdriver.chrome.service as service


app = Flask(__name__)
#MySQL configuration
app.config['MYSQL_HOST']='localhost'
app.config['MYSQL_USER']='root'
app.config['MYSQL_PASSWORD']=''
app.config['MYSQL_DB']='smarthome'
app.config['MYSQL_CURSORCLASS']='DictCursor'
mysql=MySQL(app)

#Mail SMTP server setup (in this case gmail)
app.config.update(dict(
Mail_SERVER='smtp.gmail.com',
MAIL_PORT=465,
MAIL_USE_SSL=True,
MAIL_USERNAME='shishaylibe@gmail.com',
MAIL_PASSWORD='tilahun@91'))
mail=Mail(app)
#mail.init_app(app)

app.debug=True
@app.route('/')
def index():
    return render_template('index.html')
@app.route('/about')
def about():
    return render_template('about.html')
def speak(text):
    tts=gTTS(text, lang='en')
    tts.save("error.mp3")
    os.system("mpg321 error.mp3")

class UserRegister(Form):
    userName =StringField('User Name',[validators.Length(min=1,max=50)])
    email=StringField('Email',[
    validators.Length(min=6,max=100),
    validators.DataRequired()])
    myChoice=[('Father','Father'),('Mother','Mother'),('Siblings','Siblings'),('Guest','Guest')]
    userType=SelectField('User Type',choices=myChoice )
    password =PasswordField('Password',[
        validators.DataRequired(),
        validators.EqualTo('confirm',message='Password do not match')

    ])
    confirm=PasswordField('Confirm Password')
@app.route('/Register', methods=['GET','POST'])
def user_Register():
    form =UserRegister(request.form)
    if request.method=='POST' and form.validate():
        # collecting user data from the form
        userName=form.userName.data
        userType=form.userType.data
        email=form.email.data
        password=sha256_crypt.encrypt(str(form.password.data))

        query=mysql.connection.cursor()
        query.execute("INSERT INTO user(userName,email,password,userType) VALUES(%s, %s, %s, %s)",(userName,email,password,userType))
        #execute
        mysql.connection.commit()
        #terminate connection
        query.close()
        #try:
        # ack='You are Successfuly Registered, your email address is'
        # msg=Message('New User Registration',
        #             sender='shishaylibe@gmail.com',
        #             recipients=['shishaylibe@gmail.com'])
        # #msg.body='ack'
        # mail.send(msg)
        flash("New User Registertion Completed Successfuly ",'success')
        return redirect(url_for('index'))
        #except Exception as e:
            #return str(e)

    return render_template('Register.html',form=form)
@app.route('/login', methods=['GET','POST'])
def login():
    if request.method=='POST':
        username=request.form['email']
        formPassword=request.form['password']  #password passed through the form
        query=mysql.connection.cursor()

        fetch=query.execute("SELECT * FROM user WHERE email=%s",[username])

        #if there is any user
        if fetch>0:
            data=query.fetchone()
            password=data['password'] #password retrieved from the database
            userType=data['userType']
            #uName=data['userName']
            #comparing the password provided by the user with the one stored
            if sha256_crypt.verify(formPassword,password):
                #password matches
                session['logged_in']=True
                session['userName']=data['userName']
                session['userType']=data['userType']
                flash('You are Logged In','success')
                text="Welcome, This is your smart Home Assistant"
                speak(text)
                return redirect(url_for('control'))


            else:
                text="Invalid Username and or Password"

                flash("Invalid username and or password",'danger')
                speak(text)

                return render_template('login.html')
            #close connection
            query.close()

        else:
            error='User Not Found'
            return render_template('login.html',error=error)


    return render_template('login.html')


# will check if the user is logged in before loading other pages
def login_required(f):
    @wraps(f)
    def check_loggedIn(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args, **kwargs)
        else:
            text=("Please Login First to gain access")
            #say("Invalid username and password")
            speak(text)
            flash('Please Login First to Gain Access', 'danger')
            return redirect(url_for('login', next=request.url))
    return check_loggedIn

#this function checks user reasons

@app.route('/reason', methods=['POST','GET'])
@login_required
def reason():
    if request.method=='POST':

        try:
            uReason=request.form['uReason']
            with open("reasons1.txt","rt") as infile:
                lns = [ln.rstrip('\n') for ln in infile]
                flash(lns)
                if uReason in lns:


                    # f=infile.readline()
                    #
                    # for line in f:
                    #     flash(line)
                    #     f.infile.readline()
                    #     if uReason in line:

                    with open("orders.txt","rt") as order:
                        lines=[line.rstrip('\n') for line in order]
                        devId=lines[0]
                        newState=lines[1]
                        rand=lines[2]
                        devName=lines[3]
                        devLocation=lines[4]
                        user=lines[5]
                        reason_verified = deviceState(devId,newState,rand)
                        query=mysql.connection.cursor()
                        insert=query.execute("INSERT INTO deviceState(devId,devName,devLocation,devState,userType) VALUES(%s,%s,%s,%s,%s)",(devId,devName,devLocation,newState,user))
                        mysql.connection.commit()
                        mysql.close()
                else:

                    text="Your reason is not strong enough, other member of the family are using the device with more urgency"
                    speak(text)
                    return redirect(url_for('control'))
                if reason_verified:
                    return reason_verified
        except:
            return redirect(url_for('control'))

    return render_template('reason.html')

@app.route('/control', methods=['POST','GET'])
@login_required
def control():

    if request.method=="POST":
        #username=request.form['email']
        userRequest=request.form['uInput']
        if userRequest=='BedROOM-LIGHT-ON':
            devId=508
            newState=1
            devName='Light'
            devLocation='BedROOM'
            user=session['userType']
            rand=random.random()
            reason_verify = verifyState(devId,newState,devName,devLocation,user)

        elif userRequest=='BedROOM-LIGHT-OFF':
            devId=508
            newState=0
            devName='Light'
            devLocation='BedROOM'
            user=session['userType']
            rand=random.random()
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Corridor-LIGHT-ON':
            devId=460
            newState=1
            devName='Light'
            devLocation='Corridor'
            user=session['userType']
            rand=random.random()
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Corridor-LIGHT-OFF':
            devId=460
            newState=0
            devName='Light'
            devLocation='Corridor'
            user=session['userType']
            rand=random.random()
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Kettle-ON':
            devId=19
            newState=1
            devName='Kettle'
            devLocation='Kitchen'
            user=session['userType']
            rand=random.random()
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Kettle-OFF':
            devId=19
            newState=0
            devName='Kettle'
            devLocation='Kitchen'
            user=session['userType']
            rand=random.random()
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Microven-OFF':
            devId = 20
            newState=0
            devName='Microven'
            devLocation='Kitchen'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Microven-ON':
            devId = 20
            newState=1
            devName='Microven'
            devLocation='Kitchen'
            user=session['userType']
            rand=random.random()
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='KitchenDoor-Unlock':
            devId = 14
            newState=0
            devName='Door'
            devLocation='Kitchen'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='KitchenDoor-lock':
            devId = 14
            newState=1
            devName='Door'
            devLocation='Kitchen'
            user=session['userType']
            rand=random.random()
            reason_verify = verifyState(devId,newState,devName,devLocation,user)

        elif userRequest=='BedROOM-HEATER-ON':
            url = "http://10.12.102.156/port_3480/data_request?id=lu_action&output_format=json&DeviceNum=19&serviceId=urn" \
                  ":upnp-org:serviceId:SwitchPower1&action=SetTarget&newTargetValue=0&rand=0.9835083063374366 "
            urllib.request.urlopen(url)
        elif userRequest=='BedROOM-HEATER-OFF':
            url = "http://10.12.102.156/port_3480/data_request?id=lu_action&output_format=json&DeviceNum=19&serviceId=urn" \
                  ":upnp-org:serviceId:SwitchPower1&action=SetTarget&newTargetValue=0&rand=0.9835083063374366 "
            urllib.request.urlopen(url)
        elif userRequest=='LivingROOM-LIGHT-ON':
            devId=507
            newState=1
            devName='Light'
            devLocation='LivingROOM'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)

        elif userRequest=='LivingROOM-LIGHT-OFF':
            devId=507
            newState=0
            devName='Light'
            devLocation='LivingROOM'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)

        elif userRequest=='LivingROOM-LAMP-ON':
            devId=39
            newState=1
            devName='Lamp'
            devLocation='LivingROOM'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)

        elif userRequest=='LivingROOM-LAMP-OFF':
            devId=39
            newState=0
            devName='Lamp'
            devLocation='LivingROOM'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Kettle-ON':
            devId=19
            newState=1
            devName='Kettle'
            devLocation='kitchen'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Kettle-OFF':
            devId=19
            newState=0
            devName='Kettle'
            devLocation='Kitchen'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Music-OFF':
            devId=21
            newState=0
            devName='Radio'
            devLocation='Kitchen'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='Music-ON':
            devId=21
            newState=1
            devName='Radio'
            devLocation='Kitchen'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='LivingROOM-HEATER-ON':
            url = "http://10.12.102.156/port_3480/data_request?id=lu_action&output_format=json&DeviceNum=19&serviceId=urn" \
                  ":upnp-org:serviceId:SwitchPower1&action=SetTarget&newTargetValue=0&rand=0.9835083063374366 "
            urllib.request.urlopen(url)
        elif userRequest=='LivingROOM-HEATER-OFF':
            url = "http://10.12.102.156/port_3480/data_request?id=lu_action&output_format=json&DeviceNum=19&serviceId=urn" \
                  ":upnp-org:serviceId:SwitchPower1&action=SetTarget&newTargetValue=0&rand=0.9835083063374366 "
            urllib.request.urlopen(url)
        elif userRequest=='KitchenROOM-LIGHT-ON':
            devId=463
            newState=1
            devName='Light'
            devLocation='Kitchen'
            rand=random.random()
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)

        elif userRequest=='KitchenROOM-LIGHT-OFF':
            devId=463
            newState=0
            devName='Light'
            devLocation='Kitchen'
            user=session['userType']
            reason_verify = verifyState(devId,newState,devName,devLocation,user)
        elif userRequest=='KitchenROOM-HEATER-OFF':
            url = "http://10.12.102.156/port_3480/data_request?id=lu_action&output_format=json&DeviceNum=19&serviceId=urn" \
                  ":upnp-org:serviceId:SwitchPower1&action=SetTarget&newTargetValue=0&rand=0.9835083063374366 "
            urllib.request.urlopen(url)
        elif userRequest=='KitchenROOM-HEATER-ON':
            url = "http://10.12.102.156/port_3480/data_request?id=lu_action&output_format=json&DeviceNum=19&serviceId=urn" \
                  ":upnp-org:serviceId:SwitchPower1&action=SetTarget&newTargetValue=0&rand=0.9835083063374366 "
            urllib.request.urlopen(url)
            return ''
        else:
            return 'No Request Received'
        if reason_verify:
            return reason_verify
    return render_template('control.html')

def verifyState(devId,newState,devName,devLocation,user):

    rand=random.random()
    response=urllib.request.urlopen("http://10.12.102.156:3480/data_request?id=status&output_format=json&DeviceNum=%s"%(devId))
    str_response=response.read().decode('utf-8')
    states=json.loads(str_response)['Device_Num_'+str(devId)]['states']

    for state in states:
        if state["variable"] == "Status":
            devState = state["value"]
            if devState == str(newState):
                text="device is on the same state as you requested"
                flash("Sorry, Device is on the same state as you requested",'danger')
                speak(text)

            else:
                # we can add  if statement here to check who has changed the device and
                # so that we can maintain priority for certain users
                query=mysql.connection.cursor()
                fetch=query.execute("SELECT * FROM deviceState WHERE devId=%s ORDER BY Id DESC",[devId])
                if fetch>0:
                    data=query.fetchone()
                    userT=data['userType']
                    #reason=data['reason']
                    if user=='Mother' or user== 'Father':
                        deviceState(devId,newState,rand)
                        #update the database
                        insert=query.execute("INSERT INTO deviceState(devId,devName,devLocation,devState,userType) VALUES(%s,%s,%s,%s,%s)",(devId,devName,devLocation,newState,user))
                        mysql.connection.commit()
                        query.close()
                    elif user!=userT:
                        if (userT =='Father' or userT == 'Mother'):
                            #flash('Sorry, Older member of the family is  using device, Please provide your reason','danger')
                            text='Sorry, Older member of the family is  using device, Please provide your reason'
                            speak(text)
                            with open("orders.txt","r+") as userOrder:
                                userOrder.write(str(devId)+"\n")
                                userOrder.write(str(newState)+"\n")
                                userOrder.write(str(rand)+"\n")
                                userOrder.write(str(devName)+"\n")
                                userOrder.write(str(devLocation)+"\n")
                                userOrder.write(str(user)+"\n")
                                return redirect(url_for('reason'))

                        #elif reason=='Health' or 'Security':
                        #    flash('Other member of the family is using device for Security or Health reason, Please try again later','danger')
                        else:
                            deviceState(devId,newState,rand)
                            #update the database
                            insert=query.execute("INSERT INTO deviceState(devId,devName,devLocation,devState,userType) VALUES(%s,%s,%s,%s,%s)",(devId,devName,devLocation,newState,user))
                            mysql.connection.commit()
                            query.close()

                    else:
                       deviceState(devId,newState,rand)
                       #update the database
                       insert=query.execute("INSERT INTO deviceState(devId,devName,devLocation,devState,userType) VALUES(%s,%s,%s,%s,%s)",(devId,devName,devLocation,newState,user))
                       mysql.connection.commit()
                       query.close()
                else:
                    # create new entries
                    deviceState(devId,newState,rand)
                    insert=query.execute("INSERT INTO deviceState(devId,devName,devLocation,devState,userType) VALUES(%s,%s,%s,%s,%s)",(devId,devName,devLocation,newState,user))
                    mysql.connection.commit()
                    query.close()

                    #time.sleep(0.3)

        elif state["variable"]=="Armed":
            state = state["value"]
            if state == str(newState):
                text="Device is on the same state as you requested"
                speak(text)
                flash('Device is on the same state as you requested','danger')
                return render_template('control.html')
            else:

                doorState(devId,newState,rand)
            break

    return None
#this function changes the device state
def loader():

    return redirect(url_for('control'))


def deviceState(devId,newState,rand):
    try:
        response = "http://10.12.102.156/port_3480/data_request?id=lu_action&output_format=json&DeviceNum=%s&serviceId=urn" \
        ":upnp-org:serviceId:SwitchPower1&action=SetTarget&newTargetValue=%s&rand=%s "%(devId,newState,rand)
        urllib.request.urlopen(response)
        text="Changing the device state"
        speak(text)
        reload = loader()
        #return redirect(url_for('control'))
    except:
        flash('error')
    if reload:
        return reload
    return render_template('reason')
    #return render_template('control.html')
def doorState(devId,newState,rand):
    response="http://10.12.102.156/port_3480/data_request?id=lu_action&output_format=json&DeviceNum=%s&serviceId=" \
    "urn:micasaverde-com:serviceId:SecuritySensor1&action=SetArmed&newArmedValue=%s&rand=%s "%(devId,newState,rand)
    urllib.request.urlopen(response)
    #flash("Changing the device state",'success')
    text="Changing the device state"
    speak(text)
    return redirect(url_for('control'))
@app.route('/logout')
def logout():
    session.clear()
    flash('You are Logged Out','success')
    text="Goodbye,You are Logged Out"
    speak(text)
    return redirect(url_for('index'))
@app.route('/loaderio-9abe3c0e8b5c7814ec7746dd288f31d3')
def loaderio9abe3c0e8b5c7814ec7746dd288f31d3():
    return render_template('loaderio-9abe3c0e8b5c7814ec7746dd288f31d3.html')
if __name__=='__main__':
    app.secret_key='secret123' #cross-site request forgery (CSRF) protection
    app.run(host='0.0.0.0',port=5000)
