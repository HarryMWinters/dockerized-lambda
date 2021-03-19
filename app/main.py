import pprint


def handler(event, context) -> str:
    pprint.pprint(event)
    pprint.pprint(context)

    return "Hello from lambda"
