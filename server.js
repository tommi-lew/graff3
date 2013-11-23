var fs = require("fs");
var express = require('express');
var app = express();

app.use(express.logger());
app.use(express.bodyParser());
app.use(express.static(__dirname + '/public'));

app.get('/', function(req, res){
	fs.readFile(__dirname + '/public/index.html', 'utf8', function(err, text){
		res.send(text);
	});
});

app.listen(process.env.PORT || 3000);