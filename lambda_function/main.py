import pprint
from typing import Any
from typing import Dict


def handler(event: Dict[str, Any], context: Dict[str, Any]) -> str:
    pprint.pprint(event)
    pprint.pprint(context)

    return "Hello from lambda"
