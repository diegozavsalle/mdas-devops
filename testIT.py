#! /usr/bin/python3
import json
import requests


def test_it():
    print("Ejecutando tests de integración en Python...")

    api_url = 'http://localhost:8080/vote'
    headers = {'Content-type': 'application/json'}

    ##
    data = '{"topics":["dev", "ops"]}'
    requests.post(api_url, headers=headers, data=data)

    ##
    data = '{"topic": "dev"}'
    requests.put(api_url, headers=headers, data=data)

    ##
    data = '{"topic": "dev"}'
    response = requests.delete(api_url, headers=headers)
    response_array = json.loads(response.text)

    expected_winner = "dev"
    winner = response_array['winner']

    if winner == expected_winner:
        print('TEST PASSED')
        return 0

    else:
        print('TEST FAILED')
        return 1


test_it()
