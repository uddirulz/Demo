import xml.etree.ElementTree as ET

# Path to the XML file
xml_file = "Test-Performance.xml"

# Parse the XML file
tree = ET.parse(xml_file)

# Get the root element
root = tree.getroot()

# Get attributes of the testsuite
testsuite_name = root.attrib["name"]
testsuite_tests = int(root.attrib["tests"])
testsuite_failures = int(root.attrib["failures"])
testsuite_errors = int(root.attrib["errors"])
testsuite_skipped = int(root.attrib["skipped"])

print(f"Testsuite Name: {testsuite_name}")
print(f"Total Tests: {testsuite_tests}")
print(f"Failures: {testsuite_failures}")
print(f"Errors: {testsuite_errors}")
print(f"Skipped: {testsuite_skipped}")
print()

# Get details of each testcase
for testcase in root.findall("testcase"):
    classname = testcase.attrib["classname"]
    name = testcase.attrib["name"]
    failure = testcase.find("failure")

    print(f"Testcase Classname: {classname}")
    print(f"Testcase Name: {name}")

    if failure is not None:
        failure_message = failure.text.strip()
        print(f"Failure Message: {failure_message}")

    print()
