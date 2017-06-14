import random
import numpy as np
i=0
test = ['AmericanSteelProblem.lp', 'BeerDistributionProblem.lp', 'ColonellBlotto.lp', 'ComputerPlantProblem.lp', 'Furniture.lp', 'Gams10a.lp', 
        'SpongeRollProblem.lp', 'Szach.lp' , 'WhiskasModel.lp', 'WhiskasModel2.lp']

#
# Rozne implementacje pivot rules
#

# 1. Porzadek leksykograficzny, minimum

def lexi_min_in(self):
	return min(self.possible_entering())

def lexi_min_out(self):
	return min(self.possible_leaving())

# 2. Porzadek leksykograficzny, maximum

def lexi_max_in(self):
	return max(self.possible_entering())

def lexi_max_out(self):
	return max(self.possible_leaving())

# 3. Najwiekszy wsp funkcji celu
def max_wsp_in(self):
    wsp = {}
    for n in self.possible_entering():
        i = list(self.nonbasic_variables()).index(n)
        wsp[n] = self.objective_coefficients()[i]
	return max(wsp.iteritems(),key=operator.itemgetter(1))[0]

def max_wsp_out(self):
	return self.possible_leaving()[0]

# 4. Najmniejszy wsp funkcji celu
def min_wsp_in(self):
    wsp = {}
    for n in self.possible_entering():
        i = list(self.nonbasic_variables()).index(n)
        wsp[n] = self.objective_coefficients()[i]
	return min(wsp.iteritems(),key=operator.itemgetter(1))[0]

def min_wsp_out(self):
	return self.possible_leaving()[0]

# 5. Losowy

def los_in(self):
	return random.choice(self.possible_entering())

def los_out(self):
	return random.choice(self.possible_leaving())

# 6. Wybor zmiennej, ktory prowadzi do najwiekszego wzrostu funkcji celu

def ObjectiveValues(self):
    val = {}
    for v1 in self.possible_entering():
        temp1 = deepcopy(self)
        temp1.enter(v1)
        for v2 in temp1.possible_leaving():
            temp2 = deepcopy(temp1)
            temp2.leave(v2)
            temp2.update()
            val[(v1, v2)] = temp2.objective_value()
    return val

## rozpatrujemy mozliwe wejscia problemu self
## petla for po zmiennych nalezacych do self.possible_entering
## tworzymy zmienna temp1 - kopie self i dodajemy tam rozpatrywana v1
## petla for w srodku robi to samo co poprzenida ale dla temp1
## ale wywala to co by³o ropatrywane
## zapisujemy w val wartoœæ funkcji celu dla danych v1 i v2
## zwracamy slownik wartosci val

def max_wzrost_in(self):
    val = ObjectiveValues(self)
    return max(val.iteritems(), key=operator.itemgetter(1))[0][0]
    
def max_wzrost_out(self):
    val = ObjectiveValues(self)
    return max(val.iteritems(), key=operator.itemgetter(1))[0][1]

# 7. Wybor zmiennej, ktory prowadzi do najmniejszego wzrostu funkcji celu

def min_wzrost_in(self):
    val = ObjectiveValues(self)
    return min(val.iteritems(), key=operator.itemgetter(1))[0][0]
    
def min_wzrost_out(self):
    val = ObjectiveValues(self)
    return min(val.iteritems(), key=operator.itemgetter(1))[0][1]

# 8. Wybor zmiennej, ktora goni gradient funkcji celu

def gradient_in(self):
    wart = {}
    for v in self.possible_entering():
        prob1 = deepcopy(self)
        prob1.enter(v)
        for w in prob1.possible_leaving():
            prob2 = deepcopy(prob1)
            prob2.leave(w)
            prob2.update()
            roznica = prob2.basic_solution()-self.basic_solution()
			#roznica = roznica/np.linalg.norm(roznica)
            wart[(v, w)] = np.dot(self.objective_coefficients(), roznica)
    return max(wart.iteritems(), key=operator.itemgetter(1))[0][0]

def gradient_out(self):
    wart = {}
    for v in self.possible_entering():
        prob1 = deepcopy(self)
        prob1.enter(v)
        for w in prob1.possible_leaving():
            prob2 = deepcopy(prob1)
            prob2.leave(w)
            prob2.update()
            roznica = prob2.basic_solution()-self.basic_solution()
			#roznica = roznica/np.linalg.norm(roznica)
            wart[(v, w)] = np.dot(self.objective_coefficients(), roznica)
    return max(wart.iteritems(), key=operator.itemgetter(1))[0][1]
    
    

