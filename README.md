# json_forms

A package to make forms faster. Just write a JSON file and the Widgets will be generated

## Getting Started

### Usage

```dart
Widget widget = JsonForm.fromJson(yourJson);
```

Available question's types :
 - Text
 - Number
 - Bool
 - Radio
 - Pick
 - CheckTable
 - OptionalQuantityTable (yes, I could have found a better name :) )


Example of JSON file
```json
{ // Form Object
  "name": "The form's name",
  "sections": [ // List of Section objects
    {
      "name": "Name of the first section",
	  "questions": [ // List of Question Object
	    {
		  "id": 0,
		  "text": "What's your name ?",
		  "type": "Text",
		  "value": null,
		  "possibilities": null,
		  "condition": null,
		  "placeholder": "Name",
		  "invalidMessageKey": "The field is empty, please put your name",
		  "isRequired": true
		},
		{
		  "id": 1,
		  "text": "What's your gender ?",
		  "type": "Radio",
		  "value": "male",
		  "possibilities": [
		    "male",
			"female"
		  ],
		  "condition": null,
		  "invalidMessageKey": "empty",
		  "isRequired": false
		},
		{
		  "id": 2,
		  "text": "How old are you ?",
		  "type": "Number",
		  "value": null,
		  "possibilities": null,
		  "condition": {
		    "questionId": 1,
		    "value": "male"
		  },
		  "placeholder": "Your age",
		  "invalidMessageKey": "empty",
		  "isRequired": false
		}
	  ]
	},
	{
	  "name": "Name of the second section",
	  "questions":[
	    {
		  "id": 3,
		  "text": "Do you have any pets ?",
					"type": "CheckTable",
					"value": ["cat", "snake"],
					"possibilities": ["cat", "dog", "snake", "spider", "bird", "fish", "rabbit"],
					"condition": null,
					"invalidMessageKey": "empty",
					"isRequired": false
				},
				{
					"id": 4,
					"text": "What is the color of your fish ?",
					"type": "Pick",
					"value": "blue",
					"possibilities": ["blue", "black", "red", "yellow", "green"],
					"condition": {
						"questionId": 3,
						"value": "fish"
					},
					"invalidMessageKey": "empty",
					"isRequired": false
				},
				{
					"id": 5,
					"text": "Do you like this form ?",
					"type": "Bool",
					"value": false,
					"possibilities": null,
					"condition": null,
					"isRequired": false
				},
				{
					"id": 6,
					"text": "Rate this form",
					"type": "Radio",
					"value": 4,
					"possibilities": [1,2,3,4,5],
					"condition": null,
					"isRequired": false
				}
			]
		},
		{
			"name": "Last section",
			"questions": [
				{
					"id": 7,
					"text": "Do you have any pets ?",
					"type": "OptionalQuantityTable",
					"value": null,
					"possibilities": ["cat", "dog", "fish"],
					"condition": null,
					"invalidMessageKey": "empty",
					"isRequired": false
				}
			]
		}
	]
}
```
