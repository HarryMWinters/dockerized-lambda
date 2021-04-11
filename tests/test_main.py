from lambda_function.main import handler


def test_main_is_importable():
    handler({}, {})
