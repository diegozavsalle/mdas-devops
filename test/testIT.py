#! /usr/bin/python3
import json
import os
import requests

print('Ejecutando tests de integracion en Python...')

# print(os.environ)
api_url = 'http://' + os.environ.get('VOTINGAPP_HOST') + '/vote'
headers = {'Content-type': 'application/json'}

##
data = '{"topics":["dev", "ops"]}'
requests.post(api_url, headers=headers, data=data)
print(data)

##
data = '{"topic": "dev"}'
requests.put(api_url, headers=headers, data=data)
print(data)

##
data = '{"topic": "dev"}'
response = requests.delete(api_url, headers=headers)
response_array = json.loads(response.text)
print(data)

expected_winner = "dev"
winner = response_array['winner']

print("expected winner: " + expected_winner)
print("winner: " + winner)

if winner == expected_winner:
    print('TEST PASSED')

else:
    print('TEST FAILED')
