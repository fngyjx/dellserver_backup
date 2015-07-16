#!/usr/bin/python

class Car:
	price = 100.00
	color = ""
	name = "" 
	maker = ""
	built = 2000

	def info(self):
		print "%s made by %s in %d colored in %s priced as %f \n" %(self.name,self.maker,self.built,self.color,self.price)


gaoji=Car()

gaoji.price=100000.00
gaoji.color='red'
gaoji.maker='shagua'
gaoji.built=2014
gaoji.name='gaoji'


pianyi=Car()
pianyi.price=10000.00
pianyi.color='white'
pianyi.maker='shihui'
pianyi.built=2014
pianyi.name='pianyi'

gaoji.info()
pianyi.info()


#dictionary = hash

phonebook = {
    "John" : 938477566,
    "Jack" : 938377264,
    "Jill" : 947662781
}

for name, number in phonebook.iteritems():
	print "Phone number of %s is %d \n" %(name, number)

del phonebook['John'] #or phonebook.pop("John")

phonebook['Johny']=1234567890

for name, number in phonebook.iteritems():
        print "Phone number of %s is %d" %(name, number)