f = open('lexi_max_out.txt','w')
##############################################################
# Wybor funkcji pivot
#



def my_entering(self):
    #return lexi_min_in(self)
    return lexi_max_in(self)
    #return max_wsp_in(self)
    #return min_wsp_in(self)
    #return los_in(self)
    #return max_wzrost_in(self)
    #return min_wzrost_in(self)
    #return gradient_in(self)

def my_leaving(self):
    #return lexi_min_out(self)
    return lexi_max_out(self)
    #return max_wsp_out(self)
    #return min_wsp_out(self)
    #return los_out(self)
    #return max_wzrost_out(self)
    #return min_wzrost_out(self)
    #return gradient_out(self)

#
# Definicja problemu
#


for t in test:

    with open(t, 'r') as lpfile:
        LP=lpfile.read()

##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################
##############################################################################

	from sage.misc.html import HtmlFragment
	import types

	def my_run_simplex_method(self):
		output = []
		while not self.is_optimal():
			self.pivots += 1
			if self.entering() is None:
				self.enter(self.pivot_select_entering())
			if self.leaving() is None:
				if self.possible_leaving():
					self.leave(self.pivot_select_leaving())

			output.append(self._html_())
			if self.leaving() is None:
				output.append("The problem is unbounded in $()$ direction.".format(latex(self.entering())))
				break
			output.append(self._preupdate_output("primal"))
			self.update()
		if self.is_optimal():
			output.append(self._html_())
		return HtmlFragment("\n".join(output))

	#
	# Parsowanie danych
	#

	class Matrix:
		""" output matrix class """
		
		class Objective:
			def __init__(self, expression, sense, name):
				if name:
					self.name = name[int(0)]
				else:
					self.name = ""
				self.sense = sense # 1 is minimise, -1 is maximise
				self.expression = expression # a dict with variable names as keys, and coefficients as values

		class Constraint:
			def __init__(self, expression, sense, rhs, name):
				if name:
					self.name = name[int(0)]
				else:
					self.name = ""
				self.sense = sense # 1 is geq, 0 is eq, -1 is leq
				self.rhs = rhs
				self.expression = expression
		
		class Variable:
			def __init__(self, bounds, category, name):
				self.name = name
				self.bounds = (bounds["lb"], bounds["ub"]) # a tuple (lb, ub)
				self.category = category # 1 for int, 0 for linear

		def __init__(self, parserObjective, parserConstraints, parserBounds, parserGenerals, parserBinaries):

			self.objective = Matrix.Objective(varExprToDict(parserObjective.varExpr), objSenses[parserObjective.objSense], parserObjective.name)
			
			self.constraints = [Matrix.Constraint(varExprToDict(c.varExpr), constraintSenses[c.sense], c.rhs, c.name) for c in parserConstraints]
			
			boundDict = getBoundDict(parserBounds, parserBinaries) # can't get parser to generate this dict because one var can have several bound statements
			
			allVarNames = set()
			allVarNames.update(self.objective.expression.keys())
			for c in self.constraints:
				allVarNames.update(c.expression.keys())
			allVarNames.update(parserGenerals)
			allVarNames.update(boundDict.keys())
			
			self.variables = [Matrix.Variable(boundDict[vName], ((vName in list(parserGenerals)) or (vName in list(parserBinaries))), vName) for vName in allVarNames]

		def __repr__(self):
			return "Objective%s\n\nConstraints (%d)%s\n\nVariables (%d)%s" \
			%("\n%s %s %s"%(self.objective.sense, self.objective.name, str(self.objective.expression)), \
			  len(self.constraints), \
			  "".join(["\n(%s, %s, %s, %s)"%(c.name, str(c.expression), c.sense, c.rhs) for c in self.constraints]), \
			  len(self.variables), \
			  "".join(["\n(%s, %s, %s)"%(v.name, str(v.bounds), v.category) for v in self.variables]))

		def getInteractiveLPProblem(self):
			A = [[0 for x in range(len(self.variables))] for y in range(len(self.constraints))]
			b = [0] * len(self.constraints)
			c = [0] * len(self.variables)

			for i, constraint in enumerate(self.constraints):
				for v, a in constraint.expression.iteritems():
					if constraint.sense == 1:
						A[i][map(lambda x: x.name, self.variables).index(v)] = -a
					else:
						A[i][map(lambda x: x.name, self.variables).index(v)] = a

					if constraint.sense == 1:		
						b[i] = -constraint.rhs
					else:
						b[i] = constraint.rhs 

			for v, a in self.objective.expression.iteritems():
				if self.objective.sense == 1:
					c[map(lambda x: x.name, self.variables).index(v)] = -a
				else:
					c[map(lambda x: x.name, self.variables).index(v)] = a

			AA = ()
			bb = ()
			cc = ()

			for a in A:
				aaa=[]
				for aa in a:
					aaa.append(aa*int(10000))        
				AA = AA + (list(aaa),)
			for b in b:
				bb = bb + (b*int(10000),)
			for c in c:
				cc = cc + (c*int(10000),)

			lpp = InteractiveLPProblemStandardForm(AA,bb,cc)

			for i, v in enumerate(self.variables):
				if v.bounds[int(1)] < infinity:
					coef = [0,] * len(self.variables)
					coef[i] = 1
					lpp = lpp.add_constraint((coef), v.bounds[int(1)]*int(10000))
				if v.bounds[int(0)] > -infinity:
					coef = [0,] * len(self.variables)
					coef[i] = -1
					lpp = lpp.add_constraint((coef), -v.bounds[int(0)]*int(10000))

			return lpp

	def varExprToDict(varExpr):
		return dict((v.name[int(0)], v.coef) for v in varExpr)

	def getBoundDict(parserBounds, parserBinaries):
		boundDict = defaultdict(lambda: {"lb": -infinity, "ub": infinity}) # need this versatility because the lb and ub can come in separate bound statements

		for b in parserBounds:
			bName = b.name[int(0)]
			
			# if b.free, default is fine

			if b.leftbound:
				if constraintSenses[b.leftbound.sense] >= 0: # NUM >= var
					boundDict[bName]["ub"] = b.leftbound.numberOrInf

				if constraintSenses[b.leftbound.sense] <= 0: # NUM <= var
					boundDict[bName]["lb"] = b.leftbound.numberOrInf
			
			if b.rightbound:
				if constraintSenses[b.rightbound.sense] >= 0: # var >= NUM
					boundDict[bName]["lb"] = b.rightbound.numberOrInf

				if constraintSenses[b.rightbound.sense] <= 0: # var <= NUM
					boundDict[bName]["ub"] = b.rightbound.numberOrInf
		
		for bName in parserBinaries:
			boundDict[bName]["lb"] = 0
			boundDict[bName]["ub"] = 1

		return boundDict
		

	def multiRemove(baseString, removables):
		""" replaces an iterable of strings in removables 
			if removables is a string, each character is removed """
		for r in removables:
			try:
				baseString = baseString.replace(r, "")
			except TypeError:
				raise (TypeError, "Removables contains a non-string element")
		return baseString

	from pyparsing import *
	from sys import argv, exit
	from collections import defaultdict

	MINIMIZE = 1
	MAXIMIZE = -1

	objSenses = {"max": MAXIMIZE, "maximum": MAXIMIZE, "maximize": MAXIMIZE, \
				 "min": MINIMIZE, "minimum": MINIMIZE, "minimize": MINIMIZE}

	GEQ = 1
	EQ = 0
	LEQ = -1

	constraintSenses = {"<": LEQ, "<=": LEQ, "=<": LEQ, \
						"=": EQ, \
						">": GEQ, ">=": GEQ, "=>": GEQ}

	infinity = 1E30

	def read(fullDataString):
		#name char ranges for objective, constraint or variable
		allNameChars = alphanums + "!\"#$%&()/,.;?@_'`{}|~"
		firstChar = multiRemove(allNameChars, nums + "eE.") #<- can probably use CharsNotIn instead
		name = Word(firstChar, allNameChars, max=255)
		keywords = ["inf", "infinity", "max", "maximum", "maximize", "min", "minimum", "minimize", "s.t.", "st", "bound", "bounds", "bin", "binaries", "binary", "gen",  "general", "end"]
		pyKeyword = MatchFirst(map(CaselessKeyword, keywords))
		validName = ~pyKeyword + name
		validName = validName.setResultsName("name")

		colon = Suppress(oneOf(": ::"))
		plusMinus = oneOf("+ -")
		inf = oneOf("inf infinity", caseless=True)
		number = Word(nums+".")
		sense = oneOf("< <= =< = > >= =>").setResultsName("sense")

		# section tags
		objTagMax = oneOf("max maximum maximize", caseless=True)
		objTagMin = oneOf("min minimum minimize", caseless=True)
		objTag = (objTagMax | objTagMin).setResultsName("objSense")

		constraintsTag = oneOf(["subj to", "subject to", "s.t.", "st"], caseless=True)

		boundsTag = oneOf("bound bounds", caseless=True)
		binTag = oneOf("bin binaries binary", caseless=True)
		genTag = oneOf("gen general", caseless=True)

		endTag = CaselessLiteral("end")

		# coefficient on a variable (includes sign)
		firstVarCoef = Optional(plusMinus, "+") + Optional(number, "1")
		firstVarCoef.setParseAction(lambda tokens: eval("".join(tokens))) #TODO: can't this just be eval(tokens[0] + tokens[1])?

		coef = plusMinus + Optional(number, "1")
		coef.setParseAction(lambda tokens: eval("".join(tokens))) #TODO: can't this just be eval(tokens[0] + tokens[1])?

		# variable (coefficient and name)
		firstVar = Group(firstVarCoef.setResultsName("coef") + validName)
		var = Group(coef.setResultsName("coef") + validName)

		# expression
		varExpr = firstVar + ZeroOrMore(var)
		varExpr = varExpr.setResultsName("varExpr")

		# objective
		objective = objTag + Optional(validName + colon) + varExpr
		objective = objective.setResultsName("objective")

		# constraint rhs
		rhs = Optional(plusMinus, "+") + number
		rhs = rhs.setResultsName("rhs")
		rhs.setParseAction(lambda tokens: eval("".join(tokens)))

		# constraints
		constraint = Group(Optional(validName + colon) + varExpr + sense + rhs)
		constraints = ZeroOrMore(constraint)
		constraints = constraints.setResultsName("constraints")

		# bounds
		signedInf = (plusMinus + inf).setParseAction(lambda tokens:(tokens[int(0)] == "+") * infinity)
		signedNumber = (Optional(plusMinus, "+") + number).setParseAction(lambda tokens: eval("".join(tokens)))  # this is different to previous, because "number" is mandatory not optional
		numberOrInf = (signedNumber | signedInf).setResultsName("numberOrInf")
		ineq = numberOrInf & sense
		sensestmt = Group(Optional(ineq).setResultsName("leftbound") + validName + Optional(ineq).setResultsName("rightbound"))
		freeVar = Group(validName + Literal("free"))

		boundstmt = freeVar | sensestmt 
		bounds = boundsTag + ZeroOrMore(boundstmt).setResultsName("bounds")

		# generals
		generals = genTag + ZeroOrMore(validName).setResultsName("generals") 

		# binaries
		binaries = binTag + ZeroOrMore(validName).setResultsName("binaries")

		varInfo = ZeroOrMore(bounds | generals | binaries)

		grammar = objective + constraintsTag + constraints + varInfo + endTag

		# commenting
		commentStyle = Literal("\\") + restOfLine
		grammar.ignore(commentStyle)

		# parse input string
		parseOutput = grammar.parseString(fullDataString)

		# create generic output Matrix object
		m = Matrix(parseOutput.objective, parseOutput.constraints, parseOutput.bounds, parseOutput.generals, parseOutput.binaries)

		return m

	#
	# Parsowanie danych
	#

	m = read(LP)
	P = m.getInteractiveLPProblem()

	#
	# Ustawienie wlasnej funkcji pivot
	#

	D = P.initial_dictionary()

	if not D.is_feasible():
		print ("The initial dictionary is infeasible, solving auxiliary problem.")
		# Phase I
		AD = P.auxiliary_problem().initial_dictionary()
		AD.enter(P.auxiliary_variable())
		AD.leave(min(zip(AD.constant_terms(), AD.basic_variables()))[int(1)])
		AD.run_simplex_method()
		if AD.objective_value() < 0:
			print ("The original problem is infeasible.")
			P._final_dictionary = AD
		else:
			print ("Back to the original problem.")
			D = P.feasible_dictionary(AD)


	D.run_simplex_method = types.MethodType(my_run_simplex_method, D)
	D.pivots = 0

	D.pivot_select_entering = types.MethodType(my_entering, D)
	D.pivot_select_leaving = types.MethodType(my_leaving, D)

	#
	# Algorytm sympleks
	#

	if D.is_feasible():
		D.run_simplex_method()
	f.write("Rozwiazanie problemu ")
	f.write(t)
	f.write("\nNumber of pivot steps: ")
	x=str(D.pivots)
	f.write(x)
	f.write("\n")
	x=str(D.objective_value())
	f.write(x)
	f.write("\n")
	x=str(P.optimal_solution())
	f.write(x)
	f.write("\n")
    i+=1
    print(i)

f.close()