from format_acronyms.format_acronyms import fix_all_lower, fix_all_upper, fix_smart_quotes

SMARTQUOTE_LINE = ["“smartdouble”", "‘smartsingle’"]
SMART_QUOTE_LINE_FIXED = ['"smartdouble"', "'smartsingle'"]
ALL_UPPER_LINE = ["WSDL", "WEB SERVICES DESCRIPTION LANGUAGE"]
ALL_UPPER_LINE_FIXED = ["WSDL", "Web Services Description Language"]
ALL_LOWER_LINE = ["WSDL", "web services description language"]
ALL_LOWER_LINE_FIXED = ["WSDL", "Web Services Description Language"]


def test_fix_smart_quotes():
    assert fix_smart_quotes(SMARTQUOTE_LINE) == SMART_QUOTE_LINE_FIXED


def test_fix_all_upper():
    assert fix_all_upper(ALL_UPPER_LINE) == ALL_UPPER_LINE_FIXED


def test_fix_all_lower():
    assert fix_all_lower(ALL_LOWER_LINE) == ALL_LOWER_LINE_FIXED
